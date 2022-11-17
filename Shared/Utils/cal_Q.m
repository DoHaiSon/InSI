function Q = cal_Q(sig_cap,M,W,N)

% calcul de la forme quadratique associe au critere tsml.
%
%
% SYNTAXE: Q = cal_Q(sig_cap,M,W,N);
%
% Q: la matrice de la forme quadratique
%
% M: degres des canaux
% sig_cap: observations T x q
% W : matrice de ponderation
% N : taille de la fenetre temporelle

[T,q]=size(sig_cap);
Q=zeros(q*(M+1));
nb_bloc= ceil(T/N);
for t=1:nb_bloc
    sig_t = sig_cap((t-1)*N+1:t*N,:);
    x=hankel(sig_t(:,1));
    Y1=x(1:N-M,1+M:-1:1);
    Han=Y1;

    x=hankel(sig_t(:,2));
    Y=[x(1:N-M,1+M:-1:1), -Y1];
    Han=[Han;x(1:N-M,1+M:-1:1)];

    if q > 2
        for ii=3:q
            x = hankel(sig_t(:,ii));
            x=x(1:N-M,1+M:-1:1);
            nb_row=length(Y(:,1));
            X=kron(eye(ii-1),x);
            Y=[Y,zeros(nb_row,M+1);X,-Han];
            Han = [Han; x];
        end
    end
    Q=Y'*W*Y + Q;
end