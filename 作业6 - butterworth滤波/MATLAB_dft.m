function y = MATLAB_dft(x)
%UNTITLED2 此处显示有关此函数的摘要
%   x为给定时间序列，y为x的离散傅里叶变换
    N = length(x);            %输入序列的长度
    %n = 0:N-1;k=n;           %确定时域位置序列n和频域位置序列k
    %WN = exp(-1i*2*pi/N);%计算DFT所需的旋转因子
    %nk = n'*k;                   %构成旋转因子矩阵
    %WNnk = WN.^nk;      %构成旋转因子矩阵
    %Xk = x*WNnk;            %按照DFT定义计算x的傅里叶变换
    y(1:N) = 0;k=0:N-1;
    for n = 1:N
        y = y + x(n)*exp(-1i*2*pi*(n-1)*k/N);
    end%y=Xk;
end

