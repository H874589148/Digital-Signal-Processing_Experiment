%----------------------------------------------------------------------------
% exa090501.m,  for example 9.5.1,
%----------------------------------------------------------------------------
clear;

% ����MATLAB�к��������������ļ� leleccum; 
load leleccum; 

index=1:3000;
x=leleccum(index);
N=8;
slength = length(x);
M=slength-100;
subplot(221);plot(x(1:M));
title('ԭʼ�ź�');

% �γ����ݾ���
Signal=zeros(N,M);
for i=1:N
   Signal(i,:)=x(i:M+i-1);
end

% �����ݾ���������ֵ�ֽ⣻
[U, S, V]=svd(Signal);
d=diag(S(1:N,1:N));

subplot(222);stem(d,'filling');
title('����ֵ');
for i=1:N
   if d(i)<mean(d)
      d(i)=0;
   end
end 
stemp=S;
stemp(1:8,1:8)=diag(d);
Sf=U*stemp*V';
subplot(223);plot(Sf(1,:));
title('�˲�֮����źţ���ֵΪ����ֵ��ƽ��ֵ');
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
title('�˲�֮����źţ���ֵΪ����ֵ����ֵ');

