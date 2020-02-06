%--------------------------------------------------------------------------
% exa080701_dct1.m,  for example 8.7.1
% to test dct.m;
% ���øó������������exa080701_dct1_test.m,
%--------------------------------------------------------------------------
function x1=exa080701_dct1(N,k)

% �����ź� noissin; 
load noissin; 
x=noissin(1:N); 
y=zeros(size(x));

% �Ը��ź���DCT;
for i=1:N
   if rem(i,8)==0
      y(i-8+1:i)=dct(x(i-8+1:i)); 
      y(i-k+1:i)=0;
   end; 
end

% �ؽ�ԭ�źţ�
for i=1:N
   if rem(i,8)==0
      x1(i-8+1:i)=idct(y(i-8+1:i)); 
   end; 
end

%subplot(211)
%plot(x)
%subplot(212)
%plot(x1)