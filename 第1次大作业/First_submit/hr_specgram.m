clear all;
close all;
window = 180;
VoiceLength = 180;
[x,Fs]=audioread('bluesky1.wav','native');           % ���������ļ�
subplot(321);
specgram(x,window,Fs,VoiceLength,135);title('ԭ�ź��˲�ǰ');
[y,Fs]=audioread('blueskyft.wav','native');           % ���������ļ�
subplot(322);
specgram(y,window,Fs,VoiceLength,135);title('ԭ�ź��˲���');
[x,Fs]=audioread('bluesky_LFnoise.wav','native');           % ���������ļ�
subplot(323);
specgram(x,window,Fs,VoiceLength,135);title('�����Ƶ�����ź��˲�ǰ');
[y,Fs]=audioread('blueskyft_LFnoise.wav','native');           % ���������ļ�
subplot(324);
specgram(y,window,Fs,VoiceLength,135);title('�����Ƶ�����ź��˲���');
[x,Fs]=audioread('bluesky_HFnoise.wav','native');           % ���������ļ�
subplot(325);
specgram(x,window,Fs,VoiceLength,135);title('�����Ƶ�����ź��˲�ǰ');
[y,Fs]=audioread('blueskyft_HFnoise.wav','native');           % ���������ļ�
subplot(326);
specgram(y,window,Fs,VoiceLength,135);title('�����Ƶ�����ź��˲���');
