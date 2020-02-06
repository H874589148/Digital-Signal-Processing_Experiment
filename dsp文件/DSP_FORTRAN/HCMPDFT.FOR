c-----------------------------------------------------------------------
c   main program HCMPDFT: to test subroutine CMPDFT
c   To compute the DFT/IDFT of a complex sequences by DFT's definition.
c   Please link subroutine CMPDFT
c-----------------------------------------------------------------------
        complex x(0:31),y(0:31)
        data isign/-1/,n/32/
        data a1/1.0/,a2/1.0/,f1/0.2/,f2/0.3/,fs/1.0/
        pi2=8.0*atan(1.0)
        ts=1.0/fs
        do 10 i=0,n-1
           t=float(i)*ts
           x(i)=a1*sin(pi2*f1*t)+a2*sin(pi2*f2*t)
10      continue
        call cmpdft(x,y,n,isign)
        open(3,file='h1cmpdft.dat',status='NEW')
        do 20 i=0,n-1
           write(3,*)float(i)/float(n)*fs,abs(y(i))
20      continue
        close(3)
        stop
        end
