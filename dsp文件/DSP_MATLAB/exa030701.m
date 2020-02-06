%----------------------------------------------------------------------------
% exa030701, for example 3.7.1
% to discuss the resolution of DTFT; 
%----------------------------------------------------------------------------
clear all;

% 观察数据长度N的变化对DTFT分辨率的影响
 f1=2;f2=2.02;f3=2.07;fs=10;
 w=2*pi/fs;
 N=256;
 x=sin(w*f1*(0:N-1))+sin(w*f2*(0:N-1))+sin(w*f3*(0:N-1));
 f=0:fs/N:fs/2-1/N;
 X=fft(x); 
 X=abs(X);
 subplot(221)
 plot(f(45:60),X(45:60));grid on;
 xlabel('Hz')
%
 N=N*4;
 x=sin(w*f1*(0:N-1))+sin(w*f2*(0:N-1))+sin(w*f3*(0:N-1));
 f=0:fs/N:fs/2-1/N;
 X=fft(x); 
 X=abs(X);
 subplot(222)
 plot(f(45*4:4*60),X(4*45:4*60));grid on;
 xlabel('Hz')