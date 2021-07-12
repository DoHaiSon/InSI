function H = spec_chan_derive_sinc(fading,delay,DOA,Nr,N,Nt)

% fad   = zeros(N,Nr,Nt);
% delay = zeros(N,Nr,Nt);
% DOA   = zeros(N,Nr,Nt);

% fading, delay, DOA of size (N,Nt)

H = zeros(Nr,N,Nt);

for i=1:Nt
   for j=1:Nr
       for k=1:N
          dev = (delay(k,i)*cos(delay(k,i))-sin(delay(k,i)))/delay(k,i)^2;
      H(j,k,i) = fading(k,i)*dev*exp(-1i*pi*(j-1)*sin(DOA(k,i)));     
           
       end
   end
end

end

