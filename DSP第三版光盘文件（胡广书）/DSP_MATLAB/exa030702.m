%----------------------------------------------------------------------------
% exa030703, for example 3.7.3
% to discuss the effect of padding with zeros for DTFT; 
%----------------------------------------------------------------------------
clear;

% 计算长度为N的原始信号的DTFT
 f1=2.67;f2=3.75;f3=6.75;fs=20;w=2*pi/fs;
 N=16;
 x=sin(w*f1*(0:N-1))+sin(w*f2*(0:N-1)+pi/2)+sin(w*f3*(0:N-1));
 f=0:fs/N:fs/2-1/N;
 X=fft(x); 
 X=abs(X);
 f=fs/N*(0:N/2-1);
 subplot(221)
 stem(f,X(1:N/2),'.');grid on;
 xlabel('Hz')
 
% 在数据末补N个零 
 x(N:2*N-1)=0;
 X=fft(x); X=abs(X);
 f=fs*(0:N-1)/(2*N);
 subplot(222)
 stem(f,X(1:N),'.');grid on;
 xlabel('Hz')
 
% 在数据末补7*N个零
 x(N:8*N-1)=0;
 X=fft(x); X=abs(X);
 f=fs*(0:4*N-1)/(8*N);
 subplot(223)
 stem(f,X(1:4*N),'.');grid on;
 xlabel('Hz')
 
% 在数据末补29*N个零
 x(N:30*N-1)=0;
 X=fft(x); X=abs(X);
 f=fs*(0:15*N-1)/(30*N);
 subplot(224)
 plot(f,X(1:15*N));grid on;
 xlabel('Hz')
 