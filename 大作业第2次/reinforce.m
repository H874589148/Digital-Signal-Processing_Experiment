clear all;
close all;
noi_num=4;%估算噪声取得帧数
[speech,fs,nbits]=wavread('bluesky1.wav');% 读入数据
alpha=0.02;             % 噪声水平
winsize=256;            % 窗长
size=length(speech);    % 语音长度
numofwin=floor(size/winsize);   % 帧数
hamwin=zeros(1,size);   % 定义汉明窗长度
enhanced=zeros(1,size); % 定义增强语音的长度
ham=hamming(winsize)';  % 产生汉明窗
x=speech'+alpha*randn(1,size);  % 信号加噪声
noisy=x(1:noi_num*winsize);   % 噪声估计
nmag=zeros(1,winsize);
for i=1:noi_num
    N=fft(noisy((i-1)*winsize+1:(i*winsize)));
    nmag=nmag+abs(N)'.^2;        % 噪声功率谱
end
nmag=nmag/noi_num;         
% 分帧
MSE=[];
i1=0;j1=0;
for a=0:0.2:5
    i1=i1+1;
    for b=0:0.01:0.1
        j1=j1+1;
        enhanced(1:size)=0;
        for q=1:2*numofwin-1
            frame=x(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2); % 对带噪语音帧间重叠一半取值
            hamwin(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)=...
                hamwin(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)+ham;% 加窗
            y=fft(frame.*ham);
            mag=abs(y).^2;     % 带噪语音功率谱
            phase=angle(y); % 带噪语音相位
            % 幅度谱减
            for i=1:winsize
                if mag(i)-a*nmag(i)>=0
                    clean(i)=mag(i)-a*nmag(i);
                else 
                    clean(i)=b*mag(i);
                end
            end
             % 频域中重新合成语音
            spectral=(clean.^0.5).*exp(1i*phase);
            % 反傅里叶变换并重叠相加
            enhanced(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)=...
                enhanced(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)+real(ifft(spectral));
           
        end
        
        mse=sum((enhanced-speech').^2);
        MSE(i1,j1)=mse;
        
    end
    j1=0;
end
a=0:0.2:5;
b=0:0.002:0.02;
mesh(b,a,MSE); xlabel('b'); ylabel('a'); zlabel('MSE');
% figure(1);
% subplot(3,1,1);plot(speech);xlabel('样点数');ylabel('幅度');title('原始语音波形');
% subplot(3,1,2);plot(x);xlabel('样点数');ylabel('幅度');title('语音加噪波形');
% subplot(3,1,3);plot(enhanced);xlabel('样点数');ylabel('幅度');title('增强语音波形');
