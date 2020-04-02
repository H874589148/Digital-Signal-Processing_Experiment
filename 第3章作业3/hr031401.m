clear all;
close all;
f = 50;N=16;
n =1:N;

fs = 800; % 采样率设置800Hz
Ts=1/fs;
w = 2*pi*f*Ts;
y =sin(w.*n);
subplot(221);stem(n,y,'.');
title('信号时域采样800Hz');

[H1,w] = freqz(y,1,'whole',fs);
subplot(222);plot(w,abs(H1));grid on;
title('频谱图DTFT');

fs = 200; % 采样率设置200Hz
Ts=1/fs;
w = 2*pi*f*Ts;
y =sin(w.*n);
subplot(223);stem(n,y,'.');title('采样率设置200Hz');

Y = fft(y,N/2);
n1 = 0:N/2-1;
Y = abs(Y);
subplot(224);stem(n1,Y,'.');ylabel('|Y|');title('DFT');

