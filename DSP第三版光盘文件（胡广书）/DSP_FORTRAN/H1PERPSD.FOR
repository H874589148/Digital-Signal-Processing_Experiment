c----------------------------------------------------------------------
c   Main program H1PERPSD : to test subroutine PERPSD
c   To compute the PSD of test.dat by Welch's average periodogrm .
c   Case 1: no overlad, only one section.
c   Please link subroutine PERPSD,RELFFT,PSPLOT
c----------------------------------------------------------------------
        complex x(0:127)
        dimension w(0:127)
        data n/128/,nsamp/128/,nshift/0/,ts/1./,iwindow/1/
        open(3,file='test.dat',status='old')
         do 2 i=0,n-1
           read(3,*)x(i)
2       continue
        close(3)
        call perpsd(x,n,nshift,w,nsamp,iwindow,ts)
        stop
        end
