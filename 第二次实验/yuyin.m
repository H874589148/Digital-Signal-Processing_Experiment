fs=8000;    %������
n=16;       %�ֱ���
[x,fs,n]=wavread('bluesky1.wav');%��ȡһ��WAVE�ļ��������ز������ݵ�����y�У�Fs��ʾ����Ƶ��, bits��ʾ����λ��
%C������MATLAB�ȶ�����%
s1=x*(2^15);
%��������Ĳα���%
ft=x(:,1);%���Ƿ��������ļ��ĵ�һ������
sigLength=length(ft);   %��ȡ��������
halfLength = floor(sigLength/2);  
f=((0:halfLength)+1)* fs/sigLength;   
t=(0:sigLength-1)/fs;   %�������t
%��������ͼ%
subplot(4,4,1);  plot(t,ft), title('ԭʼ�����ź�ʱ����'),grid;  %��������ͼ
xlabel('ʱ���ᣨS��'); ylabel('����');
%ԭʼ�ź�Ƶ��ͼ%
X=fft(ft,sigLength); %ʹ�ÿ��ٸ���Ҷ�任�㷨��������ft����ɢ�͸���Ҷ�任  
Fx =X(1:halfLength + 1); % ֻѡȡǰ��ز���  
Fx = abs(Fx);%���ڼ��㸴������Y�����  
subplot(4,4,2);plot(f,Fx), title('ԭʼ�����źŵ�Ƶ��ͼ'),grid; %���������źŵ�Ƶ��ͼ 
xlabel('Ƶ��(Hz)'); ylabel('Ƶ�ʷ���');
%�˲����������Ƶ��ͼ%
h=[0.01218354,-0.009012882,-0.02881839,-0.04743239,-0.04584568,-0.008692503,0.06446265,0.1544655,0.2289794,0.257883,0.2289794,0.1544655,0.06446265,-0.008692503,-0.04584568,-0.04743239,-0.02881839,-0.009012882,0.01218354];
subplot(4,4,3);stem(h);title('�˲���h��ʱ������'); 
H=fft(h,19);
subplot(4,4,4);plot(abs(H)), title('�˲�����Ƶ��ͼ'),grid; %���������źŵ�Ƶ��ͼ 
xlabel('Ƶ��(Hz)'); ylabel('Ƶ�ʷ���');
%�����ƵΪ5kHz�����������������ź�%
Au1=0.03;
d1=[Au1*cos(2*pi*5000*t)]';	 %����Ϊ5kHz�������ź�
x1=ft+d1;
audiowrite('out_x1.wav',x1,fs);
subplot(4,4,5);  plot(t,x1), title('�����Ƶ�����������ź�ʱ����'),grid;  %��������ͼ
xlabel('ʱ���ᣨS��'); ylabel('����');
X1=fft(x1,sigLength);
Fx1 =X1(1:halfLength + 1); % ֻѡȡǰ��ز���  
Fx1 = abs(Fx1);%���ڼ��㸴������Y�����   
subplot(4,4,6);plot(f,Fx1), title('�����Ƶ�����������ź�Ƶ��ͼ'),grid; %���������źŵ�Ƶ��ͼ 
xlabel('Ƶ��(Hz)'); ylabel('Ƶ�ʷ���');
%�����ƵΪ500Hz�����������������ź�%
Au2=0.03;
d2=[Au2*cos(2*pi*500*t)]';	 %����Ϊ5kHz�������ź�
x2=ft+d2;
audiowrite('out_x2.wav',x2,fs);
subplot(4,4,7);  plot(t,x2), title('�����Ƶ�����������ź�ʱ����'),grid;  %��������ͼ
xlabel('ʱ���ᣨS��'); ylabel('����');
X2=fft(x2,sigLength);
Fx2 =X2(1:halfLength + 1); % ֻѡȡǰ��ز���  
Fx2 = abs(Fx2);%���ڼ��㸴������Y�����   
subplot(4,4,8);plot(f,Fx2), title('�����Ƶ�����������ź�Ƶ��ͼ'),grid; %���������źŵ�Ƶ��ͼ 
xlabel('Ƶ��(Hz)'); ylabel('Ƶ�ʷ���');
%��ԭʼ�źŽ����˲�
y=fftfilt(h,x);
audiowrite('out_y.wav',y,fs);
Y=fft(y,sigLength); %ʹ�ÿ��ٸ���Ҷ�任�㷨��������ft����ɢ�͸���Ҷ�任  
Fy =Y(1:halfLength + 1); % ֻѡȡǰ��ز���  
Fy = abs(Fy);%���ڼ��㸴������Y�����  
subplot(4,4,9);plot(f,Fy), title('ԭʼ�����ź��˲����Ƶ��ͼ'),grid; %���������źŵ�Ƶ��ͼ 
xlabel('Ƶ��(Hz)'); ylabel('Ƶ�ʷ���');
%�Լ����ƵΪ5kHz�����������������źŽ����˲�
y1=fftfilt(h,x1);
audiowrite('out_y1.wav',y1,fs);
Y1=fft(y1,sigLength); %ʹ�ÿ��ٸ���Ҷ�任�㷨��������ft����ɢ�͸���Ҷ�任  
Fy1 =Y1(1:halfLength + 1); % ֻѡȡǰ��ز���  
Fy1=abs(Fy1);%���ڼ��㸴������Y�����  
subplot(4,4,10);plot(f,Fy1), title('�����Ƶ�����������ź��˲����Ƶ��ͼ'),grid; %���������źŵ�Ƶ��ͼ 
xlabel('Ƶ��(Hz)'); ylabel('Ƶ�ʷ���');
%�Լ����ƵΪ50Hz�����������������źŽ����˲�
y2=fftfilt(h,x2);
audiowrite('out_y2.wav',y2,fs);
Y2=fft(y2,sigLength); %ʹ�ÿ��ٸ���Ҷ�任�㷨��������ft����ɢ�͸���Ҷ�任  
Fy2 =Y2(1:halfLength + 1); % ֻѡȡǰ��ز���  
Fy2=abs(Fy2);%���ڼ��㸴������Y�����  
subplot(4,4,11);plot(f,Fy2), title('�����Ƶ�����������ź��˲����Ƶ��ͼ'),grid; %���������źŵ�Ƶ��ͼ 
xlabel('Ƶ��(Hz)'); ylabel('Ƶ�ʷ���');
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
%������ͼ
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
title('������Ƶ��');
subplot(326);
spectrogram(y2,200,50,32000,8000,'yaxis');