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
audiowrite('bluesky_LFnoise.wav',y1,Fs);          %д��bluesky_LFnoise.wav�ļ�
%sound(y1,Fs);                %���½�bluesky_LFnoise.wav����Matlab������y1�н��в���
f = 5000;
w = 2*pi*f*Ts;
y2 = 1*cos(w.*n)' + double(x);
%y2=y2./max(y2);
y2=mapminmax(y2,0,1);
audiowrite('bluesky_HFnoise.wav',y2,Fs);          %д��bluesky_HFnoise.wav�ļ�
%sound(y2,Fs);                %���½�bluesky_HFnoise.wav����Matlab������y2�н��в���
