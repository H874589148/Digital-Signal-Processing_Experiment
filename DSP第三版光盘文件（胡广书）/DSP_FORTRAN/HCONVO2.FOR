C----------------------------------------------------------------------
C main program HCONVO2:To test subroutine CONVO2
c Please link subroutine CONVO2,SPLFFT
C----------------------------------------------------------------------
        complex h(0:7),x(0:7),y(0:7)
        data n1/4/,n2/2/,n/8/
        do 10 i=0,3
           h(i)=1.
           x(i)=i+1.
10      continue
        h(0)=1.
        h(1)=1.
        x(0)=1.
        x(1)=2.
        x(2)=3.
        x(3)=4.
        call convo2(x,h,y,n1,n2,n)
        do 20 k=0,n1+n2-2
20        write(*,*)k,real(y(k))
        stop
        end
