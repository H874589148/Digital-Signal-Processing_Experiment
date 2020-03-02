[hr_y]=xlsread('hr15.xlsx','A1:A100');
[hr_t]=xlsread('hr15.xlsx','B1:B100');
subplot(311);plot(hr_y,hr_t);
maxlag=32;
%hr_t=hr_t-mean(hr_t); %调整hr_t的均值
n = length(hr_t) ;

rx=xcorr(hr_t,maxlag);%xcorr(,maxlag)xcorr(,'biased')
subplot(312) ;
plot(rx(maxlag:end));
%plot(rx(n:end));%取中点n为起始的后面n个序列
title('xcorr求自相关') ;

[ACF,lags,bounds] = autocorr(hr_t,n-1) ;
subplot(313) ;
plot(lags(1:end),ACF(1:end)) ;
title('autocorr求自相关') ;
