clc;clear;close all;
winsize = 256; % 窗长
n = 0.2; % 噪声水平
a = 2;
b = 5;
c = 0.01;
[speech, fs, nbits] = wavread('bluesky1.wav'); % 读入wav文件
sound(speech, fs);
pause(5);
size = length(speech); % 语音长度
numofwin = floor(size / winsize); % 窗数
% 定义汉明窗
ham = hamming(winsize)';
hamwin=zeros(1,size);
enhanced=zeros(1,size);
improved=zeros(1,size);%生成噪声信号

y=speech(:,1)' + n * randn(1, size) 
sound(y, fs);
pause(5); % 噪声处理
noisy = n * randn(1, winsize);
Q = fft(speech);
N = fft(noisy);
npow = abs(N);
for q = 1 : 2 * numofwin - 1
    yframe = y(1 + (q - 1) * winsize / 2 : winsize + (q - 1) * winsize / 2); % 分帧
    hamwin(1 + (q - 1) * winsize / 2 : winsize + (q - 1) * winsize / 2) = hamwin(1 + (q - 1) * winsize / 2 : winsize + (q - 1) * winsize / 2) + ham;
    %加噪信号FFT
    y1 = fft(yframe.*ham);
    ypow = abs(y1); % 加噪信号幅度
    yangle = angle(y1); % 相位
    % 计算功率谱密度
    Py = ypow.^2;
    Pn = npow.^2;
    Pyy = ypow.^a;
    Pnn = npow.^a; % 基本谱减
    for i = 1 : winsize
        if Py(i) - Pn(i) > 0Ps(i) = Py(i) - Pn(i);
        else Ps(i) = 0;
        end
    end
    s = sqrt(Ps).*exp(j*yangle);
    for i = 1 : winsize
        if Pyy(i) - b * Pnn(i) > 0
            Pss(i) = Pyy(i) - b * Pnn(i);
        else Pss(i) = c * Pnn(i);
        end
    end
    ss = Pss.^(1/a).*exp(j*yangle);
    % 去噪语音
    IFFTenhanced(1 + (q - 1) * winsize / 2 : winsize + (q - 1) * winsize / 2) = enhanced(1 + (q - 1) * winsize / 2 : winsize + (q - 1) * winsize / 2) + real(ifft(s));
    improved(1 + (q - 1) * winsize / 2 : winsize + (q - 1) * winsize / 2) = improved(1 + (q - 1) * winsize / 2 : winsize + (q - 1) * winsize / 2) + real(ifft(ss));
end
% 去除汉明窗引起的增益
for i = 1 : size
    if hamwin(i) == 0
        enhanced(i) = 0;
        improved(i) = 0;
    else
        enhanced(i) = enhanced(i) / hamwin(i);
        improved(i) = improved(i) / hamwin(i);
    end
end
SNR1 = 10 * log10(var (speech(: , 1)')/var(noisy));%加噪语音信噪比
SNR2=10*log10(var(speech(:,1)')/var (enhanced - speech(: , 1)'));%增强语音信噪比
SNR3=10*log10(var(speech(:,1)')/var (improved - speech(: , 1)'));
figure(1);subplot(2,1,1);plot(speech);%原始语音波形
axis([0 150000 -2 2]);
title(['Original Voice(n = ',num2str(n),')']);
figure(1);subplot(2,1,2);plot(y);
title(['Noise Added(SNR = ',num2str(SNR1),'dB)']);
figure(2);subplot(2,1,1);plot(enhanced);
title(['Enhanced Voice(SNR = ',num2str(SNR2),'dB)']);
figure(2);subplot(2,1,2);plot(improved);
title(['Improved Voice(SNR = ',num2str(SNR3),'dB)']);
figure(3);subplot(2,1,1);plot(abs(Q));
title('原信号fft频谱');
figure(3);subplot(2,1,2);plot(abs(N));
title('噪声信号fft频谱');
sound(enhanced,fs);
pause(5);
sound(improved,fs);
