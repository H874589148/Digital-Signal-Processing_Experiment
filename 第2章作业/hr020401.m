clear;
den = [1 -0.5 -0.005 0.3];   %设定函数的分母向量
num=[1 2 1];         %设定函数的分子向量
figure;
freqz(num,den,'whole');