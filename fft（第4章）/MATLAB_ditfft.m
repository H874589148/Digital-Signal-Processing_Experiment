function y = MATLAB_ditfft(x)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
    %   �˴���ʾ��ϸ˵��
    m=nextpow2(length(x));
    N=2^m;  %��x�ĳ��ȶ�Ӧ��2����ʹ���m
    if length(x)<N
        x = [x,zero(1,N-length(x))];
        %��x�ĳ��Ȳ���2���ݣ����㵽2��������
    end
    %nxd = bin2dec(fliplr(dec2bin([1:N]-1,m)))+1;
    %��1:2^m���еĵ���
    nxd0 = dec2bin([1:N]-1,m);
    nxd1 = fliplr(nxd0);
    nxd = bin2dec(nxd1)+1;
    y=x(nxd);                               %��x����������Ϊy�ĳ�ʼֵ
    for mm=1:m                          %��DFT��m�λ�2�ֽ⣬�����ң���ÿ�ηֽ���DFT����
        Nmr = 2^mm;u=1;            %��ת����u��ʼ��ΪWN^0=1
        WN=exp(-1i*2*pi/Nmr);    %���ηֽ�Ļ���DFT����WN=exp(-i*2*pi/Nmr)
        for j=1:Nmr/2                    %���ο�Խ����ڵĸ��ε�������
            for k=j:Nmr:N                %���ε�������Ŀ�Խ���ΪNmr=2^mm
                kp = k+Nmr/2;          %���ε�������Ķ�Ӧ��Ԫ�±�
                t = y(kp)*u;                %��������ĳ˻���
                y(kp) = y(k)-t;             %��������
                y(k) = y(k)+t;              %��������
            end
            u=u*WN;                       %�޸���ת���ӣ����һ������DFT����WN
        end
    end
end

