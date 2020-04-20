clear all;
close all;
[speech,fs,nbits]=wavread('bluesky1.wav');% ��������
alpha=0.04;             % ����ˮƽ
winsize=256;            % ����
size=length(speech);    % ��������
numofwin=floor(size/winsize);   % ֡��
hamwin=zeros(1,size);   % ���庺��������
enhanced=zeros(1,size); % ������ǿ�����ĳ���
ham=hamming(winsize)';  % ����������
x=speech'+alpha*randn(1,size);  % �źż�����
noisy=alpha*randn(1,winsize);   % ��������
N=fft(noisy);
nmag=abs(N);            % ����������
% ��֡
for q=1:2*numofwin-1
    frame=x(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2); % �Դ�������֡���ص�һ��ȡֵ
    hamwin(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)=...
        hamwin(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)+ham;% �Ӵ�
    y=fft(frame.*ham);
    mag=abs(y);     % ��������������
    phase=angle(y); % ����������λ
    % �����׼�
    for i=1:winsize
        if mag(i)-nmag(i)>0
            clean(i)=mag(i)-nmag(i);
        else 
            clean(i)=0;
        end
    end
    % Ƶ�������ºϳ�����
    spectral=clean.*exp(1i*phase);
    % ������Ҷ�任���ص����
    enhanced(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)=...
        enhanced(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)+real(ifft(spectral));
end
figure(1);
subplot(3,1,1);plot(speech);xlabel('������');ylabel('����');title('ԭʼ��������');
subplot(3,1,2);plot(x);xlabel('������');ylabel('����');title('�������벨��');
subplot(3,1,3);plot(enhanced);xlabel('������');ylabel('����');title('��ǿ��������');
