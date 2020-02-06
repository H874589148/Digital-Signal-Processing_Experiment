%----------------------------------------------------------------------
% exa100401.m , for example 10.4.1 and fig10.4.1(a),(b)
%----------------------------------------------------------------------
clear all;

% 先设计FIR滤波器；
A=[1 1  0 0];f=[0 .6 .7 1];
weigh=[1 10];	
b=remez(30,f,A,weigh);
[h,w]=freqz(b,1,512,1);
h=abs(h);g=20*log10(h);

% 用4bit量化；
bq = truncation(b,4);
[hq,w] = freqz(bq,1,512,1); 
gq = 20*log10(abs(hq));
subplot(221)
plot(w,g,'b',w,gq,'r:');grid
%axis([0 1 -80 5]);
xlabel('\omega/\pi');Ylabel('Gain, dB');
title('original - solid line, quantized - dashed line');

% 用8bit量化；
bq = truncation(b,8);
[hq,w] = freqz(bq,1,512,1);
gq = 20*log10(abs(hq));
subplot(222)
plot(w,g,'b',w,gq,'r:');grid
%axis([0 1 -80 5]);
xlabel('\omega/\pi');Ylabel('Gain, dB');
title('original - solid line, quantized - dashed line');

