C----------------------------------------------------------------------
C   main program HLATTIC: to test subroutine lattic
c   Please link subroutine LATTIC
C----------------------------------------------------------------------
        dimension work(0:3,1:2),b(0:3),a(0:3)
        real kp(1:3),c(0:3)
        data l/3/,itype/2/
        do 2 i=1,l
           kp(i)=0.0
2          c(i)=0.0
        c(0)=0.
c
        b(0)=1.
        b(1)=0.8
        b(2)=-1.
        b(3)=-0.8
        a(1)=-1.7
        a(2)=1.53
        a(3)=-0.648
        call lattic(work,b,a,l,kp,c,itype,ierror)
        write(*,*)'  ierror=',ierror
        if(ierror.ne.0) stop
        write(*,3)(kp(i),i=1,l)
        write(*,3)(c(i),i=0,l)
3       format(6f10.4)
        stop
        end
