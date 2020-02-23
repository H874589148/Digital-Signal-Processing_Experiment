C----------------------------------------------------------------------
C main program HCONVO1:To test subroutine CONVO1
c Please link subroutine CONVO1
C----------------------------------------------------------------------
        dimension h(0:7),x(0:7),y(0:7)
        data m/4/,n/4/
        l=n+m-1
C
        do 10 i=0,3
           h(i)=1.
           x(i)=i+1.
10      continue
        call convo1(x,h,y,n,m,l,Ierror)
        write(*,*)'   Ierror=',Ierror
        do 2 k=0,l-1
2          write(*,*)k,y(k)
        stop
        end
