%-----------------------------------------------------------------------------
% exa060601_1.m , for example 6.6.1 
% to test buttord,lp2Hp,bilinear and butter
% to design high-pass DF with s=2/Ts[(z-1)/(z+1)]
%-----------------------------------------------------------------------------
clear all

wp=.8*pi;ws=.44*pi;
rp=3;rs=20;
Fs=2000;
%
% Firstly to finish frequency prewarping;
wap=2*Fs*tan(wp/2)
was=2*Fs*tan(ws/2);
[n,wn]=buttord(wap,was,rp,rs,'s');
% Note: 's'!
[z,p,k]=buttap(n);
[b,a]=zp2tf(z,p,k)
[bt,at]=lp2hp(b,a,wap)
%
% Note: z=(2/ts)(z-1)/(z+1);ts=1,that is 2fs=1,fs=0.5;
[bz,az]=bilinear(bt,at,Fs)
[h,w]=freqz(bz,az,256,1);
figure(1)
plot(w,20*log10(abs(h)));grid;
ylabel(' High-pass DF')
%
% Directly to design H(z) by butter.m
[n,wn]=buttord(wp/pi,ws/pi,rp,rs);
[b,a]=butter(n,wp/pi,'high')
[h1,w1]=freqz(b,a,256,1);
h1=20*log10(abs(h1));
figure(2)
plot(w,h1);grid
ylabel(' High-pass DF')

