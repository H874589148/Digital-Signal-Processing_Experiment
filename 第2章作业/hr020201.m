clear;
den = [1 -0.5 -0.005 0.3];   %设定函数的分母向量
num=[1 2 1];         %设定函数的分子向量
subplot(141);
zplane(num,den);axis([-1.2 1.2 -1.2 1.2]);title('分子多项式[1 2 1]');%绘制系统函数的零极点图
[Z P K]=tf2zp(num,den);
fprintf('零点：\n');
disp(Z);
fprintf('极点：\n');
disp(P);
fprintf('增益： %.2f\n',K);
num=[0 1 2 1];         %设定函数的分子向量
subplot(142);
zplane(num,den);axis([-1.2 1.2 -1.2 1.2]);title('分子多项式[0 1 2 1]');%绘制系统函数的零极点图
num=[0 0 1 2 1];         %设定函数的分子向量
subplot(143);
zplane(num,den);axis([-1.2 1.2 -1.2 1.2]);title('分子多项式[0 0 1 2 1]');%绘制系统函数的零极点图
num=[0 0 0 1 2 1];         %设定函数的分子向量
subplot(144);
zplane(num,den);axis([-1.2 1.2 -1.2 1.2]);title('分子多项式[0 0 0 1 2 1]');%绘制系统函数的零极点图
