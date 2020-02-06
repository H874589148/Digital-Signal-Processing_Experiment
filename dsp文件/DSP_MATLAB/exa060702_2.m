%--------------------------------------------------------------------------
% exa060702_2 , for example 6.6.2 and 6.7.2;
% to test buttord.m and butter.m;
% to design a Butterworth Bandpass digital filter.
% -------------------------------------------------------------------------
clear;

fp=[300 400];fs=[200 500];
rp=3;rs=18;
Fs=2000;
wp=fp*2*pi/Fs;ws=fs*2*pi/Fs;
%
% 求出阶次；
[n,wn]=buttord(wp/pi,ws/pi,rp,rs);

% 再设计 Butterworth 带通滤波器；
[b,a]=butter(n,wp/pi)
[h,w]=freqz(b,a,256,Fs);
h=20*log10(abs(h));
plot(w,h);grid;
ylabel('Bandpass DF')
xlabel(' Hz')
