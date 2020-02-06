
clear all;
clc;

[x,fs] = wavread('noisy_voice.wav');
s_input = x;

s_out = wiener_speech(x,fs);

figure();
subplot(211);plot((1:length(s_input))./fs,s_input);
%title('处理前的含噪语音波形');
subplot(212);plot((1:length(s_out))./fs,s_out);
%title('维纳滤波器处理后的语音波形');

figure();
subplot(211);plot_STFT_square(s_input,fs);
%title('处理前的含噪语音谱图');
subplot(212);plot_STFT_square(s_out,fs);
%title('维纳滤波器处理后的语音谱图');

