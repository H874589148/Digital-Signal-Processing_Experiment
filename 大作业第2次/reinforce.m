clear all;
close all;
noi_num=4;%��������ȡ��֡��
[speech,fs,nbits]=wavread('bluesky1.wav');% ��������
alpha=0.02;             % ����ˮƽ
winsize=256;            % ����
size=length(speech);    % ��������
numofwin=floor(size/winsize);   % ֡��
hamwin=zeros(1,size);   % ���庺��������
enhanced=zeros(1,size); % ������ǿ�����ĳ���
ham=hamming(winsize)';  % ����������
x=speech'+alpha*randn(1,size);  % �źż�����
noisy=x(1:noi_num*winsize);   % ��������
nmag=zeros(1,winsize);
for i=1:noi_num
    N=fft(noisy((i-1)*winsize+1:(i*winsize)));
    nmag=nmag+abs(N)'.^2;        % ����������
end
nmag=nmag/noi_num;         
% ��֡
MSE=[];
i1=0;j1=0;
for a=0:0.2:5
    i1=i1+1;
    for b=0:0.01:0.1
        j1=j1+1;
        enhanced(1:size)=0;
        for q=1:2*numofwin-1
            frame=x(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2); % �Դ�������֡���ص�һ��ȡֵ
            hamwin(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)=...
                hamwin(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)+ham;% �Ӵ�
            y=fft(frame.*ham);
            mag=abs(y).^2;     % ��������������
            phase=angle(y); % ����������λ
            % �����׼�
            for i=1:winsize
                if mag(i)-a*nmag(i)>=0
                    clean(i)=mag(i)-a*nmag(i);
                else 
                    clean(i)=b*mag(i);
                end
            end
             % Ƶ�������ºϳ�����
            spectral=(clean.^0.5).*exp(1i*phase);
            % ������Ҷ�任���ص����
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
% subplot(3,1,1);plot(speech);xlabel('������');ylabel('����');title('ԭʼ��������');
% subplot(3,1,2);plot(x);xlabel('������');ylabel('����');title('�������벨��');
% subplot(3,1,3);plot(enhanced);xlabel('������');ylabel('����');title('��ǿ��������');
