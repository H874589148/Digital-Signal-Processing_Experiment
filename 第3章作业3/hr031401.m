clear all;
close all;
f = 50;N=16;
n =1:N;

fs = 800; % ����������800Hz
Ts=1/fs;
w = 2*pi*f*Ts;
y =sin(w.*n);
subplot(221);stem(n,y,'.');
title('�ź�ʱ�����800Hz');

[H1,w] = freqz(y,1,'whole',fs);
subplot(222);plot(w,abs(H1));grid on;
title('Ƶ��ͼDTFT');

fs = 200; % ����������200Hz
Ts=1/fs;
w = 2*pi*f*Ts;
y =sin(w.*n);
subplot(223);stem(n,y,'.');title('����������200Hz');

Y = fft(y,N/2);
n1 = 0:N/2-1;
Y = abs(Y);
subplot(224);stem(n1,Y,'.');ylabel('|Y|');title('DFT');

