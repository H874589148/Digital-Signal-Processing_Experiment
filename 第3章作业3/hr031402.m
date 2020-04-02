clear all;
N = 16; f = 50; n = 0 : N-1;
fs = 100;
Ts = 1/fs; w = 2*pi*f*Ts;
x1=sin(w*n);  X1=fft(x1,N);
Et1=x1*(x1)'; Ef1=2/N*(abs(X1(9)))^2;
subplot(311);stem(1:16,real(X1),'.');title('采样率设置100Hz');

fs = 150;
Ts = 1/fs; w = 2*pi*f*Ts;
x2=sin(w*n); X2=fft(x2,N);
Et2=x2*(x2)'; Ef2=2/N*(abs(X2(6)))^2;
subplot(312);stem(1:16,real(X2),'.');title('采样率设置150Hz');

fs = 200;
Ts = 1/fs; w = 2*pi*f*Ts;
x3=sin(w*n); X3=fft(x3,N);
Et3=x3*(x3)'; Ef3=2/N*(abs(X3(5)))^2;
subplot(313);stem(1:16,real(X3),'.');title('采样率设置200Hz');

clear f fs Ts w n N x1 x2 x3