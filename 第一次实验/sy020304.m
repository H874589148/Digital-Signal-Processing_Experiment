m=0:100; k=0:100; 
n=0:50; A=1; T=1;
a=0.1; w0=2.0734;
ha=[ones(1,10) zeros(1,41)];                                                        
subplot(5,1,1);stem(n,ha);title('ϵͳha[n]');                                                        
x=A*exp(-a*n*T).*sin(w0*n*T);                                                                           
subplot(5,1,2);stem(n,x);title('�����ź�x[n]');                                                     
y=conv(x,ha);                                                                               
subplot(5,1,3);stem(m,y);title('����ź�y[n]');                                                                          
Y=y*(exp(-j*pi/12.5)).^(m'*k);                                                                
magY=abs(Y);subplot(5,1,4);stem(k,magY);title('y[n]�ķ�������')                                   
angY=angle(Y); subplot(5,1,5);stem(k,angY);title('y[n]����λ����');