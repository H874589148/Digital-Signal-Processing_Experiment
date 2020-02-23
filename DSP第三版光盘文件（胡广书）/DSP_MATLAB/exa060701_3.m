%-----------------------------------------------------------------------------
% exa060701_3.m , for example 6.7.1 and 6.5.1
% to test  butter.m
%-----------------------------------------------------------------------------
clear all;

wp=.2*pi;
ws=.6*pi;
Fs=1000;
rp=3;rs=20;
% Firstly to finish frequency prewarping;
[n,wn]=buttord(wp/pi,ws/pi,rp,rs);
[bz,az]=butter(n,wp/pi)
%
[bz1,az1]=butter(n,wn)
%
[h,w]=freqz(bz,az,128,Fs);
[h1,w1]=freqz(bz1,az1,128,Fs);
plot(w,abs(h),w1,abs(h1),'g.');grid on;

