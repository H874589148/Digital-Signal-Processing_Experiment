function y = wiener_speech(x,fs)
    % 本程序用维纳滤波器抑制含噪声语音信号中的噪声；
    % 假设一开始的0.2s 为噪声信号，不含有语音。
    
    IS = 0.2;                               % 设定参数：初始不含语音的信号长度；
    window_length = 0.02;                    % 设定窗宽；默认0.02s；
    wnd_length = fix(window_length*fs);
    wnd = hamming(wnd_length);
    inc = fix(wnd_length / 2); 
    [f,t] = cut_frame(x,wnd,inc);             % 对语音信号分帧；
    silentFrameNo=fix((IS*fs-wnd_length)/(0.5*wnd_length) +1);           %计算用于估计噪声谱的帧数；
    f=f';
    Y = fft(f);
    [m,n] = size(Y);
    YPhase = angle(Y((1:(fix(m/2)+1)),:));
    YY = abs(Y(1:(fix(m/2)+1),:));
    noise_est = mean(YY(:,1:silentFrameNo)'.^2)';
    X=zeros(size(YY));
    X = wienerfilter(YY,silentFrameNo,noise_est);      % 这是维纳滤波过程的核心函数；

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
    



    
  
    
    
    
    