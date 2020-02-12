fs=8000;    %采样率
n=16;       %分辨率
[x,fs,n]=wavread('bluesky1.wav');%读取一个WAVE文件，并返回采样数据到向量y中，Fs表示采样频率, bits表示采样位数
%C语言与MATLAB比对数据%
s1=x*(2^15);
%定义所需的参变量%
ft=x(:,1);%我们分析声音文件的第一个声道
sigLength=length(ft);   %获取声音长度
halfLength = floor(sigLength/2);  
f=((0:halfLength)+1)* fs/sigLength;   
t=(0:sigLength-1)/fs;   %定义变量t
%做出语谱图%
subplot(4,4,1);  plot(t,ft), title('原始语音信号时域波形'),grid;  %做出语谱图
xlabel('时间轴（S）'); ylabel('幅度');
%原始信号频谱图%
X=fft(ft,sigLength); %使用快速傅里叶变换算法返回向量ft的离散型傅里叶变换  
Fx =X(1:halfLength + 1); % 只选取前半截部分  
Fx = abs(Fx);%用于计算复向量的Y的振幅  
subplot(4,4,2);plot(f,Fx), title('原始语音信号的频谱图'),grid; %做出语音信号的频谱图 
xlabel('频率(Hz)'); ylabel('频率幅度');
%滤波器的设计与频谱图%
h=[0.01218354,-0.009012882,-0.02881839,-0.04743239,-0.04584568,-0.008692503,0.06446265,0.1544655,0.2289794,0.257883,0.2289794,0.1544655,0.06446265,-0.008692503,-0.04584568,-0.04743239,-0.02881839,-0.009012882,0.01218354];
subplot(4,4,3);stem(h);title('滤波器h的时域特性'); 
H=fft(h,19);
subplot(4,4,4);plot(abs(H)), title('滤波器的频谱图'),grid; %做出语音信号的频谱图 
xlabel('频率(Hz)'); ylabel('频率幅度');
%加入高频为5kHz的余弦噪声的语音信号%
Au1=0.03;
d1=[Au1*cos(2*pi*5000*t)]';	 %噪声为5kHz的余弦信号
x1=ft+d1;
audiowrite('out_x1.wav',x1,fs);
subplot(4,4,5);  plot(t,x1), title('加入高频噪声的语音信号时域波形'),grid;  %做出语谱图
xlabel('时间轴（S）'); ylabel('幅度');
X1=fft(x1,sigLength);
Fx1 =X1(1:halfLength + 1); % 只选取前半截部分  
Fx1 = abs(Fx1);%用于计算复向量的Y的振幅   
subplot(4,4,6);plot(f,Fx1), title('加入高频噪声的语音信号频谱图'),grid; %做出语音信号的频谱图 
xlabel('频率(Hz)'); ylabel('频率幅度');
%加入低频为500Hz的余弦噪声的语音信号%
Au2=0.03;
d2=[Au2*cos(2*pi*500*t)]';	 %噪声为5kHz的余弦信号
x2=ft+d2;
audiowrite('out_x2.wav',x2,fs);
subplot(4,4,7);  plot(t,x2), title('加入低频噪声的语音信号时域波形'),grid;  %做出语谱图
xlabel('时间轴（S）'); ylabel('幅度');
X2=fft(x2,sigLength);
Fx2 =X2(1:halfLength + 1); % 只选取前半截部分  
Fx2 = abs(Fx2);%用于计算复向量的Y的振幅   
subplot(4,4,8);plot(f,Fx2), title('加入低频噪声的语音信号频谱图'),grid; %做出语音信号的频谱图 
xlabel('频率(Hz)'); ylabel('频率幅度');
%对原始信号进行滤波
y=fftfilt(h,x);
audiowrite('out_y.wav',y,fs);
Y=fft(y,sigLength); %使用快速傅里叶变换算法返回向量ft的离散型傅里叶变换  
Fy =Y(1:halfLength + 1); % 只选取前半截部分  
Fy = abs(Fy);%用于计算复向量的Y的振幅  
subplot(4,4,9);plot(f,Fy), title('原始语音信号滤波后的频谱图'),grid; %做出语音信号的频谱图 
xlabel('频率(Hz)'); ylabel('频率幅度');
%对加入高频为5kHz的余弦噪声的语音信号进行滤波
y1=fftfilt(h,x1);
audiowrite('out_y1.wav',y1,fs);
Y1=fft(y1,sigLength); %使用快速傅里叶变换算法返回向量ft的离散型傅里叶变换  
Fy1 =Y1(1:halfLength + 1); % 只选取前半截部分  
Fy1=abs(Fy1);%用于计算复向量的Y的振幅  
subplot(4,4,10);plot(f,Fy1), title('加入高频噪声的语音信号滤波后的频谱图'),grid; %做出语音信号的频谱图 
xlabel('频率(Hz)'); ylabel('频率幅度');
%对加入低频为50Hz的余弦噪声的语音信号进行滤波
y2=fftfilt(h,x2);
audiowrite('out_y2.wav',y2,fs);
Y2=fft(y2,sigLength); %使用快速傅里叶变换算法返回向量ft的离散型傅里叶变换  
Fy2 =Y2(1:halfLength + 1); % 只选取前半截部分  
Fy2=abs(Fy2);%用于计算复向量的Y的振幅  
subplot(4,4,11);plot(f,Fy2), title('加入低频噪声的语音信号滤波后的频谱图'),grid; %做出语音信号的频谱图 
xlabel('频率(Hz)'); ylabel('频率幅度');
m=180;
p1=ft(9000:9179);
p2=ft(9090:9269);
p3=ft(9180:9359);
p4=ft(9270:9349);
P1=fft(p1,180);
P2=fft(p2,180);
P3=fft(p3,180);
P4=fft(p4,180);
subplot(4,4,13);plot(abs(P1));
subplot(4,4,14);plot(abs(P2));
subplot(4,4,15);plot(abs(P3));
subplot(4,4,16);plot(abs(P4));
%画语谱图
figure;
subplot(321);
spectrogram(ft,200,50,32000,8000,'yaxis');
subplot(322);
spectrogram(y,200,50,32000,8000,'yaxis');
subplot(323);
spectrogram(x1,200,50,32000,8000,'yaxis');
subplot(324);
spectrogram(y1,200,50,32000,8000,'yaxis');
subplot(325);
spectrogram(x2,200,50,32000,8000,'yaxis');
title('加噪声频谱');
subplot(326);
spectrogram(y2,200,50,32000,8000,'yaxis');