clear;
b=7/10;
num0=[1 -1];
num=b*num0; %�趨�����ķ�������
den = [1 -0.4];  %�趨�����ķ�ĸ����
figure;
freqz(num,den,'whole');