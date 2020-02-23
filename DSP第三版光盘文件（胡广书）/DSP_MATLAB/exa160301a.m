% exa160301a, 研究LMS算法的性能，求学习曲线。应用模型是系统辨识，见exa160501；

       
clear;
N=1000;M=15;
x  = randn(1,N);     
b  = fir1(M-1,0.5);        % 待辨识的 FIR 系统；
noise  = 0.1*randn(1,N);   % 观察噪声；
d  = filter(b,1,x)+noise;  % 希望信号；
mu1 = 0.001;                 % LMS 步长；
h_lms1 = adaptfilt.lms(M,mu1);        %LMS自适应滤波；
[y_lms1,e_lms1] = filter(h_lms1,x,d);  

figure(1)
plot(1:N,[d;y_lms1]);
legend('Desired','Output');

mu2=0.01;
h_lms2 = adaptfilt.lms(M,mu2);
%
n_repeat=100;
reset(h_lms1);
reset(h_lms2);
%
x  = randn(N,n_repeat);     
noise  = 0.1*randn(N,n_repeat);
d  = filter(b,1,x)+noise;  %
mselms_1 = msesim(h_lms1,x,d);
mselms_2 = msesim(h_lms2,x,d);

figure(2)
plot(1:N,mselms_1(1:N));
hold on;
plot(1:N,mselms_2(1:N));
ylabel('MSE');
hold on;

reset(h_lms1);
[mmselms,emselms,meanwlms,pmselms] = msepred(h_lms1,x,d);
plot(1:N,pmselms(1:N),'r');
hold on;
mmse_lms=mmselms*ones(1,N);
plot(1:N,mmse_lms(1:N));
hold on;
mmselms
emselms
[mmselms,emselms,meanwlms,pmselms] = msepred(h_lms2,x,d);
plot(1:N,pmselms(1:N),'r');
mmselms
emselms

