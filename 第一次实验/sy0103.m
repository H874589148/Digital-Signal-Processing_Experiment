n=0:50;  A=444.128;
a=50*sqrt(2.0)*pi; 
w0=50*sqrt(2.0)*pi;
T=1/200; 
x=A*exp(-a*n*T).*sin(w0*n*T);
subplot(3,1,1);stem(n,x);title('理想采样信号序列');
k=-25:25;
W=(pi/12.5)*k;
f=(1/25)*k*200;
X=x*(exp(-j*pi/12.5)).^(n'*k);
magX=abs(X);
subplot(3,1,2);stem(f,magX);title('理想采样信号序列的幅度谱');
angX=angle(X);
subplot(3,1,3);stem(f,angX);title('理想采样信号序列的相位谱');