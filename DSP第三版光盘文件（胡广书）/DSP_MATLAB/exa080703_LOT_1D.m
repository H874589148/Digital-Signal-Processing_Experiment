%------------------------------------------------------------------------------------
% exa080703_LOT_1d.m, for example 8.7.3 and to test function subroutine fast_lot.m;
% In this functin,there are two input parameters:
%            N ------ �źŵĳ���, Nֻ��ȡ2�������ݣ��� N��8��16��...,512;
%            p ------ ѹ��ʱ�Ĳ�����������p���������ؽ��� 0<p<=8
%
% ����ʱ��ѡ�� N �� p��Ȼ����MATLAB������ ���� exa080703_LOT_1d��N��p�����ɡ�
%------------------------------------------------------------------------------------
function exa080703_LOT_1d(N,p)

% �����ź� noissin;  
load noissin;          
x=noissin(1:N);
y1=zeros(size(x));

% ���ź��� LOT��
M=8;  L=2*M;
a=[0.13*pi 0.16*pi 0.13*pi];
P=fast_LOT(a);
%
y2=zeros(N+L,1);
x2=zeros(size(y2));
x2(1:M)=x(M:-1:1);
x2((M+1):(N+M))=x';
x2((N+M+1):N+L)=x(N:-1:N-M+1);
x3=zeros(size(x2));
for i=1:N+L-1
   if rem(i,8)==0
      y2(i-8+1:i)=P'*x2(i-8+1:i+8);
      y2(i-8+p+1:i)=0;
   end
end

%�� LOT���ؽ��źţ�
for i=1:N+L-1
   if rem(i,8)==0
      Q=P*y2(i-8+1:i);
      x3(i-8+1:i+8)=x3(i-8+1:i+8)+Q;
   end
end
x4=wkeep(x3,N);

figure;
subplot(2,1,1);plot(x);axis([1,N,-2,2]);grid;title('original signal');
subplot(2,1,2);plot(x4);axis([1,N,-2,2]);grid;title('LOT reconstruction signal');

