%----------------------------------------------------------------------------
% exa030102, for example 3.1.2
% to obtain the Fourier transform of a continuous rectangle  signal; 
% �������������źŵĸ���Ҷ�任
%----------------------------------------------------------------------------
clear all��

% ����˵����λ���һ��sinc������
tao=0.2;A=5;
s=pi*tao;
A1=A*tao;
for f=1:60
   f1=f-30;
   sf1=s*f1;
   if sf1==0;
      x(f)=1;
   else
      x(f)=sin(sf1)/sf1;
      end 
end
f=-29:30;   

subplot(211)
plot(f,x,f,zeros(size(x)));grid on

