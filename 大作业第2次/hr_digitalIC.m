close all;
clear all;
syms Tc Tc1 Tc2
Y1=Tc1*exp(Tc1/(20*10^(-12)))-75*pi*10^2==0;
Y2=Tc2*exp(Tc2/(54*10^(-12)))-75*pi*10^5==0;
Y=Tc*exp(Tc/(54*10^(-12)))-2100*pi*10^2==0;
ans1=solve(Y1,Tc1);
ans2=solve(Y2,Tc2);
ans3=solve(Y,Tc);
