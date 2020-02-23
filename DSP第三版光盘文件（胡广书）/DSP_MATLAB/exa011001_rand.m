%-----------------------------------------------------------------
% exa011001_rand.m: for example 1.10.1
% to test rand.m and to generate the white noise signal u(n) 
%                   with uniform distribution
% �������ȷֲ�����������ź�,���۲����ݷֲ���ֱ��ͼ
%-----------------------------------------------------------------
clear;

N=50000;           
u=rand(1,N);       
u_mean=mean(u)     
power_u=var(u)     
subplot(211)       
plot(u(1:100));grid on;
ylabel('u(n)')     
xlabel('n')     
subplot(212)       
hist(u,50);grid on;         
ylabel('histogram of u(n)')     

