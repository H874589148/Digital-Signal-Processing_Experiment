clear all;
close all;
omegap=2000*pi;Ts=10^(-5);
a1=cos(5*pi/8)*omegap;a2=cos(7*pi/8)*omegap;
b1=omegap*sqrt(1-(cos(5*pi/8))^2);b2=omegap*sqrt(1-(cos(7*pi/8))^2);
A=(omegap^2)*exp(a1*Ts+a2*Ts)*sin(b1*Ts)*sin(b2*Ts);
B=sqrt(   (1-(cos(5*pi/8))^2) * (1-(cos(7*pi/8))^2)   );
A=A/B;
den1=2*exp(a1*Ts)*cos(b1*Ts);
den2=2*exp(a2*Ts)*cos(b2*Ts);
den3=exp(2*a1*Ts);
den4=exp(2*a2*Ts);

