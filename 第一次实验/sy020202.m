n=0:50; m=0:100; k=0:100; 
ha=[ones(1,10) zeros(1,41)];                                                        
subplot(5,1,1);stem(n,ha);title('ϵͳha[n]');                                                        
xc=[ones(1,10) zeros(1,41)];                                                                            
subplot(5,1,2);stem(n,xc);title('�����ź�xc[n]');                                                     
y=conv(xc,ha);                                                                               
subplot(5,1,3);stem(m,y);title('����ź�y[n]');                                                                          
Y=y*(exp(-j*pi/12.5)).^(m'*k);                                                                
magY=abs(Y);subplot(5,1,4);stem(k,magY);title('y[n]�ķ�������')                                   
angY=angle(Y); subplot(5,1,5);stem(k,angY);title('y[n]����λ����');
