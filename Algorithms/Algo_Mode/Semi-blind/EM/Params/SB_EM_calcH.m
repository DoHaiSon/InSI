%
%    script calcH.m : calcule la matrice de filtrage H a partir
%    des coefficients des filtres stockes dans un tableau
%    syntaxe: H= calcH(VecH,L,M,N)
%    Entrees
%       VecH = coefficients des canaux (L lignes, M+1 colonnes)
%       L    = nombre de canaux
%       M    = degre des polynomes (M+1 composantes)
%       N    = taille du snapshot
%    Sorties
%       H    = matrice de filtrage (LN lignes, M+N colonnes)
%
function H = SB_EM_calcH(VecH,L,M,N)

if (size(VecH,1) ~= L)
   error('Nombre incorrect de lignes');
end
if (size(VecH,2) ~= M+1)
   error('Nombre incorrect de colonnes');
end
%
%... Initialisation de la matrice a 0
%
H= zeros(L*N,M+N);
for icap=1:L,
    irow = (icap-1)*N+1:icap*N;
    H(irow,:)= toeplitz( [VecH(icap,1); zeros(N-1,1)], [VecH(icap,1:M+1) zeros(1,N-1)]  );
end    
%H1=zeros(N*L,M+N);
%for ind=1:N
%  irow2=ind:N:L*N;
%  irow1 = L*(ind-1)+1:L*ind;
%  H1(irow1,:)=H(irow2,:);
%end
%H=H1;
