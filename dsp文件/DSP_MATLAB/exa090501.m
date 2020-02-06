%----------------------------------------------------------------------------
% exa090501.m,  for example 9.5.1,
%----------------------------------------------------------------------------
clear;

% 调用MATLAB中含有噪声的数据文件 leleccum; 
load leleccum; 

index=1:3000;
x=leleccum(index);
N=8;
slength = length(x);
M=slength-100;
subplot(221);plot(x(1:M));
title('原始信号');

% 形成数据矩阵；
Signal=zeros(N,M);
for i=1:N
   Signal(i,:)=x(i:M+i-1);
end

% 对数据矩阵作特征值分解；
[U, S, V]=svd(Signal);
d=diag(S(1:N,1:N));

subplot(222);stem(d,'filling');
title('特征值');
for i=1:N
   if d(i)<mean(d)
      d(i)=0;
   end
end 
stemp=S;
stemp(1:8,1:8)=diag(d);
Sf=U*stemp*V';
subplot(223);plot(Sf(1,:));
title('滤波之后的信号；阈值为特征值的平均值');
d=diag(S(1:N,1:N));
for i=1:N
      if d(i)<=median(d)
      d(i)=0;
   end
end
stemp=S;
stemp(1:8,1:8)=diag(d);
Sf=U*stemp*V';
subplot(224);plot(Sf(1,:));
title('滤波之后的信号；阈值为特征值的中值');

