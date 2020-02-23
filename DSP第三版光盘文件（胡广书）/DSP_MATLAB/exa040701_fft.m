%-----------------------------------------------------------------
% exa040701_fft.m: for example 4.7.1 
% to test fft.m dn ifft.m
%-----------------------------------------------------------------
 clear all;

 % 产生两个正弦加白噪声；
 N=256;
 f1=.1;f2=.2;fs=1;
 a1=5;a2=3;
 w=2*pi/fs;
 x=a1*sin(w*f1*(0:N-1))+a2*sin(w*f2*(0:N-1))+randn(1,N);
 
 % 应用FFT 求频谱； 
 subplot(3,1,1);
 plot(x(1:N/4));
 f=-0.5:1/N:0.5-1/N;
 X=fft(x); 
 y=ifft(X);
 subplot(3,1,2);
 plot(f,fftshift(abs(X)));
 subplot(3,1,3);
 plot(real(x(1:N/4))); 

