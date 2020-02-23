%----------------------------------------------------------------------------
% exa090300_1.m,   for fig. 9.3.1,
%----------------------------------------------------------------------------
clear all;

t0=.1; 
ts=.001;
fc=250;

t=[-t0/2:ts:t0/2];
m=sinc(100*t);
c=cos(2*pi*fc*t);

% 信号的调幅；
u=m.*c;

figure(1)
subplot(3,2,1)
plot(t,m(1:length(t)));grid;
subplot(3,2,3)
plot(t,c(1:length(t)));grid;
subplot(3,2,5)
plot(t,u(1:length(t)));grid;
f=-0.5:1/256:0.5-1/256;

% 求待调信号、载波信号和调制信号的频谱；
M=fft(m,256);
C=fft(c,256);
U=fft(u,256);

subplot(322)
plot(f,abs(fftshift(M)));grid;
subplot(324)
plot(f,abs(fftshift(C)));grid;
subplot(326)
plot(f,abs(fftshift(U)));grid;




