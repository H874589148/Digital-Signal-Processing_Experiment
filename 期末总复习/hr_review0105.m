clear;
num=[2 -2.9];         %�趨�����ķ�������
den = [1 -2.9 1];   %�趨�����ķ�ĸ����
%disp(roots(num));    %������
%disp(roots(den));    %�������
[Z P K]=tf2zp(num,den);
fprintf('��㣺\n');
disp(Z);
fprintf('���㣺\n');
disp(P);
fprintf('���棺 %.2f\n',K);
zplane(num,den);   %����ϵͳ�������㼫��ͼ
