
C----------------------------------------------------------------------
C   main program HCZTFFT: to test subroutine cztfft
c   Please link subroutine CZTFFT,CMPFFT
C----------------------------------------------------------------------
        complex x(0:255)
        data n/128/,m/256/,fs/100.0/,omg0/0.0/,dltomg/0.1/
        maxnm=max0(n,m)
        open(3,file='test.dat',status='OLD')
        do 1 k=0,n-1
1       read(3,*)x(k)
        close(3)
        call cztfft(x,n,m,maxnm,dltomg,omg0,fs,ierror)
        if(ierror.ne.0) stop
        open(3,file='h1cztfft.dat',status='new')
        do 3 k=0,m-1
3       write(3,*)float(k)*dltomg+omg0,20.*alog10(abs(x(k)))
        close(3)
        stop
        end
