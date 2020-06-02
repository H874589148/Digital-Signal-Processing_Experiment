clear;
num=[2 -2.9];         %设定函数的分子向量
den = [1 -2.9 1];   %设定函数的分母向量
%disp(roots(num));    %输出零点
%disp(roots(den));    %输出极点
[Z P K]=tf2zp(num,den);
fprintf('零点：\n');
disp(Z);
fprintf('极点：\n');
disp(P);
fprintf('增益： %.2f\n',K);
zplane(num,den);   %绘制系统函数的零极点图
