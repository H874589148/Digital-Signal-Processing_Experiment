fs=8000;    %������
n=16;       %�ֱ���
[x,fs,n]=wavread('bluesky1.wav');%��ȡһ��WAVE�ļ��������ز������ݵ�����y�У�Fs��ʾ����Ƶ��, bits��ʾ����λ��
%��������Ĳα���%
ft=x(:,1);%���Ƿ��������ļ��ĵ�һ������
p1=ft(9000:9179);   P1=fft(p1,180);     subplot(221);plot(abs(P1));
p2=ft(9090:9269);   P2=fft(p2,180);     subplot(222);plot(abs(P2));
p3=ft(9180:9359);   P3=fft(p3,180);     subplot(223);plot(abs(P3));
p4=ft(9270:9349);   P4=fft(p4,180);     subplot(224);plot(abs(P4));