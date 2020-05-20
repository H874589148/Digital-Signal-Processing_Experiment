clear all;
close all;
omegaSl = 47*2*pi/1000;
omegaSh = 53*2*pi/1000;
omega1 = 44*2*pi/1000;
omega3 = 56*2*pi/1000;
OmegaSl = tan (omegaSl/2);
OmegaSh = tan (omegaSh/2);
Omega1 = tan (omega1/2);
Omega3 = tan (omega3/2);
Omega2 = sqrt(Omega1*Omega3);
OmegaBW = Omega3-Omega1;
nsl = OmegaSl/OmegaBW;
nsh = OmegaSh/OmegaBW;
n1 = Omega1/OmegaBW;
n3 = Omega3 /OmegaBW;
n22 = n1*n3;

LamdaP = (n3^2-n22)/n3;
LamdaS = nsh/(nsh^2-n22);
LamdaS1 = nsl/(nsl^2-n22);
alpha = sqrt( (10^5-1)/(10^0.3-1) );
n = acosh(alpha)/acosh(LamdaS);
fai = 1/n*asinh(1);

p1 = -sin(pi/8)*sinh(0.1673)+1j*cos(pi/8)*cosh(0.1673);
p2 = -sin(3*pi/8)*sinh(0.1673)+1j*cos(3*pi/8)*cosh(0.1673);
p3 = -sin(5*pi/8)*sinh(0.1673)+1j*cos(5*pi/8)*cosh(0.1673);
p4 = -sin(7*pi/8)*sinh(0.1673)+1j*cos(7*pi/8)*cosh(0.1673);
p5 = -sin(9*pi/8)*sinh(0.1673)+1j*cos(9*pi/8)*cosh(0.1673);
p6 = -sin(11*pi/8)*sinh(0.1673)+1j*cos(11*pi/8)*cosh(0.1673);



