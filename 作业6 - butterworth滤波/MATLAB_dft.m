function y = MATLAB_dft(x)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   xΪ����ʱ�����У�yΪx����ɢ����Ҷ�任
    N = length(x);            %�������еĳ���
    %n = 0:N-1;k=n;           %ȷ��ʱ��λ������n��Ƶ��λ������k
    %WN = exp(-1i*2*pi/N);%����DFT�������ת����
    %nk = n'*k;                   %������ת���Ӿ���
    %WNnk = WN.^nk;      %������ת���Ӿ���
    %Xk = x*WNnk;            %����DFT�������x�ĸ���Ҷ�任
    y(1:N) = 0;k=0:N-1;
    for n = 1:N
        y = y + x(n)*exp(-1i*2*pi*(n-1)*k/N);
    end%y=Xk;
end

