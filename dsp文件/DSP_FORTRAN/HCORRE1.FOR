C----------------------------------------------------------------------
C main program HCORRE1:To test subroutine CORRE1
C To compute the correlation of two complex sequences
c To link subroutine CORRE1
C----------------------------------------------------------------------
        complex x(0:7),r(0:7)
        data n/8/,lag/5/
        do 10 i=0,7
10      x(i)=float(i+1)
        call corre1(x,x,r,n,lag,Ierror)
        if(ierror.ne.0)stop
        write(*,*)'     Ierror=',Ierror
        do 20 i=0,lag-1
           write(*,*)i,r(i)
20      continue
        stop
        end
