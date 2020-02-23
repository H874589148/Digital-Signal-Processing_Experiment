%----------------------------------------------------------------------------
% exa030903, for example 3.9.3
% to obtain the  DTFT of 2-D Hamming windows; 
%----------------------------------------------------------------------------
clear;

% 生成二维hamming窗
n=64;
x=0:1:n-1;
y=x;
s=2*pi/n;
[X,Y]=meshgrid(x,y);
f1=.54-.46*cos(s*X);
f2=.54-.46*cos(s*Y);
z=f1.*f2;
figure(1)
surf(x,y,z);
colormap([1 1 0]);

% 计算二维DTFT 
x=-n/2:1:n/2-1;
y=x;
[X,Y]=meshgrid(x,y);
z1=fft2(z);
z1=abs(z1);

% 将原点移至图的中心 
m=n/2;
  for k=1:m;
   for l=1:m;
      a(k,l)=z1(k,l);
      b(k,l)=z1(k,l+m);
      c(k,l)=z1(k+m,l);
      d(k,l)=z1(k+m,l+m);
   end
   end
   for k=1:m;
      for l=1:m;
         z1(k,l)=d(k,l);
         z1(k+m,l+m)=a(k,l);
         z1(k,l+m)=c(k,l);
         z1(k+m,l)=b(k,l);
      end
   end

% 频域用对数表示
   z1=20*log10(z1);
   figure(2)
   surf(X,Y,z1);
   colormap([1 1 0]);

