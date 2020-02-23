%----------------------------------------------------------------------------
% exa060703_1.m , for example 6.7.3;
% to test cheb1ord,cheb1ap, 
% to design a Chebyshev-I Bandpass DF.
%----------------------------------------------------------------------------
clear all;

f1=300;f3=500;
fsl=200;fsh=600;
rp=0.1;rs=30;
Fs=2000;
%
wp1=2*pi*f1/Fs;
wp3=2*pi*f3/Fs;
wsl=2*pi*fsl/Fs;
wsh=2*pi*fsh/Fs;
wp=[wp1 wp3];ws=[wsl wsh];
%
% Firstly to finish frequency prewarping;
wap=2*Fs*tan(wp./2);
was=2*Fs*tan(ws./2);
[n,wn]=cheb1ord(wap,was,rp,rs,'s');
% Note: 's'!
[z,p,k]=cheb1ap(n,rp);
[bp,ap]=zp2tf(z,p,k);
bw=wap(2)-wap(1);
w0=sqrt(wap(1)*wap(2));
[bs,as]=lp2bp(bp,ap,w0,bw);
%
% Note: z=(2/Ts)(z-1)/(z+1);
[bz1,az1]=bilinear(bs,as,Fs)
[h,w]=freqz(bz1,az1,256,Fs);
plot(w,20*log10(abs(h)));grid on;



