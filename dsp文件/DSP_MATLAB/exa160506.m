% exa160506,  例16.5.6;通道的自适应均衡；

clear all;
D  = 16;                     % Number of delay samples 
b  = [-0.6 1];   % Numerator coefficients
a  = [1 -0.9];               % Denominator coefficients 
N= 1000;                   % Number of iterations 
s  = sign(randn(1,N+D)) + j*sign(randn(1,N+D)); % QPSK signal 
n  = 0.1*(randn(1,N+D) + j*randn(1,N+D));   % Noise signal 
r  = filter(b,a,s)+n;        % Received signal 
x  = r(1+D:N+D);           % Input signal (received signal) 
d  = s(1:N);               % Desired signal (delayed QPSK signal) 
L = 26;                      % filter length 
mu = 0.007;                  % Step size 
ha = adaptfilt.lms(L,mu); 
[y,e] = filter(ha,x,d);  

subplot(221); plot(s(1:N),'.');  axis([-2 2 -2 2]); 
xlabel('Real[s]'); ylabel('Imag[s]');  grid on; 

subplot(222); plot(1:N,real([d;y;e])); 
subplot(223); plot(x(200:N),'.');  axis([-3 3 -3 3]); 
xlabel('Real[x]'); ylabel('Imag[x]');  grid on; 
subplot(224); plot(y(200:N),'.'); axis([-2 2 -2 2]); 
axis('square'); xlabel('Real[y]'); ylabel('Imag[y]');grid on;