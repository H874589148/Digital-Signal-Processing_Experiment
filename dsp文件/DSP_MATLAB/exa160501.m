% exa160501;       
%System Identification of a 15-coefficient FIR filter 
      
clear;N=400;M=15;
x  = randn(1,N);     % Input to the filter
b  = fir1(M-1,0.5);     % FIR system to be identified
noise  = 0.1*randn(1,N); % Observation noise signal
d  = filter(b,1,x)+noise;  % Desired signal
mu = 0.02;            % LMS step size
ha = adaptfilt.lms(M,mu);
[y,e] = filter(ha,x,d);
subplot(2,1,1); plot(1:N,[d;y;e]);
title('System Identification of an FIR filter');
legend('Desired','Output','Error');
xlabel('number of iterations'); ylabel('signal value');
subplot(2,1,2); stem([b.',ha.Coefficients.']);
'b=',b
'ha=',ha.Coefficients
       
     