%------------------------------------------------------------------------
%  for example 10.3.2，for fig 10.3.2(a),(b)
%------------------------------------------------------------------------
clear all;

%设计IIR滤波器；
N=100;
wp=.4*pi;ws=.6*pi;Fs=1;rp=1.;rs=40; 
wap=tan(wp/2);was=tan(ws/2);         
[n,wn]=cheb1ord(wap,was,rp,rs,'s');   
[z,p,k]=cheb1ap(n,rp); 

[bp,ap]=zp2tf(z,p,k); 
[bs,as]=lp2lp(bp,ap,wap); 
[b,a]=bilinear(bs,as, Fs/2);
[h,w] = freqz(b,a,512,1); 
g = 20*log10(abs(h));

[sos,G] = tf2sos(b,a);
%转换成级联形式；
sosq=truncation(sos,4)

% 对滤波器系数按4bit量化；
R1 = sosq(1,:); R2=sosq(2,:); R3=sosq(3,:);
b1 = conv(R1(1:3),R2(1:3)); bq = G*conv(R3(1:3),b1);
a1 = conv(R1(4:6),R2(4:6)); aq = conv(R3(4:6),a1);
[hq,w] = freqz(bq,aq,512,1); 
gq = 20*log10(abs(hq));
subplot(221)
plot(w,g,'b',w,gq,'r:');grid
%axis([0 1 -70 5]);
Ylabel('Gain, dB');

sosq=truncation(sos,5)

% 对滤波器系数按5bit量化，重复上述过程；
R1 = sosq(1,:); R2=sosq(2,:); R3=sosq(3,:);
b1 = conv(R1(1:3),R2(1:3)); bq = G*conv(R3(1:3),b1);
a1 = conv(R1(4:6),R2(4:6)); aq = conv(R3(4:6),a1);
[hq,w] = freqz(bq,aq,512,1); 
gq = 20*log10(abs(hq));
subplot(222)
plot(w,g,'b',w,gq,'r:');grid
Ylabel('Gain, dB');




