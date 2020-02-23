%exa160504;  自适应一步线性预测；
clear;
N = 300;
sig = [sin(2*pi*0.01*(0:N-1)) 0.5*cos(2*pi*0.02*(0:N-1)) 1.5*sin(2*pi*0.015*(0:N-1))];
noise  = 0.4*randn(1,3*N);  
s_plus_n = sig + noise;              
x = [0 s_plus_n];                    
d = [sig 0];                  % Desired signal to the adaptive filter
M = 24;                       % NLMS adaptive filter order
mu = 0.1;                     % Normalized LMS step size.


ha = adaptfilt.nlms(M,mu,1,1e-6);
[y,e] = filter(ha,x,d);

subplot(221);plot(0:3*N-1,d(1:3*N));
ylabel('d(n)');
subplot(223);plot(0:3*N-1,y(1:3*N));
ylabel('y(n)');
subplot(222);plot(0:3*N-1,d(1:3*N),0:3*N-1,y(1:3*N));
ylabel('d(n) and y(n)');
subplot(224);plot(0:3*N-1,e(1:3*N));
ylabel('e(n)');
