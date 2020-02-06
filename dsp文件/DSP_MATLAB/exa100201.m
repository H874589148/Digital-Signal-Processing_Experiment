%------------------------------------------------------------------------
%  for example 10.2.1 and fig 10.2.1 (a),(b)
%------------------------------------------------------------------------
clear all;

% 先得到 （10.2.7）式的 H(z）
N=100;
wp=.4*pi;ws=.6*pi;Fs=1;rp=1.;rs=40; 
wap=tan(wp/2);was=tan(ws/2);         
[n,wn]=cheb1ord(wap,was,rp,rs,'s');   
[z,p,k]=cheb1ap(n,rp); 

[bp,ap]=zp2tf(z,p,k); 
[bs,as]=lp2lp(bp,ap,wap); 
[b,a]=bilinear(bs,as, Fs/2);
[h,w] = freqz(b,a,512,1); g = 20*log10(abs(h));
subplot(221)
plot(w,g);grid
%Ylabel('Gain, dB');

[hn,T]=impz(b,a,N);
subplot(222)
stem(T,hn,'.');grid;

 sum=0;
 for k=1:N
    sum=sum+hn(k)^2;
 end
 sum


