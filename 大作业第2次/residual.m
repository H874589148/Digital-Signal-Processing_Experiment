clear all;
close all;
[speech,fs,nbits]=wavread('bluesky1.wav'); % 读入数据speech长度32000
winsize=256;                                             % 窗长 加窗分帧 帧长256
size=length(speech);                                  % 语音长度32000
numofwin=floor(size/winsize);                   % 帧数=语音长度32000/帧长256=125
hamwin=zeros(1,size);                               % 定义汉明窗长度
ham=hamming(winsize)';                          % 产生汉明窗
alpha=0.02;                                               % 噪声水平0.04
x=speech'+alpha*randn(1,size);                 % 信号加噪声
noisy1=x(1,1:256);noisy2=x(1,257:512);noisy3=x(1,513:768);noisy4=x(1,769:1024);
N=abs(fft(noisy1)).^2+abs(fft(noisy2)).^2+abs(fft(noisy3)).^2+abs(fft(noisy4)).^2;
clear noisy1 noisy2 noisy3 noisy4;
nmag=0.25*N;
%a=5;b=0.0001;a=2.2;b=0.002;
%a=0:0.5:5;b=0:0.01:0.1;
%[a,b]=meshgrid(A,B);
MSE=[];
i1=0;j1=0;
for a=0:0.2:5
    i1=i1+1;
    for b=0:0.002:0.02
        j1=j1+1;
        enhanced=zeros(1,size);       % 定义增强语音的长度
        % 分帧
        for q=1:2*numofwin-1
            frame=x(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2);     % 对带噪语音帧间重叠一半取值
            hamwin(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)=...
                hamwin(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)+ham;  % 加窗
            y=fft(frame.*ham);
            mag=abs(y).^2;                % 带噪语音功率谱
            phase=angle(y);                % 带噪语音相位
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
            clear clean;
            % 反傅里叶变换并重叠相加
            enhanced(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)=...
                enhanced(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)+real(ifft(spectral));
        end
        enhanced=enhanced';
        substract=(speech-enhanced).^2;
        clear enhanced;
        sigma=0;
        for i=1:size
            sigma=sigma+substract(i);
        end
        sigma=sigma/size;
        MSE(i1,j1)=sigma;
    end
    j1=0;
end
a=0:0.2:5;
b=0:0.002:0.02;
mesh(b,a,MSE); xlabel('b'); ylabel('a'); zlabel('sigma');

zmin=min(min(MSE));   %找出Z的最大值zmax
i1=0;j1=0;
for a=0:0.2:5
    i1=i1+1;
    for b=0:0.002:0.02
        j1=j1+1;
        if MSE(i1,j1)==zmin;
            amax=(i1-1)*0.2;
            bmax=(j1-1)*0.002;   %找出MSE的最大值对应的横纵坐标amax、bmax
        end
    end
    j1=0;
end
%view([0,0])  view([-90,0])
%figure(1);
%sound(x,fs);pause(5);
%sound(enhanced,fs);pause(5);
