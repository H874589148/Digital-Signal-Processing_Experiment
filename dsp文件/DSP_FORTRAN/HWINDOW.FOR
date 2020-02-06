c----------------------------------------------------------------------
c main program HWINDOW: To test subroutine WINDOW
c Please link subroutine WINDOW
C----------------------------------------------------------------------
        dimension w(0:127)
        n=128
        write(*,*)'    Please input Iwindow='
        write(*,*)'    Note: Iwindow=1,2,...,7'
        read(*,*)Iwindow
        call window(w,n,iwindow,ierror)
        write(*,*)'   ierror=',ierror
        if(ierror.ne.0) stop
        open(3,file='window.dat',status='new')
        do 10 k=0,n-1
           write(3,*)k,w(k)
10      continue
        close(3)
        stop
        end
