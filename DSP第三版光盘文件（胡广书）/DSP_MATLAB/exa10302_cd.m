%------------------------------------------------------------------------
%  for example 10.3.2，for fig10.3.2 (c),(d)
%------------------------------------------------------------------------
clear;

%设计IIR滤波器；
N=100;
wp=.4*pi;ws=.6*pi;Fs=1;rp=1.;rs=40; 
wap=tan(wp/2);was=tan(ws/2);         
[n,wn]=cheb1ord(wap,was,rp,rs,'s');   
[z,p,k]=cheb1ap(n,rp); 

[bp,ap]=zp2tf(z,p,k); 
[bs,as]=lp2lp(bp,ap,wap); 
[b,a]=bilinear(bs,as, Fs/2);
[h,w] = freqz(b,a,512,1); g = 20*log10(abs(h));

%对应并联实现；
[r,p,k] = residuez(b,a);
[b1,a1]=residuez(r(1:2),p(1:2),0);
[b2,a2]=residuez(r(3:4),p(3:4),0);
[b3,a3]=zp2tf(0,p(5),r(5));

% 对滤波器系数按4bit量化；
bq1 = truncation(b1,4);
aq1 = truncation(a1,4);
bq2 = truncation(b2,4);
aq2 = truncation(a2,4);
bq3 = truncation(b3,4);
aq3 = truncation(a3,4);
kq  = truncation(k,4);


[h1,w] = freqz(bq1,aq1,512,1); 
[h2,w] = freqz(bq2,aq2,512,1); 
[h3,w] = freqz(bq3,aq3,512,1); 
[h4,w] = freqz(kq,1,512,1); 

hq=h1+h2+h3+h4;
gq = 20*log10(abs(hq));
subplot(221)
plot(w,g,'b',w,gq,'r:');grid
Ylabel('Gain, dB');

% 对滤波器系数按5bit量化；
bq1 = truncation(b1,5);
aq1 = truncation(a1,5);
bq2 = truncation(b2,5);
aq2 = truncation(a2,5);
bq3 = truncation(b3,5);
aq3 = truncation(a3,5);
kq  = truncation(k,5);


[h1,w] = freqz(bq1,aq1,512,1); 
[h2,w] = freqz(bq2,aq2,512,1); 
[h3,w] = freqz(bq3,aq3,512,1); 
[h4,w] = freqz(kq,1,512,1); 

hq=h1+h2+h3+h4;
gq = 20*log10(abs(hq));
subplot(222)
plot(w,g,'b',w,gq,'r:');grid
Ylabel('Gain, dB');

