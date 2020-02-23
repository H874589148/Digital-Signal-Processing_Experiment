%----------------------------------------------------------------------------
% exa060603.m, for example 6.6.3;
% To design IIR Butteworth bandstop DF by analog-lowpass,
% ---------------------------------------------------------------------------
clear all;

fp=[95 105];fs=[99 101];
%wp=[.19*pi 0.21*pi];ws=[.198*pi 0.202*pi];
Fs=1000;
rp=3;rs=14;
wp=fp*2*pi/Fs;ws=fs*2*pi/Fs;
%
% Firstly to finish frequency prewarping;
wap=2*Fs*tan(wp./2)
was=2*Fs*tan(ws./2);
[n,wn]=buttord(wap,was,rp,rs,'s');
% Note: 's'!
[z,p,k]=buttap(n);
[b,a]=zp2tf(z,p,k)
bw=wap(2)-wap(1)
w0=sqrt(wap(1)*wap(2))
[bt,at]=lp2bs(b,a,w0,bw)
%
% Note: z=(2/ts)(z-1)/(z+1);
[bz1,az1]=bilinear(bt,at,Fs)
[h,w]=freqz(bz1,az1,256,Fs);
figure(1)
plot(w,20*log10(abs(h)))

% Directly to design H(z) by butter.m
[n,wn]=buttord(wp/pi,ws/pi,rp,rs);
[b,a]=butter(n,wp/pi,'stop')
[h1,w1]=freqz(b,a,256,Fs);
figure(2)
plot(w1,20*log10(abs(h1)))
