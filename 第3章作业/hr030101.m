clear; close all;                   % 清除工作区变量，清除已绘制图形
hb=zeros(1,50);                 % 注意：MATLAB 中数组下标从 1 开始
hb(1)=1; hb(2)=2.5; hb(3)=2.5; hb(4)=1;
subplot(4,2,1);stem(hb);title('系统 hb[n]');
w=[-800:1:800]*4*pi/800;
%频域共-800--+800的长度，本应是无穷，高频分量很少，故省去
% ========== 求DTFT变换并绘图，采用原始定义对复指数分量求和 ============
H=hb(1)+hb(2)*exp(-1j*w)+hb(3)*exp(-2j*w)+hb(4)*exp(-3j*w);
subplot(4,2,2);plot(w,abs(H));title('系统信号DTFT H[w]');

n=1:50; Ts=0.001;                       % 定义序列的长度是和采样率
A=444.128; a=50*sqrt(2.0)*pi;       % 设置信号有关参数
w0=50*sqrt(2.0)*pi;
x=A*exp(-a*n*Ts).*sin(w0*n*Ts);   % 信号乘可采用".*”
subplot(4,2,3);stem(x);title('输入信号 x[n]');
% ========== 求DTFT变换并绘图，采用原始定义对复指数分量求和 ============
X = exp(-1i*(w'.*n))*x';
subplot(4,2,4);plot(w,abs(X));title('输入信号DTFT X[w]');

y=conv(x,hb);
subplot(4,2,5);stem(y);title('输出信号 y[n]');
% ========== 求DTFT变换并绘图，采用原始定义对复指数分量求和 ============
n=1:99;
%频域共-800--+800的长度，本应是无穷，高频分量很少，故省去
Y = exp(-1i*(w'.*n))*y';
subplot(4,2,6);plot(w,abs(Y));title('输出信号DTFT Y[w]');

Y0=H.*X';
subplot(4,2,8);plot(w,abs(Y0));title('DTFT乘积 Y0[w]=H[w]*X[w]');
