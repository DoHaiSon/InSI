function result = SB_EM_Dec2Alphabet( x, alphabet, M )
% this function converts the decimal "x" into its equivalent representation
% with elements of alphabet

P   = length(alphabet);
mat = (dec2base(x-1,P,M))';

result = zeros(M,1);
 
 for i = 1:M
     ind = mat(i,1);
     result(i,1) = alphabet(1,str2double(ind)+1); 
  end
end

