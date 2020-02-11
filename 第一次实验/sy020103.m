n=0:50;
hb=zeros(1,50);
hb(2)=1; hb(2)=2.5; hb(3)=2.5; hb(4)=1;                                                           
subplot(5,1,1);stem(hb);title('系统hb[n]');                                                        
x=[1 zeros(1,50)];                                                                            
subplot(5,1,2);stem(n,x);title('输入信号x[n]');                                                     
y=conv(x,hb);                                                                               
subplot(5,1,3);stem(y);title('输出信号y[n]');
m=1:100;k=1:100;                                                                            
Y=y*(exp(-j*pi/12.5)).^(m'*k);                                                                  
magY=abs(Y);subplot(5,1,4);stem(magY);title('y[n]的幅度特性')                                   
angY=angle(Y); subplot(5,1,5);stem(angY);title('y[n]的相位特性'); 

