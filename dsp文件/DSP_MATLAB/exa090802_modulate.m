%--------------------------------------------------------------------------
% exa090802_modulate.m,  for example 9.8.2
% to test modulate.m;
%
% ע���˳����� MATLAB 5.3 �¿������У��� MATLAB 6.1�¿����޷����У�
%--------------------------------------------------------------------------
clear all;

% �õ��������ݣ�
t=0:.1:4*pi; 
x=sin(t);
fs=1;
fc=.25; 
subplot(321)
plot(x)
ylabel('  x(t)')

% �����ǲ�ͬ�ĵ��Ʒ�ʽ��
y=modulate(x,fc,fs,'am');
subplot(322)
plot(y)
ylabel('  for "am"')

y=modulate(x,fc,fs,'amdsb-tc');
subplot(323)
plot(y)
ylabel('  for "amdsb-tc"')

y=modulate(x,fc,fs,'amssb');
subplot(324)
plot(y)
ylabel('  for "amssb"')

y=modulate(x,fc,fs,'fm');
subplot(325)
plot(y)
ylabel('  for "fm"')

y=modulate(x,fc,fs,'pm');
subplot(326)
plot(y)
ylabel('  for "pm"')
