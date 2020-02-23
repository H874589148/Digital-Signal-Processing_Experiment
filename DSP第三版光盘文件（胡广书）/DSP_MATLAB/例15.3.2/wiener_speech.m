function y = wiener_speech(x,fs)
    % ��������ά���˲������ƺ����������ź��е�������
    % ����һ��ʼ��0.2s Ϊ�����źţ�������������
    
    IS = 0.2;                               % �趨��������ʼ�����������źų��ȣ�
    window_length = 0.02;                    % �趨����Ĭ��0.02s��
    wnd_length = fix(window_length*fs);
    wnd = hamming(wnd_length);
    inc = fix(wnd_length / 2); 
    [f,t] = cut_frame(x,wnd,inc);             % �������źŷ�֡��
    silentFrameNo=fix((IS*fs-wnd_length)/(0.5*wnd_length) +1);           %�������ڹ��������׵�֡����
    f=f';
    Y = fft(f);
    [m,n] = size(Y);
    YPhase = angle(Y((1:(fix(m/2)+1)),:));
    YY = abs(Y(1:(fix(m/2)+1),:));
    noise_est = mean(YY(:,1:silentFrameNo)'.^2)';
    X=zeros(size(YY));
    X = wienerfilter(YY,silentFrameNo,noise_est);      % ����ά���˲����̵ĺ��ĺ�����

    XX = X.*exp(1i*YPhase);
if mod(size(f,1),2)
    XX=[XX;flipud(conj(XX(2:end,:)))];
else
    XX=[XX;flipud(conj(XX(2:end-1,:)))];
end
    s_out = real(ifft(XX));
    Output = add_overlap(s_out',wnd,inc);
    y = Output;
end    
    



    
  
    
    
    
    