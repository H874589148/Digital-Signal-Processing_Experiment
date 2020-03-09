clear;
[h3,maxf]=fminbnd('-(abs(1-exp(-1j*2*x)))/(abs(1-0.6*exp(1j*(pi/4-x)))*abs(1-0.6*exp(1j*(-pi/4-x))))',0,pi);
c=-1/maxf;
num1=[1 1];
num2=[1 -1];
den1=[1 -0.6*exp(1j*pi/4)];
den2=[1 -0.6*exp(-1j*pi/4)];

num=c*conv(num1,num2); %设定函数的分子向量
den = conv(den1,den2);  %设定函数的分母向量
figure;
freqz(num,den,'whole');