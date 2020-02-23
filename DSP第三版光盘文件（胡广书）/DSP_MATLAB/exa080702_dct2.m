%-------------------------------------------------------------------------
% exa080702_dct2.m, for example 8.7.2 and 8.5.1
% to test dct2.m;
% ����ʱ�������ļ��� exa080702_dct2(k)������k��ֵ���ɣ�k��0��8
%-------------------------------------------------------------------------
function exa080902_dct2(k)

% ����ͼ������ girl.bmp;
X=imread('girl.bmp','bmp');

A=double(X);
B=zeros(size(A));
C=zeros(size(A));

% ����άDCT��ÿһС��Ϊ 8��8��
s=size(A);
for m=1:s(1)
   if rem(m,8)==0
  		for n=1:s(2)
          if rem(n,8)==0
         	   B((m-8+1):m,(n-8+1):n)=dct2(A((m-8+1):m,(n-8+1):n));
               B((m-k+1):m,(n-8+1):n)=0;
               B((m-8+1):m,(n-k+1):n)=0;
         end
      end
     end
  end
  
% ��DCT���ؽ��źţ�
 for m=1:128     
   	if rem(m,8)==0
				for n=1:128
                 if rem(n,8)==0
                 C((m-8+1):m,(n-8+1):n)=idct2(B((m-8+1):m,(n-8+1):n));
                end
      		end
      end
  end
  
 % �����άͼ��
  C=uint8(C);
  subplot(2,2,1);
  subimage(X);
  axis square;xlabel('original image')
  subplot(2,2,2);
  subimage(C);
  axis square;xlabel('reconstructed image');
  
                             
