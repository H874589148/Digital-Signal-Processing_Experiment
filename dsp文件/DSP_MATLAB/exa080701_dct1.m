%--------------------------------------------------------------------------
% exa080701_dct1.m,  for example 8.7.1
% to test dct.m;
% 调用该程序的主程序是exa080701_dct1_test.m,
%--------------------------------------------------------------------------
function x1=exa080701_dct1(N,k)

% 调出信号 noissin; 
load noissin; 
x=noissin(1:N); 
y=zeros(size(x));

% 对该信号作DCT;
for i=1:N
   if rem(i,8)==0
      y(i-8+1:i)=dct(x(i-8+1:i)); 
      y(i-k+1:i)=0;
   end; 
end

% 重建原信号；
for i=1:N
   if rem(i,8)==0
      x1(i-8+1:i)=idct(y(i-8+1:i)); 
   end; 
end

%subplot(211)
%plot(x)
%subplot(212)
%plot(x1)