%-------------------------------------------------------------------------
% exa120802_tfe.m,  for example 12.8.2,
% to test tfe.m  ;
%-------------------------------------------------------------------------
clear all;

% ����Ŀ���Ϊ��֪��ϵͳ�ķ�Ƶ��Ӧ��
Fs=1;N=256;
A=[1 1  0 0];
f=[0 .6 .7 1];
weigh=[1 10];	
b=remez(42,f,A,weigh);
[h,w]=freqz(b,1,N,1);
h=20*log10(abs(h));
subplot(221);plot(w,h);grid;

r=rand(4096,1);
x=filter(b,1,r);
M=N*2;

% �ɺ��� tfe ��ʶ����ϵͳ�ķ�Ƶ��Ӧ��
[H,w]=tfe(r,x,M,Fs,hamming(M),0,'mean');
H=20*log10(abs(H));
subplot(222);
plot(w,H);grid;


