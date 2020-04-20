clear all;
close all;
[x,Fs] = audioread("bluesky_LFnoise.wav",'native');
subplot(311);plot(1:32000,x);
title('加入低频噪声语音信号时域波形');
h =[0.01218354 -0.009012882 -0.02881839 -0.04743239 -0.04584568 -0.008692503 0.06446265 0.1544655 0.2289794 0.257883 0.2289794 0.1544655 0.06446265 -0.008692503 -0.04584568 -0.04743239 -0.02881839 -0.009012882 0.01218354];
y1=filter(h,1,x);
x=double(x);
%sound(y1,Fs);                %重新将滤波后wav读入Matlab，放在y1中进行播放
subplot(312);plot(1:32000,y1);
title('Matlab滤波后语音信号时域波形');
[y2,Fs2] = audioread("blueskyft_LFnoise.wav",'native');
subplot(313);plot(1:32000,y2);
title('C语言滤波后语音信号时域波形');
y2=double(y2);
sound(y2,Fs);                %重新将滤波后wav读入Matlab，放在y2中进行播放
