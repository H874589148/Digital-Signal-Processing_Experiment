clear all;
close all;
VoiceLength = 180;
filename='bluesky1.wav';               % 设置文件名
[x,Fs]=audioread(filename,'native');           % 读入数据文件
wlen=VoiceLength;                       % 设置帧长
inc=80; win=hanning(wlen);          % 设置帧移和窗函数
N=length(x); time=(0:N-1)/Fs;        % 计算时间
y=enframe(x,win,inc)';                    % 分帧
fn=size(y,2);                                    % 帧数
frameTime=(((1:fn)-1)*inc+wlen/2)/Fs; % 计算每帧对应的时间
W2=wlen/2+1; n2=1:W2;
freq=(n2-1)*Fs/wlen;                          % 计算 FFT 后的频率刻度
Y=fft(y);                                            % 短时傅里叶变换
clf;                                                     % 初始化图形
%=====================================================%
% Plot the STFT result % 画出语谱图
%=====================================================%
%set(gcf,'Position',[20 100 600 500]);
%axes('Position',[0.1 0.1 0.85 0.5]);
imagesc(frameTime,freq,abs(Y(n2,:))); % 画出 Y 的图像
axis xy; ylabel('频率/Hz');xlabel('时间/s');
title('语谱图');
m = 64;
LightYellow = [0.6 0.6 0.6];
MidRed = [0 0 0];
Black = [0.5 0.7 1];
Colors = [LightYellow; MidRed; Black];
%colormap(SpecColorMap(m,Colors));