clear all;
close all;
OmegaSl = tan (0.2*pi/2);
OmegaSh = tan (0.5*pi/2);
Omega1 = tan (0.3*pi/2);
Omega3 = tan (0.4*pi/2);
Omega2 = sqrt(Omega1*Omega3);
OmegaBW = Omega3-Omega1;
nsl = OmegaSl/OmegaBW;
nsh = OmegaSh/OmegaBW;
n1 = Omega1/OmegaBW;
n3 = Omega3 /OmegaBW;
n22 = n1*n3;

LamdaP = (n3^2-n22)/n3;
LamdaS = (nsh^2-n22)/nsh;
LamdaS1 = (nsl^2-n22)/nsl;
alpha = sqrt( (10^4-1)/(10^0.3-1) );
n = acosh(alpha)/acosh(LamdaS);
fai = 1/n*asinh(1);

p1 = -sin(pi/8)*sinh(0.2872)+1j*cos(pi/8)*cosh(0.2872);
p2 = -sin(3*pi/8)*sinh(0.2872)+1j*cos(3*pi/8)*cosh(0.2872);
p3 = -sin(5*pi/8)*sinh(0.2872)+1j*cos(5*pi/8)*cosh(0.2872);
p4 = -sin(7*pi/8)*sinh(0.2872)+1j*cos(7*pi/8)*cosh(0.2872);



