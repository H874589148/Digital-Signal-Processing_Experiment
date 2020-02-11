n=0:50; m=0:100; k=0:100; 
ha=[ones(1,10) zeros(1,41)];                                                        
subplot(5,1,1);stem(n,ha);title('系统ha[n]');                                                        
xc=[ones(1,10) zeros(1,41)];                                                                            
subplot(5,1,2);stem(n,xc);title('输入信号xc[n]');                                                     
y=conv(xc,ha);                                                                               
subplot(5,1,3);stem(m,y);title('输出信号y[n]');                                                                          
Y=y*(exp(-j*pi/12.5)).^(m'*k);                                                                
magY=abs(Y);subplot(5,1,4);stem(k,magY);title('y[n]的幅度特性')                                   
angY=angle(Y); subplot(5,1,5);stem(k,angY);title('y[n]的相位特性');
