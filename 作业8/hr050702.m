close all;
clear all;
z1=0.4*exp(1i*pi/3);
z2=0.4*exp(-1i*pi/3);
z3=3;
%H=h1*(z^(-1)+z^(-5))+h2*(z^(-2)+z^(-4))+h3*z^(-3)+1+z^(-6)
syms h1 h2 h3
H1=h1*(z1^(-1)-z1^(-5))+h2*(z1^(-2)-z1^(-4))+h3*z1^(-3)+1-z1^(-6)==0;
H2=h1*(z2^(-1)-z2^(-5))+h2*(z2^(-2)-z2^(-4))+h3*z2^(-3)+1-z2^(-6)==0;
H3=h1*(z3^(-1)-z3^(-5))+h2*(z3^(-2)-z3^(-4))+h3*z3^(-3)+1-z3^(-6)==0;
H=[H1,H2,H3];
vars=[h1,h2,h3];
[h1,h2,h3]=solve(H,vars);
