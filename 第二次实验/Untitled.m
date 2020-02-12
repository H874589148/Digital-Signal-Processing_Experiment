fs=8000;    %采样率
n=16;       %分辨率
[x,fs,n]=wavread('bluesky1.wav');%读取一个WAVE文件，并返回采样数据到向量y中，Fs表示采样频率, bits表示采样位数
%定义所需的参变量%
ft=x(:,1);%我们分析声音文件的第一个声道
p1=ft(9000:9179);   P1=fft(p1,180);     subplot(221);plot(abs(P1));
p2=ft(9090:9269);   P2=fft(p2,180);     subplot(222);plot(abs(P2));
p3=ft(9180:9359);   P3=fft(p3,180);     subplot(223);plot(abs(P3));
p4=ft(9270:9349);   P4=fft(p4,180);     subplot(224);plot(abs(P4));