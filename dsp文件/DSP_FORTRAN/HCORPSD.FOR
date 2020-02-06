c----------------------------------------------------------------------
c   Main program HCORPSD : to test subroutine CORPSD
c   To compute the PSD  of test.dat by BT method,
c   Please link subroutine CORPSD,CORRE1,RELFFT,PSPLOT
c----------------------------------------------------------------------
        complex x(0:127),r(0:31)
        data n/128/,lag/32/,iwindow/1/,t/1./
        open(3,file='test.dat',status='old')
        do 10 i=0,n-1
           read(3,*)x(i)
10      continue
        close(3)
        call corpsd(x,r,n,lag,iwindow,t)
        stop
        end
