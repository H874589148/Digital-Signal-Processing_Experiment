
C----------------------------------------------------------------------
C   main program HSPLFFT: to test subroutine splfft
c   Please link subroutine SPLFFT
C----------------------------------------------------------------------
        complex x(0:1023)
        data isign/-1/,n/1024/
        data a1/1.0/,a2/1.0/,f1/0.2/,f2/0.3/,fs/1.0/
        pi2=8.0*atan(1.0)
        ts=1.0/fs
        do 10 i=0,n-1
        t=float(i)*ts
        x(i)=a1*sin(pi2*f1*t)+a2*sin(pi2*f2*t)
10      continue
        call splfft(x,n,isign)
        open(3,file='h1splfft.dat',status='NEW')
        do 20 i=0,n-1
        write(3,*)float(i)/float(n)*fs,abs(x(i))
20      continue
        close(3)
        stop
        end
