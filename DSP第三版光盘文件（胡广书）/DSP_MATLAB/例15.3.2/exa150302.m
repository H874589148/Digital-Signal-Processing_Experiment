
clear all;
clc;

[x,fs] = wavread('noisy_voice.wav');
s_input = x;

s_out = wiener_speech(x,fs);

figure();
subplot(211);plot((1:length(s_input))./fs,s_input);
%title('����ǰ�ĺ�����������');
subplot(212);plot((1:length(s_out))./fs,s_out);
%title('ά���˲�����������������');

figure();
subplot(211);plot_STFT_square(s_input,fs);
%title('����ǰ�ĺ���������ͼ');
subplot(212);plot_STFT_square(s_out,fs);
%title('ά���˲���������������ͼ');

