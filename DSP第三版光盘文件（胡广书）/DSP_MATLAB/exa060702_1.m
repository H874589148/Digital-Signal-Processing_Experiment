%--------------------------------------------------------------------------
% exa060702_1 , for example 6.6.2 and 6.7.2;
% to test buttord,buttap,lp2bp,bilinear;
% to design a Butterworth Bandpass digital filter.
% -------------------------------------------------------------------------
clear all;

fp=[300 400];fs=[200 500];
rp=3;rs=18;
Fs=2000;
wp=fp*2*pi/Fs;
ws=fs*2*pi/Fs;
%
% Firstly to finish frequency prewarping;
wap=2*Fs*tan(wp./2)
was=2*Fs*tan(ws./2);
[n,wn]=buttord(wap,was,rp,rs,'s');
% Note: 's'!
[z,p,k]=buttap(n);
[bp,ap]=zp2tf(z,p,k)
%
bw=wap(2)-wap(1)
w0=sqrt(wap(1)*wap(2))
[bs,as]=lp2bp(bp,ap,w0,bw)
%
[h1,w1]=freqs(bp,ap);
figure(1)
plot(w1,abs(h1));grid;
ylabel(' lowpass G(p)')
%
w2=[0:Fs/2-1]*2*pi;
h2=freqs(bs,as,w2);
% Note: z=(2/Ts)(z-1)/(z+1);
[bz1,az1]=bilinear(bs,as,Fs)
[h3,w3]=freqz(bz1,az1,1000,Fs);
figure(2)
plot(w2/2/pi,20*log10(abs(h2)),w3,20*log10(abs(h3)));grid;
ylabel('Bandpass AF and DF')
xlabel(' Hz')
%
