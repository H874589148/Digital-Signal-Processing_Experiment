function jyxulie(k1,k2,k0) 
% k1 , k2 是阶跃序列可以平移的范围， k0 为阶跃序列的非零起点
k=k1:k2;
n=length(k);
f=zeros(1,n);
for i=k0-k1+1:1:k2-k1+1
   f(i)=1;
end
stem(k,f,'filled')
axis([k1,k2,0,1.5])
title('阶跃序列 u(k)')
end