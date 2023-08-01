% Calcul des parametres (H,sigma) par l'algorithme EM maximisant la
% vraisemblance des signaux observes.
%
% SYNTAXE [proba,estsigma1,estcan1]=EM(sig_cap,trans,estcan,estsigma,predess,success,nb_iter,seuil)
%
% sig_cap : tableau des signaux recus par les capteurs
% trans : tableau ((M+1) X P^(M+1)) des transitions
% estcan : estimee initiale des coefficients des canaux
% estsigma : estimmee initiale de la puissance du bruit
% predess : tableau des predecesseurs d'etats
% success : tableau des successeurs d'etats
% nb_iter : nbr maximal d'iterations autorise
% seuil : seuil d'arret des iterations.
%
% sortie:
% proba : tableau des densites de probabilites L(Y,Xt=En) a la fin des iterations.
% estsigma1 : reestimee de sigma a la fin des iterations
% estcan1 : reestimee de can a la fin des iterations
%
function [proba,estsigma1,estcan1,compt] = SB_EM_func(sig_cap,trans,sigcap_pilot,pilots,estcan,estsigma,predess,success,tableau,nb_iter,seuil,Nt)

old_vrais = -1;
test      = seuil+1;
compt     = 0;
M         = length(estcan(1,:))/(2*Nt)-1;
Ncap      = size(estcan,1);
P         = (length(predess(1,:)))^(1/Nt);
T         = length(sig_cap(:,1));

while(test > seuil) && (compt<nb_iter)
    compt=compt+1;
    %%%%%%% Algorithm

    tab = SB_EM_cal_tab(sig_cap,trans,estcan,estsigma);

    [alpha,beta,Rho] = SB_EM_alpha_beta2(tableau,tab,M,T,Nt,P);

    proba = SB_EM_cal_prob2(alpha,beta,tab,tableau,P,M,T,Nt);

    new_vrais = sum(proba(:,1))/prod(Rho);
    if (old_vrais>new_vrais)
        error('The likelihood is diminishing!!!')
    end

    old_vrais = new_vrais;
    [estsigma1,estcan1] = SB_EM_cal_sigmaH_SB(proba,sig_cap,trans,sigcap_pilot,pilots,Nt);

    vec_new  = reshape(estcan1.',Ncap*Nt*2*(M+1),1);
    vec_old  = reshape(estcan.',Ncap*Nt*2*(M+1),1);

    test = norm(vec_new-vec_old)/norm(vec_old); %+abs(estsigma1-estsigma);

    estcan   = estcan1;
    estsigma1 = estsigma;

end
end