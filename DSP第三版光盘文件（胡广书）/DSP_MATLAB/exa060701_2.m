%-----------------------------------------------------------------------------
% exa060701_2.m , for example 6.7.1 and 6.5.1
% to test buttord,lp2lp,bilinear ;
% to design Low-pass DF with s=2/Ts[(z-1)/(z+1)]
%-----------------------------------------------------------------------------
clear all;

wp=.2*pi;ws=.6*pi;Fs=1000;
rp=3;rs=20;
%
% Firstly to finish frequency prewarping;
wap=2*Fs*tan(wp/2);was=2*Fs*tan(ws/2);
[n,wn]=buttord(wap,was,rp,rs,'s');
% Note: 's'!
[z,p,k]=buttap(n);
[bp,ap]=zp2tf(z,p,k);
[bs,as]=lp2lp(bp,ap,wap)
w1=[0:499]*2*pi;
h1=freqs(bs,as,w1);
% Note: z=(2/ts)(z-1)/(z+1);
[bz,az]=bilinear(bs,as,Fs)
[h2,w2]=freqz(bz,az,500,Fs);
plot(w1/2/pi,abs(h1),w2,abs(h2),'k');grid on;

