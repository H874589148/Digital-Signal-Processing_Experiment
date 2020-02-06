% exa160301b, 研究LMS算法的性能，求学习曲线。应用模型是系统辨识，见exa160501；

clear all;
       N1=1000;
       N=100;
       M=15;
       b  = fir1(M-1,0.5);     % FIR system to be identified
        mu1 = 0.001;            % LMS step size
        mu2 = 0.01;             % LMS step size
       for k=1:N
       x  = randn(1,N1);     % Input to the filter
       noise  = 0.1*randn(1,N1); % Observation noise signal
       d  = filter(b,1,x)+noise;  % Desired signal
       ha1 = adaptfilt.lms(M,mu1);
       [y1,e1] = filter(ha1,x,d);
       e21(k,:)=e1;
       ha2 = adaptfilt.lms(M,mu2);
       [y2,e2] = filter(ha2,x,d);
       e22(k,:)=e2;
       end
       
E_mu1 = sum(e21.^2,1)./N;
E_mu2 = sum(e22.^2,1)./N;

figure(1)
plot(E_mu1);grid;
hold on;
plot(E_mu2);
hold on;
xlabel('Number of interations')
ylabel('Mean square error for mu1,mu2')


N=10*N;
for k=1:N
       x  = randn(1,N1);     % Input to the filter
       noise  = 0.1*randn(1,N1); % Observation noise signal
       d  = filter(b,1,x)+noise;  % Desired signal
       ha1 = adaptfilt.lms(M,mu1);
       [y1,e1] = filter(ha1,x,d);
       e21(k,:)=e1;
       ha2 = adaptfilt.lms(M,mu2);
       [y2,e2] = filter(ha2,x,d);
       e22(k,:)=e2;
       end
       E_mu1 = sum(e21.^2,1)./N;
       E_mu2 = sum(e22.^2,1)./N;

plot(E_mu1,'r');grid;
hold on;
plot(E_mu2,'r');

           
      rd=xcorr(d,'biased');
      rx=xcorr(x,'biased');
      rxd=xcorr(d,x,'biased');
      RX=toeplitz(rx(N1:(N1+(M-1))));
      e_min=rd(N1)-rxd(N1:(N1+(M-1)))*inv(RX)*rxd(N1:(N1+(M-1)))';
 e_min
