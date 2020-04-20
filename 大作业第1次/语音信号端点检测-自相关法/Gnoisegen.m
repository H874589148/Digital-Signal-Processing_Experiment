function [y,noise] = Gnoisegen(x,snr)
% Gnoisegen�����ǵ��Ӹ�˹�������������ź�x��
% [y,noise] = Gnoisegen(x,snr)
% x�������źţ�snr�����õ�����ȣ���λΪdB
% y�ǵ��Ӹ�˹��������Ĵ���������noise�Ǳ����ӵ�����
noise=randn(size(x));              % ��randn����������˹������
Nx=length(x);                      % ����ź�x��
signal_power = 1/Nx*sum(x.*x);     % ����źŵ�ƽ������
noise_power=1/Nx*sum(noise.*noise);% �������������
noise_variance = signal_power / ( 10^(snr/10) );    % ����������趨�ķ���ֵ
noise=sqrt(noise_variance/noise_power)*noise;       % ��������ƽ������������Ӧ�İ�����
y=x+noise;                         % ���ɴ�������

