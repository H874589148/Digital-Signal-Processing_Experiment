% exa160405, 自适应谱线增强；
clear;
delay  = 1;                   % 样本延迟数； 
N= 5000;                      % 迭代次数，数据长度； 
s  = 0.5*sin(2*pi*0.05*[0:N+delay-1])+sin(2*pi*0.1*[0:N+delay-1]); 
noise  = 2*randn(1,N+delay);         
x  = s(1:N);                  % Input signal  
d  = s(1+delay:N+delay)+noise(1+delay:N+delay); % Desired signal 

mu = 0.001;                    
ha = adaptfilt.lms(32,mu); 
[y,e] = filter(ha,x,d);  

subplot(321); plot(N-100:N,s(N-100:N)); 
ylabel('s(n)');
subplot(323); plot(N-100:N,d(N-100:N)); 
hold on;
ylabel('d(n)');
subplot(325); plot(N-100:N,y(N-100:N)); 
ylabel('y(n)');

[pdd,w] = pwelch(d(N-1000:N));
[pyy,w] = pwelch(y(N-1000:N));   
[pss,w] = pwelch(s(N-1000:N)); 

subplot(322);  
plot(w/pi/2,10*log10(pss)); 
ylabel('X(w)');

subplot(324); 
plot(w/pi/2,10*log10(pdd)); 
ylabel('D(w)')
 
subplot(326); 
plot(w/pi/2,10*log10(pyy)); 
ylabel('Y(w)');


