clear all;
clc;
close all;
%%  
Nt = 1;    % nomber of TX d'antennas
Nr = 2;    % nomber of RX d'antennas
N  = 4;
Pxp = 10;
Pxd = [90 92 88 86];
Pxt = 100;
Ns_data = 40;
Np = 1;
Ms = 64;
Ng = 0;
w = dftmtx(Ms);
F = w(:,1:N);
Df = [0.015 0.5 0.2 0.025]*1;   % normalized Frequency offset df=300khz 100Khz
% Df =[0.01 0.26 0.4 0.15]*1;   % normalized Frequency offset df=300khz 100Khz
sigmas2 = Pxd;
sigmas = sqrt(sigmas2);
Nc_phi  = pi./[4 2 2 6];
Nc_rate = [0.95 0.85 0.7 1];
Nc_P = Nc_rate.*(exp(1i*Nc_phi)).*sigmas2;
%% Signal Generation
% we use the Zadoff-Chu sequences
U=[1 3 5 7];
ZC_p=[];ZC_d=[];
for u=1:Nt
    for k=1:Ms
        ZC(k,u)=sqrt(Pxp)*exp((-1i*pi*U(u)*(k-1)^2)/Ms);
        ZCd(k,u)=sqrt(Pxd(u))*exp((-1i*pi*U(u)*(k-1)^2)/Ms);
    end
    ZC_p=[ZC_p;ZC(:,u)];
    ZC_d=[ZC_d;ZCd(:,u)];
end
% ZC_d'*ZC_d/(Nt*Ms)
% plot(abs(xcov(ZC(1,:))))

%% ======== Channel gen ================================================================
%load('H2')
%H=H2(1:Nr,1:N,1:Nt);
%H = randn(Nr,N,Nt)+1i*randn(Nr,N,Nt);  % same results with H2
%__________________________________________________________________________
 %--- H = spec_chan(fading,delay,DOA, Nr)  ???
 fading = [0.4 0.6 0.1 0.01;0.3 0.9 0.5 0.3];
 fading = fading';  % of size(N,Nt)
 delay  = [0.4 0.6 0.1 0.4;0.3 0.9 0.5 0.1];
 delay  = delay'; %of size(N,Nt)
 %DOA    = [pi/2 pi/4 pi/6 pi/8;pi/3 pi/4 pi/7 pi/8];
 DOA    = pi./[2 4 6 8;3 4 7 8];
 DOA    = DOA'; % of size(N,Nt)
 
H = spec_chan(fading,delay,DOA,Nr,N,Nt);  % H(Nr,N,Nt)

%__________________________________________________________________________
h=[];h_ifft=[];Cyy_1=zeros(Ms*Nr);Cyy_Nc=zeros(Ms*Nr);Cyy_lambda1=zeros(Nr);
lambda3=[];lambda4=[];
for ii=1:Nt
        h=[h reshape(transpose(H(:,:,ii)),1,Nr*N)];
        lambda(:,:,ii)=transpose(fft(transpose(H(:,:,ii)),Ms));
        h_ifft=[h_ifft reshape(fft(transpose(H(:,:,ii))),1,Nr*N)];
        lambda_i=[]; 
        lambda_2=[];
        for jj=1:Nr
            lambda_i=[lambda_i;(w'/sqrt(Ms))*diag(w*transpose([H(ii,:,jj) zeros(1,Ms-N)]))];
            lambda_2=[lambda_2;F(20,:)*transpose(H(jj,:,ii))];            
        end
        lambda3=[lambda3 lambda_i];
        lambda4=[lambda4 lambda_2];
        lambda2(:,:,ii)=lambda_i;
        temp_lambd(:,:,ii)=lambda_i*lambda_i';
        temp_lambd2(:,:,ii)=lambda_2*lambda_2';
        temp_lambd_t(:,:,ii)=lambda_i*transpose(lambda_i);
        Cyy_1=Cyy_1+temp_lambd(:,:,ii)*sigmas2(ii);
        Cyy_lambda1=Cyy_lambda1+temp_lambd2(:,:,ii)*sigmas2(ii);
        %Calcul de Cyy' sans FO
        Cyy_Nc=Cyy_Nc+temp_lambd_t(:,:,ii)*Nc_P(ii);
end
hmod2=(h*h')^2;hmod2_ifft=(h_ifft*h_ifft')^2;

%%  ---- matrice dérivée
 %.... dérivée / fading
M1 = diag(1./fading(:,1));
M2 = diag(1./fading(:,2));
Mat = [M1 M1 zeros(N) zeros(N);...
       M1 M1 zeros(N) zeros(N);...
      zeros(N) zeros(N) M2 M2;...
      zeros(N) zeros(N) M2 M2];
D1_fading = repmat(h,size(h,2),1);
D_fading = Mat.*D1_fading; 

 %.... dérivée / delay

Hderiv = spec_chan_derive_sinc(fading,delay,DOA,Nr,N,Nt);  % H(Nr,N,Nt)

hnew=[];
for ii=1:Nt
        hnew=[hnew reshape(transpose(Hderiv(:,:,ii)),1,Nr*N)];
end
Mat2=[eye(N) eye(N) zeros(N) zeros(N);...
      eye(N) eye(N) zeros(N) zeros(N);...
      zeros(N) zeros(N) eye(N) eye(N);...
      zeros(N) zeros(N) eye(N) eye(N)];
D1_delay = repmat(hnew,size(hnew,2),1);
D_delay = Mat2.*D1_delay; 
 
 %.... dérivée / delay

Mteta1=diag(-1i*pi.*cos(DOA(:,1)));
Mteta2=diag(-1i*pi.*cos(DOA(:,2)));

Mat3=[zeros(N) Mteta1 zeros(N) zeros(N);...
      zeros(N) Mteta1 zeros(N) zeros(N);...
      zeros(N) zeros(N) zeros(N) Mteta2;...
      zeros(N) zeros(N) zeros(N) Mteta2];
D1_DOA = repmat(h,size(h,2),1);
D_DOA = Mat3.*D1_DOA; 

 %DD = [D_fading D_delay D_DOA]; % for real parameters
 DD = [D_fading 1i*D_fading D_delay D_DOA]; % for complex parameters
%% test
%%%%%=====2x2====
% Xt=sqrt(Pxp)*[(w'/sqrt(Ms))*diag(Xl1)*F (w'/sqrt(Ms))*diag(Xh1)*F ];
Xt=[];Xt_lambda=[];
for i=1:Nt
Xt=[Xt (w'/sqrt(Ms))*diag(ZC(:,i))*F];
Xt_lambda=[Xt_lambda sqrt(Ms)*diag(ZC(:,i))];
end
XX_h=Nt*Pxp*Ms*eye(N*Nt);
% XX_h_lambda=Nt*Pxp*Ms*eye(Ms*Nt);
XX_h_lambda=Nt*Pxp*Ms*eye(Nt);

%% =============== CRB_sto calculation ====================================
% Calcul de la puissance récu venant des pilotes
Y_p=lambda3*ZC_p;        Y_d=lambda3*ZC_d;
Prp=Y_p'*Y_p/(Nt*Ms);    Prd=Y_d'*Y_d/(Nt*Ms);
Pr=0.5*(Prp+Prd); % pour un SNR global
%Pr=Prp;           % pour un SNR_p 

%% ===== Loop SNR
SNR=-10:10:20;
for snr=1:length(SNR)
    SNR(snr)
sigmav2=10^((10*log10(Pr)-SNR(snr))/10);
Ip=zeros(N*Nr*Nt);
%%%% OP ================
% Ip1=Np*Xt'*Xt/sigmav2; 
Ip1=Np*XX_h/sigmav2;

%Ip_spec = DD'*Ip1*DD';
CRB_op1(snr)=abs(Nr*trace(inv(Ip1)));
%%%% OP_lambda
% Ip1_lambda=Np*Xt_lambda'*Xt_lambda/sigmav2;
Ip1_lambda=Np*XX_h_lambda/sigmav2;
CRB_op1_lambda(snr)=Ms*abs(Nr*trace(inv(Ip1_lambda)));
%%
%%% Cyy dans le cas CG sans FO
Cyy=Cyy_1+sigmav2*eye(Ms*Nr);
Cyyinv=inv(Cyy);
%%% Cyy dans le NCG sans FO
Cy_tilde=[Cyy Cyy_Nc;conj(Cyy_Nc) conj(Cyy)];
Cyt_inv=inv(Cy_tilde);
%%% Cyy dans le cas CG et NCG avec FO
%%% dérivée paraport à rh0
dCy_r=[zeros(Nr*Ms) Cyy_Nc;conj(Cyy_Nc) zeros(Nr*Ms)]/Nc_rate(1);
temp3=zeros(2*Nr*Ms,2*Nr*Ms,N*Nr*Nt);temp4=zeros(2*Nr*Ms,2*Nr*Ms,N*Nr*Nt);
temp1=zeros(Nr*Ms,Nr*Ms,N*Nr*Nt);temp2=zeros(Nr*Ms,Nr*Ms,N*Nr*Nt);
      for i=1:N*Nr*Nt
         q=fix(i/(N*Nr));
         cln=i-q*(N*Nr);
         if cln==0 clnn= (N*Nr); imtx=q;else clnn=cln;imtx=q+1; end
         q1=fix(clnn/N);
         cln1=clnn-q1*N;
         if cln1==0 iN=N; imrx=q1;else iN=cln1;imrx=q1+1; end
         %calcul pour le cas CG sans FO
         temp1(:,Ms*(imrx-1)+1:Ms*imrx,i)=Cyyinv*sigmas2(imtx)*lambda2(:,:,imtx)*diag(w(:,iN)')*(w/sqrt(Ms));
         temp2(:,:,i)=sigmas2(imtx)*Cyyinv(:,Ms*(imrx-1)+1:Ms*imrx)*(w'/sqrt(Ms))*diag(w(:,iN))*lambda2(:,:,imtx)';
         %calcul pour le cas NCG sans FO
         D=zeros(Nr*Ms);D1=zeros(Nr*Ms);  
         D(:,Ms*(imrx-1)+1:Ms*imrx)=sigmas2(imtx)*lambda2(:,:,imtx)*diag(w(:,iN)')*(w/sqrt(Ms));
         D1(:,Ms*(imrx-1)+1:Ms*imrx)=conj(Nc_P(imtx))*conj(lambda2(:,:,imtx))*diag(w(:,iN)')*(w/sqrt(Ms));
         Cyt_der=[D zeros(Nr*Ms);D1+transpose(D1) transpose(D)];
         temp3(:,:,i)=Cyt_inv*Cyt_der;
         temp4(:,:,i)=Cyt_inv*Cyt_der';
      end
        %Calcule des FIM
      for i=1:N*Nr*Nt
            for j=1:N*Nr*Nt
                   Ihh_NCG(i,j)=0.5*(trace(temp3(:,:,i)*temp4(:,:,j))); % NCG sans FO
                   Ihh_CG(i,j)=trace(temp1(:,:,i)*temp2(:,:,j));        % CG sans FO
                   Ihhc_CG(i,j)=trace(temp1(:,:,i)*temp1(:,:,j)); 
            end
            % FIM h avec v sans FO
            Ihv_NCG(i)=0.25*trace(temp3(:,:,i)*Cyt_inv); % NCG sans FO
            Ivh_NCG(i)=0.25*trace(Cyt_inv*temp4(:,:,i)); % NCG sans FO
            %%% ====== cas CG =================
            Ihv_CG(i)=0.5*trace(temp1(:,:,i)*Cyyinv); % CG sans FO
            Ivh_CG(i)=0.5*trace(Cyyinv*temp2(:,:,i)); % CG sans FO
            % FIM h avec rho sans FO
            Ihr_NCG(i)=0.25*trace(temp3(:,:,i)*Cyt_inv*dCy_r');% NCG sans FO
            Irh_NCG(i)=0.25*trace(Cyt_inv*dCy_r*temp4(:,:,i)); % NCG sans FO
         for ii=1:Nt
              D4=(Nc_P(ii)/sigmas2(ii))*temp_lambd_t(:,:,ii);
              D5=1i*Nc_P(ii)*temp_lambd_t(:,:,ii);
              C_dr_phi=[zeros(Nr*Ms) D5;conj(D5) zeros(Nr*Ms)];%dérivée de cy_tild/phi
              C_dr_s=[temp_lambd(:,:,ii) D4;conj(D4) conj(temp_lambd(:,:,ii))];%dérivée de cy_tild/sigmas2
              Ihsig_NCG(i,ii)=0.25*trace(temp3(:,:,i)*Cyt_inv*C_dr_s'); % NCG sans FO
              Isigh_NCG(ii,i)=0.25*trace(Cyt_inv*C_dr_s*temp4(:,:,i));  % NCG sans FO
              Ihphi_NCG(i,ii)=0.25*trace(temp3(:,:,i)*Cyt_inv*C_dr_phi');% NCG sans FO
              Iphih_NCG(ii,i)=0.25*trace(Cyt_inv*C_dr_phi*temp4(:,:,i)); % NCG sans FO
              %%%=== Cas CG sans FO ==============
              Ihsig_CG(i,ii)=0.5*trace(temp1(:,:,i)*Cyyinv*temp_lambd(:,:,ii)'); % CG sans FO
              Isigh_CG(ii,i)=0.5*trace(Cyyinv*temp_lambd(:,:,ii)*temp2(:,:,i));  % CG sans FO
         end
      end
      for ii=1:Nt
            D4ii=(Nc_P(ii)/sigmas2(ii))*temp_lambd_t(:,:,ii);
            D5ii=1i*Nc_P(ii)*temp_lambd_t(:,:,ii);
            C_dr_phi_ii=[zeros(Nr*Ms) D5ii;conj(D5ii) zeros(Nr*Ms)];%dérivée de cy_tild/phi
            C_dr_s_ii=[temp_lambd(:,:,ii) D4ii;conj(D4ii) conj(temp_lambd(:,:,ii))];%dérivée de cy_tild/sigmas2
         for jj=1:Nt
             % cas NCG calcul de FIM s&s et phi&phi
              D4jj=(Nc_P(jj)/sigmas2(jj))*temp_lambd_t(:,:,jj);
              D5jj=1i*Nc_P(jj)*temp_lambd_t(:,:,jj);
              C_dr_phi_jj=[zeros(Nr*Ms) D5jj;conj(D5jj) zeros(Nr*Ms)];%dérivée de cy_tild/phi
              C_dr_s_jj=[temp_lambd(:,:,jj) D4jj;conj(D4jj) conj(temp_lambd(:,:,jj))];%dérivée de cy_tild/sigmas2
              Iss_NCG(ii,jj)=0.5*0.25*trace(Cyt_inv*C_dr_s_ii*Cyt_inv*C_dr_s_jj');
              Iphiphi_NCG(ii,jj)=0.5*0.25*trace(Cyt_inv*C_dr_phi_ii*Cyt_inv*C_dr_phi_jj');
              Iphis_NCG(ii,jj)=0.5*0.25*trace(Cyt_inv*C_dr_phi_ii*Cyt_inv*C_dr_s_jj');
              Isphi_NCG(ii,jj)=0.5*0.25*trace(Cyt_inv*C_dr_s_ii*Cyt_inv*C_dr_phi_jj');
              %%% cas CG sans FO
              Iss_CG(ii,jj)=0.25*trace(Cyyinv*temp_lambd(:,:,ii)*Cyyinv*temp_lambd(:,:,jj)'); % Cas CG sans FO
         end
         Isv_NCG(ii)=0.5*0.25*trace(Cyt_inv*C_dr_s_ii*Cyt_inv);
         Ivs_NCG(ii)=0.5*0.25*trace(Cyt_inv*Cyt_inv*C_dr_s_ii');
         Isr_NCG(ii)=0.5*0.25*trace(Cyt_inv*C_dr_s_ii*Cyt_inv*dCy_r');
         Irs_NCG(ii)=0.5*0.25*trace(Cyt_inv*dCy_r*Cyt_inv*C_dr_s_ii');
         Iphiv_NCG(ii)=0.5*0.25*trace(Cyt_inv*C_dr_phi_ii*Cyt_inv);
         Ivphi_NCG(ii)=0.5*0.25*trace(Cyt_inv*Cyt_inv*C_dr_phi_ii');
         Iphir_NCG(ii)=0.5*0.25*trace(Cyt_inv*C_dr_phi_ii*Cyt_inv*dCy_r');
         Irphi_NCG(ii)=0.5*0.25*trace(Cyt_inv*dCy_r*Cyt_inv*C_dr_phi_ii');
         %%%=== cas CG sans FO
         Isv_CG(ii)=0.25*trace(Cyyinv*temp_lambd(:,:,ii)*Cyyinv);  % cas CG sans FO
         Ivs_CG(ii)=0.25*trace(Cyyinv*Cyyinv*temp_lambd(:,:,ii)'); % cas CG sans FO
      end
      %%% FIM vv et rr
      Ivv_NCG=0.5*0.25*trace(Cyt_inv*Cyt_inv);
      Irr_NCG=0.5*0.25*trace(Cyt_inv*dCy_r*Cyt_inv*dCy_r');
      Ivr_NCG=0.5*0.25*trace(Cyt_inv*Cyt_inv*dCy_r');
      Irv_NCG=0.5*0.25*trace(Cyt_inv*dCy_r*Cyt_inv);
      %%%==== cas CG sans FO
      Ivv_CG=0.25*trace(Cyyinv*Cyyinv); % cas CG sans FO
%% Lambda FIM
     Cyy_lambda=Cyy_lambda1+sigmav2*eye(Nr);
     Cyy_lambda_inv=inv(Cyy_lambda);
  temp5=zeros(Nr,Nr,Nr*Nt);temp6=zeros(Nr,Nr,Nr*Nt);
     for i=1:Nr*Nt
         q=fix(i/(Nr));
         cln=i-q*(Nr);
         if cln==0 imrx= Nr; imtx=q;else imrx=cln;imtx=q+1; end
         temp5(:,imrx,i)=sigmas2(imtx)*Cyy_lambda_inv*lambda4(:,imtx);
         temp6(:,:,i)=sigmas2(imtx)*Cyy_lambda_inv(:,imrx)*lambda4(:,imtx)';
     end
    for i=1:Nr*Nt
         for j=1:Nr*Nt
             I_lm(i,j)=trace(temp5(:,:,i)*temp6(:,:,j)); % lambda FIM
         end
         for ii=1:Nt
             I_lms(i,ii)=0.5*trace(temp5(:,:,i)*Cyy_lambda_inv*temp_lambd2(:,:,ii));
             I_slm(ii,i)=0.5*trace(Cyy_lambda_inv*temp_lambd2(:,:,ii)*temp6(:,:,i));
         end
         I_lmv(i)=0.5*trace(temp5(:,:,i)*Cyy_lambda_inv);
         I_vlm(i)=0.5*trace(Cyy_lambda_inv*temp6(:,:,i));
     end
     for ii=1:Nt
         for jj=1:Nt
             I_s(ii,jj)=0.25*trace(Cyy_lambda_inv*temp_lambd2(:,:,ii)*Cyy_lambda_inv*temp_lambd2(:,:,jj));
         end
         I_sv(ii)=0.25*trace(Cyy_lambda_inv*temp_lambd2(:,:,ii)*Cyy_lambda_inv);
     end
      I_v=0.25*trace(Cyy_lambda_inv*Cyy_lambda_inv);    
      
      I_lambda= Ns_data*[I_lm I_lms transpose(I_lmv); I_slm I_s transpose(I_sv); I_vlm I_sv I_v];  
        I_lambda(1:Nr*Nt,1:Nr*Nt)= kron(eye(Nr),Ip1_lambda)+Ns_data*I_lm;
        CRB_lam=inv(I_lambda);
%      I_lambda=Ip+Ns_data*I_lm;
     CRB_lambda(snr)=Ms*abs(trace(CRB_lam(1:Nr*Nt,1:Nr*Nt)));
%% Total FIM
%FIM total dans le cas CG sans FO 
I_CG=Ns_data*[Ihh_CG Ihsig_CG transpose(Ihv_CG);...
              Isigh_CG Iss_CG transpose(Isv_CG);...
              Ivh_CG Ivs_CG Ivv_CG];
          
I_CG_Blind      = [Ihh_CG Ihhc_CG;conj(Ihhc_CG) conj(Ihh_CG)];
I_CG_Blind_spec = [DD'*Ihh_CG*DD DD'*Ihhc_CG*DD;conj(DD'*Ihhc_CG*DD) conj(DD'*Ihh_CG*DD)];

I_CG(1:N*Nr*Nt,1:N*Nr*Nt)= kron(eye(Nr),Ip1)+Ns_data*Ihh_CG;
crbt_CG=inv(I_CG);

%FIM total dans le cas NCG sans FO 
I_NCG=Ns_data*[Ihh_NCG Ihsig_NCG transpose(Ihv_NCG) transpose(Ihr_NCG) Ihphi_NCG;...
                Isigh_NCG Iss_NCG transpose(Isv_NCG) transpose(Isr_NCG) Isphi_NCG;...
                Ivh_NCG Ivs_NCG Ivv_NCG Ivr_NCG Ivphi_NCG;...
                Irh_NCG Irs_NCG Irv_NCG Irr_NCG Irphi_NCG;...
                Iphih_NCG Iphis_NCG transpose(Iphiv_NCG) transpose(Iphir_NCG) Iphiphi_NCG];
I_NCG(1:N*Nr*Nt,1:N*Nr*Nt)= kron(eye(Nr),Ip1)+Ns_data*Ihh_NCG;
crbt_NCG=inv(I_NCG);
%%% pour comparer NCG avec CG
crbt_NCG2=inv(I_NCG(1:N*Nr*Nt+Nt+1,1:N*Nr*Nt+Nt+1));
 %FIM total dans le cas NCG avec FO 


%% les CRB
%%% ==== CRB CG sans FO
CRBh_CG_com(snr)=abs(trace(crbt_CG(1:N*Nr*Nt,1:N*Nr*Nt))); % all var
%%% === CRB NCG
CRBh_NCG_com(snr)=abs(trace(crbt_NCG(1:N*Nr*Nt,1:N*Nr*Nt))); % all var
     %% calcul de CRB lambda apartire de h
    CRB_lam_h1= w(:,1:N*Nr*Nt)*crbt_NCG(1:N*Nr*Nt,1:N*Nr*Nt)*w(:,1:N*Nr*Nt)'/Ms;
   CRB_lam_h(snr)=abs(trace(CRB_lam_h1));
%%  CRB for specular
Jd = Ns_data*Ihh_NCG;
Jd_spec = DD'*Jd*DD;

I_SB_h = I_CG(1:N*Nr*Nt,1:N*Nr*Nt); % only for h  I_CG and I_NCG
I_SB_h_spec = DD'*I_SB_h*DD;
CRB_NCG_spec(snr) = abs(trace(pinv(I_SB_h_spec)));

Iop=kron(eye(Nr),Ip1);
Iop_spec = DD'*Iop*DD;
CRB_op_spec(snr) = abs(trace(pinv(Iop_spec)));
end

% figure
% % hold on
% semilogy(SNR,CRB_op1/hmod2,'-b>',SNR,CRBh_NCG_com/hmod2,'-ko',SNR,CRB_op1_lambda/(hmod2),'-g>',SNR,CRB_lambda/hmod2,'-Ms')
% grid on
% title('N=4, N_r= 2, N_t=2, \nu_1=0.015, \nu_2=0.5, N_d=40')
% ylabel('Normalized CRB')
% xlabel('SNR_p(dB)')
% legend('CRB_{OP}','CRB_{NCG}')

% figure
% semilogy(SNR,CRB_op1_lambda/(hmod2),'-k>',SNR,CRB_lambda/hmod2,'-m*',SNR,CRB_op1/hmod2,'-b>',SNR,CRBh_NCG_com/hmod2,'-r+',...
%          SNR,CRB_lam_h/hmod2,'-gs',SNR,CRB_op_spec/hmod2,'--bs',SNR,CRB_NCG_spec/hmod2,'--r*')
     
figure
semilogy(SNR,CRB_op1_lambda/(hmod2),'-k>',SNR,CRB_lambda/hmod2,'-m*',SNR,CRB_op1/hmod2,'-b>',SNR,CRBh_NCG_com/hmod2,'-r+',...
         SNR,CRB_op_spec/hmod2,'--bs',SNR,CRB_NCG_spec/hmod2,'--r*')
     
grid on
%title('N=4, N_r= 4, N_t=4, N_d=40')
ylabel('Normalized CRB')
xlabel('SNR_p(dB)')
legend('CRB_{OP}^{Lambda}','CRB_{SB}^{Lambda}','CRB_{OP}^{h}','CRB_{SB}^{h}','CRB_{OP}^{specular}','CRB_{SB}^{specular}')

t=toc
