%-----------------------------------------------------------------------------
% exa060701_1.m , for example 6.7.1 and 6.5.1
% to test buttord,lp2lp,bilinear ;to design Low-pass DF with s=(z-1)/(z+1)
%-----------------------------------------------------------------------------
clear all;

fp=100;fs=300;Fs=1000;
rp=3;rs=20;
% 
wp=2*pi*fp/Fs;
ws=2*pi*fs/Fs;
Fs=Fs/Fs;  % let Fs=1   
% Firstly to finish frequency prewarping ;
wap=tan(wp/2);was=tan(ws/2); %
[n,wn]=buttord(wap,was,rp,rs,'s') %
% Note: 's'!
[z,p,k]=buttap(n);   %
[bp,ap]=zp2tf(z,p,k) %
[bs,as]=lp2lp(bp,ap,wap) %
% Note: s=(2/Ts)(z-1)/(z+1);Ts=1,that is 2fs=1,fs=0.5;
[bz,az]=bilinear(bs,as,Fs/2) %
[h,w]=freqz(bz,az,256,Fs*1000);
plot(w,abs(h));grid on;

