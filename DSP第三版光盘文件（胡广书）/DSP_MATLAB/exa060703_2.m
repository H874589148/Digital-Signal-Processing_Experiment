%----------------------------------------------------------------------------
% exa060703_2.m , for example 6.7.3;
% to test cheb1ord,cheby1,
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
% Éè¼ÆÇÐ±ÈÑ©·òÂË²¨Æ÷£»
[n,wn]=cheb1ord(ws/pi,wp/pi,rp,rs);
[bz1,az1]=cheby1(n,rp,wp/pi)
[h,w]=freqz(bz1,az1,256,Fs);
h=20*log10(abs(h));
plot(w,h);grid on;




