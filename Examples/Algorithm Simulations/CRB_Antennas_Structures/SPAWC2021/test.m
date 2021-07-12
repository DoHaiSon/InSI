clear all;
close all;
clc;
Nt = 4;    % number of transmit antennas
Nr = 4;    % number of receive antennas
L   = 4;    % channel order
M   = 2;    % Number of multipaths (assumption: M  = L)   
%fading = rand(M,Nt)+1i*rand(M,Nt);
%fading = rand(M,Nt);
%delay  = rand(M,Nt);
%DOA    = pi * rand(M,Nt);
%d_nor=1/2;

fading=[0.8,0.6,0.4,0.2;0.9,0.7 0.5,0.3];
%delay  = rand(M,Nt);
delay=[0.1,0.2,0.3,0.4;0.2,0.3 0.4,0.5];
%DOA    = pi * rand(M,Nt);
DOA=[pi/2,pi/4,pi/6,pi/8;pi/3,pi/5,pi/7,pi/9];
d_nor=1/2;


%Br_fading = zeros(Nt,M,L);
dev_h_fading=[];
%Nr_index=1;
for Nr_index=1:Nr;
Br_fading = spec_chan_derive_fading(fading,delay,DOA,d_nor,Nr_index,L,M,Nt);
dev_h_fading=[dev_h_fading; transpose(Br_fading)];
%dev_h_fading=[dev_h_fading;Br_fading];
end
