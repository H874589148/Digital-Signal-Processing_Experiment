
c----------------------------------------------------------------------
C   main program HPRGFFT: to test subroutine prgfft
c   Please link subroutine PRGFFT
c----------------------------------------------------------------------
        complex x(0:1023),y(0:1023)
        data isign/-1/,n/256/,m/1024/,k1/64/,lf/256/
        data a1/1.0/,a2/1.0/,f1/0.2/,f2/0.3/,fs/1.0/
        pi2=8.0*atan(1.0)
        ts=1.0/fs
        do 10 i=0,n-1
           t=float(i)*ts
           x(i)=a1*sin(pi2*f1*t)+a2*sin(pi2*f2*t)
           y(i)=x(i)
10      continue
        do 15 i=n,m-1
            x(i)=0.0
            y(i)=0.0
15      continue
        call prgfft(x,m,n,lf,k1,-1)
        call splfft(y,m,isign)
        open(3,file='h1xprgfft.dat',status='new')
        do 20 i=k1,k1+lf-1
           write(3,*)float(i)/float(m)*fs,abs(x(i))
20      continue
        close(3)
        open(3,file='h1yprgfft.dat',status='NEW')
        do 30 i=0,m-1
           write(3,*)float(i)/float(m)*fs,abs(y(i))
30      continue
        close(3)
        stop
        end
