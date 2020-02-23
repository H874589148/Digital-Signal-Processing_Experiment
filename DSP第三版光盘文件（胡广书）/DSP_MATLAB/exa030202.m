%----------------------------------------------------------------------------
% exa030202, for example 3.2.2 and fig 3.2.4
% to explain how to unwrap the phase
%----------------------------------------------------------------------------
clear;

% 
N=64;m1=5;m2=-5;
wstep=2*pi/N;
w=-pi:wstep:pi-wstep;
H1=exp(-j*m1*w);
Hphase1=angle(H1);
H2=exp(-j*m2*w);
Hphase2=angle(H2);
%
w=w/(2*pi);
subplot(221)
plot(w,Hphase1);grid on;
subplot(222)
plot(w,Hphase2);grid on;
Hphase12=unwrap(Hphase1);
Hphase22=unwrap(Hphase2);
subplot(223)
plot(w,Hphase12);grid on;
subplot(224)
plot(w,Hphase22);grid on;
