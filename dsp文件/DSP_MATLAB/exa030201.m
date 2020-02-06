%----------------------------------------------------------------------------
% exa030201, for example 3.2.1 and fig 3.2.3;
% to show Gibbs phenomena; 
%----------------------------------------------------------------------------
clear;

wc=0.6*pi;a=[1];Nf=256;
Hd1=ones(1,0.6*Nf+1);
Hd2=zeros(1,0.4*Nf);
Hd=[Hd1,Hd2]';

% 改变窗函数的长度，观察Gibbs现象
%
M=10;                                           % for M=10
N=2*M+1;                         
for n=1:N
   if (n-M)==0;
      h(n)=wc/pi;
   else
      h(n)=sin(wc*(n-M))/(pi*(n-M));
      end 
end
[H,w]=freqz(h,a,Nf,1);
subplot(221)
plot(w,Hd,'-',w,abs(H));grid on;
%
M=30;                                           % for M=30
N=2*M+1;
for n=1:N
   if (n-M)==0;
      h(n)=wc/pi;
   else
      h(n)=sin(wc*(n-M))/(pi*(n-M));
      end 
end
[H,w]=freqz(h,a,Nf,1);
subplot(222)
plot(w,Hd,'-',w,abs(H));grid on;
%
M=50;                                           %for M=50
N=2*M+1;
for n=1:N
   if (n-M)==0;
      h(n)=wc/pi;
   else
      h(n)=sin(wc*(n-M))/(pi*(n-M));
      end 
end
[H,w]=freqz(h,a,Nf,1);
subplot(223)
plot(w,Hd,'-',w,abs(H));grid on;
%
M=100;                                          % for M=100
N=2*M+1;
for n=1:N
   if (n-M)==0;
      h(n)=wc/pi;
   else
      h(n)=sin(wc*(n-M))/(pi*(n-M));
      end 
end
[H,w]=freqz(h,a,Nf,1);
subplot(224)
plot(w,Hd,'-',w,abs(H));grid on;


