clear all;
close all;
OmegaP = tan (0.4*pi);
OmegaS = tan (0.3*pi);
np=1;ns=OmegaS/OmegaP;
LamdaP=1/np;LamdaS=1/ns;
N=(log10( sqrt(10^3.5-1) )) / (log10(LamdaS));
