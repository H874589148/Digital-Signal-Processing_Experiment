function jyxulie(k1,k2,k0) 
% k1 , k2 �ǽ�Ծ���п���ƽ�Ƶķ�Χ�� k0 Ϊ��Ծ���еķ������
k=k1:k2;
n=length(k);
f=zeros(1,n);
for i=k0-k1+1:1:k2-k1+1
   f(i)=1;
end
stem(k,f,'filled')
axis([k1,k2,0,1.5])
title('��Ծ���� u(k)')
end