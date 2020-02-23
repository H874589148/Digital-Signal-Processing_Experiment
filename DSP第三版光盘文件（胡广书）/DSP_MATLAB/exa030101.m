%----------------------------------------------------------------------------
% exa030101, for example 3.1.1
% to obtain the Fourier coefficients of a continuous rectangle period signal; 
% 计算连续方波周期信号的付里叶系数
%----------------------------------------------------------------------------
clear;

T=1;tao=0.2;A=5;
s=pi*tao/T;
A1=A*tao/T;
for k=1:60
   k1=k-30;
   sk1=s*k1;
   if sk1==0;
      x(k)=1;
   else
      x(k)=sin(sk1)/sk1;
      end 
end
k=-29:30;   

subplot(211)
stem(k,x,'.')
hold
plot(k,zeros(size(x)))

