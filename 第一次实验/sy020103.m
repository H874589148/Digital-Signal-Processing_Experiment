n=0:50;
hb=zeros(1,50);
hb(2)=1; hb(2)=2.5; hb(3)=2.5; hb(4)=1;                                                           
subplot(5,1,1);stem(hb);title('ϵͳhb[n]');                                                        
x=[1 zeros(1,50)];                                                                            
subplot(5,1,2);stem(n,x);title('�����ź�x[n]');                                                     
y=conv(x,hb);                                                                               
subplot(5,1,3);stem(y);title('����ź�y[n]');
m=1:100;k=1:100;                                                                            
Y=y*(exp(-j*pi/12.5)).^(m'*k);                                                                  
magY=abs(Y);subplot(5,1,4);stem(magY);title('y[n]�ķ�������')                                   
angY=angle(Y); subplot(5,1,5);stem(angY);title('y[n]����λ����'); 

