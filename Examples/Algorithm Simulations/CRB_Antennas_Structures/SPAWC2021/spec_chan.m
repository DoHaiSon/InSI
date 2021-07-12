function H = spec_chan(fading,delay,DOA,Nr,N,Nt)

% fad   = zeros(N,Nr,Nt);
% delay = zeros(N,Nr,Nt);
% DOA   = zeros(N,Nr,Nt);

% fading, delay, DOA of size (N,Nt)

H = zeros(Nr,N,Nt);

for i=1:Nt
   for j=1:Nr
       for k=1:N
          
      H(j,k,i) = fading(k,i)*sinc(delay(k,i))*exp(-1i*pi*(j-1)*sin(DOA(k,i)));     
           
       end
   end
end

end

