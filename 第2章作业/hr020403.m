clear;
[h3,maxf]=fminbnd('-(abs(1-exp(-1j*2*x)))/(abs(1-0.6*exp(1j*(pi/4-x)))*abs(1-0.6*exp(1j*(-pi/4-x))))',0,pi);
c=-1/maxf;
num1=[1 1];
num2=[1 -1];
den1=[1 -0.6*exp(1j*pi/4)];
den2=[1 -0.6*exp(-1j*pi/4)];

num=c*conv(num1,num2); %�趨�����ķ�������
den = conv(den1,den2);  %�趨�����ķ�ĸ����
figure;
freqz(num,den,'whole');