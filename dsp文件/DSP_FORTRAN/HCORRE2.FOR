
c----------------------------------------------------------------------
c   Main program HCORRE2 : to test subroutine CORRE2
c   To compute the auto-correlation function of a simple data by FFT
C   Please link subroutine CORRE2,SPLFFT
c----------------------------------------------------------------------
        complex x(0:15)
        data m/8/,n/16/,icorre/0/
        do 10 i=0,m-1
           x(i)=i+1.
10      continue
        call corre2(x,x,m,n,icorre,ierror)
        write(*,*)'   ierror=',ierror
        if(ierror.ne.0) stop
        write(*,*)(x(i),i=0,n-1)
        stop
        end
