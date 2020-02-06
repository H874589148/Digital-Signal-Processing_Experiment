%------------------------------------------------------------------------
%  for example 10.3.1 and fig 10.3.1 (a)～(d)
%------------------------------------------------------------------------
clear all;

% 先得到 （13.2.7）式的 H(z）
N=100;
wp=.4*pi;ws=.6*pi;Fs=1;rp=1.;rs=40; 
wap=tan(wp/2);
was=tan(ws/2);         
[n,wn]=cheb1ord(wap,was,rp,rs,'s');   
[z,p,k]=cheb1ap(n,rp); 
[bp,ap]=zp2tf(z,p,k); 
[bs,as]=lp2lp(bp,ap,wap); 
[b,a]=bilinear(bs,as, Fs/2)
roots(a)
[h,w] = freqz(b,a,512,1); 
g = 20*log10(abs(h));
% 对滤波器系数用4bit量化；
bq = truncation(b,4)
aq = truncation(a,4)
roots(aq)

[hq,w] = freqz(bq,aq,512,1); 
gq = 20*log10(abs(hq));
subplot(221)
plot(w,g,'b',w,gq,'r:');grid
xlabel('\omega/\pi');Ylabel('Gain, dB');
title('original - solid line, quantized - dashed line');
subplot(222)
zplane(b,a)
plotzp(bq,aq)

% 对滤波器系数用5bit量化；
bq = truncation(b,5)
aq = truncation(a,5)
roots(aq)

[hq,w] = freqz(bq,aq,512,1);
gq = 20*log10(abs(hq));
subplot(223)
plot(w,g,'b',w,gq,'r:');grid
xlabel('\omega/\pi');Ylabel('Gain, dB');
title('original - solid line, quantized - dashed line');
subplot(224)
zplane(b,a)
plotzp(bq,aq)

bq = rounding(b,4)
aq = rounding(a,4)
roots(aq)