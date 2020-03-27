clear all;
close all;
n = 1:32000;
[x,Fs] = audioread("bluesky1.wav",'native');
Ts = 1/Fs;
f = 10;
w = 2*pi*f*Ts;
y1 = 1*cos(w.*n)' + double(x);
%y1=y1./max(y1);
y1 = mapminmax(y1,0,1);
audiowrite('bluesky_LFnoise.wav',y1,Fs);          %写入bluesky_LFnoise.wav文件
%sound(y1,Fs);                %重新将bluesky_LFnoise.wav读入Matlab，放在y1中进行播放
f = 5000;
w = 2*pi*f*Ts;
y2 = 1*cos(w.*n)' + double(x);
%y2=y2./max(y2);
y2=mapminmax(y2,0,1);
audiowrite('bluesky_HFnoise.wav',y2,Fs);          %写入bluesky_HFnoise.wav文件
%sound(y2,Fs);                %重新将bluesky_HFnoise.wav读入Matlab，放在y2中进行播放
