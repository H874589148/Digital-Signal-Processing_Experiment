%-------------------------------------------------------------------------
% exa130702_specgram.m ,for example 13.7.2  and fig13.7.1
% to test specgram.m 
%-------------------------------------------------------------------------
clear;

t=0:0.001:1.024-.001; 
N=1024; 

% 得到两个Chirp 信号，并相加；
y1=chirp(t,0,1,350);
y2=chirp(t,350,1,0);
y=y1+y2;
subplot(211);plot(t,y1);
ylabel(' Chirp signal y1')

% 求两个Chirp 信号和的短时傅里叶变换；
[S,F,T]=specgram(y,127,1,hanning(127),126); 
subplot(212);
surf(T/1000,F,abs(S).^2)
view(-80,30);
shading flat;
colormap(cool);
xlabel('Time')
ylabel('Frequency')
zlabel('spectrogram')

   
  