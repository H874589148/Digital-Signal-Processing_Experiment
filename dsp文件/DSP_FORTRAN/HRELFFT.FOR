
C----------------------------------------------------------------------
c  main program HRELFFT: To test subroutine RELFFT
c  Please link subroutine RELFFT
C----------------------------------------------------------------------
        dimension xr(0:1023),xi(0:1023)
        data isign/-1/,n/1024/
        data a1/1.0/,a2/1.0/,f1/0.2/,f2/0.3/,fs/1.0/
        pi2=8.0*atan(1.0)
        ts=1.0/fs
        do 10 i=0,n-1
           t=float(i)*ts
           xr(i)=a1*sin(pi2*f1*t)+a2*sin(pi2*f2*t)
        xi(i)=0.0
10      continue
        call relfft(xr,xi,n,isign)
        open(3,file='h1relfft.dat',status='NEW')
        do 20 i=0,n-1
           amp=xr(i)*xr(i)+xi(i)*xi(i)
           amp=sqrt(amp)
        write(3,*)float(i)/float(n)*fs,amp
20      continue
        close(3)
        stop
        end
