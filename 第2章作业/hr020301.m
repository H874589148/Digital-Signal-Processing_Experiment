clear;
syms z
hr=(z-0.8*exp(1)^(i*pi/6))*(z-0.8*exp(1)^(-i*pi/6));
den = sym2poly(hr);   %设定函数的分母向量
num1=[1 2 0];         %设定函数的分子向量
subplot(221);zplane(num1,den);title('(1)零极点分布图');%绘制系统函数的零极点图
subplot(222);impz(num1,den);title('(1)单位脉冲响应');%绘制系统函数的单位脉冲响应
num2=[1 -2 0];         %设定函数的分子向量
subplot(223);zplane(num2,den);title('(2)零极点分布图');%绘制系统函数的零极点图
subplot(224);impz(num2,den);title('(2)单位脉冲响应');%绘制系统函数的单位脉冲响应