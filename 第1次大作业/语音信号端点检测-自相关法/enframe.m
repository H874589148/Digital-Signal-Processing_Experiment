function f=enframe(x,win,inc)

nx=length(x(:));            % ȡ���ݳ���
nwin=length(win);           % ȡ����
if (nwin == 1)              % �жϴ����Ƿ�Ϊ1����Ϊ1������ʾû���贰����
   len = win;               % �ǣ�֡��=win
else
   len = nwin;              % ��֡��=����
end
if (nargin < 3)             % ���ֻ��������������֡inc=֡��
   inc = len;
end
nf = fix((nx-len+inc)/inc); % ����֡��
f=zeros(nf,len);            % ��ʼ��
indf= inc*(0:(nf-1)).';     % ����ÿ֡��x�е�λ����λ��
inds = (1:len);             % ÿ֡���ݶ�Ӧ1:len
f(:) = x(indf(:,ones(1,len))+inds(ones(nf,1),:));   % �����ݷ�֡
if (nwin > 1)               % �������а�������������ÿ֡���Դ�����
    w = win(:)';            % ��winת��������
    f = f .* w(ones(nf,1),:);  % �˴�����
end

