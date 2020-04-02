clear all;
close all;
window = 180;
VoiceLength = 180;
[x,Fs]=audioread('bluesky1.wav','native');           % 读入数据文件
subplot(321);
specgram(x,window,Fs,VoiceLength,135);title('原信号滤波前');
[y,Fs]=audioread('blueskyft.wav','native');           % 读入数据文件
subplot(322);
specgram(y,window,Fs,VoiceLength,135);title('原信号滤波后');
[x,Fs]=audioread('bluesky_LFnoise.wav','native');           % 读入数据文件
subplot(323);
specgram(x,window,Fs,VoiceLength,135);title('加入低频噪声信号滤波前');
[y,Fs]=audioread('blueskyft_LFnoise.wav','native');           % 读入数据文件
subplot(324);
specgram(y,window,Fs,VoiceLength,135);title('加入低频噪声信号滤波后');
[x,Fs]=audioread('bluesky_HFnoise.wav','native');           % 读入数据文件
subplot(325);
specgram(x,window,Fs,VoiceLength,135);title('加入高频噪声信号滤波前');
[y,Fs]=audioread('blueskyft_HFnoise.wav','native');           % 读入数据文件
subplot(326);
specgram(y,window,Fs,VoiceLength,135);title('加入高频噪声信号滤波后');
