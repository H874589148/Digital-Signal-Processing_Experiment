c----------------------------------------------------------------------
c  To test subroutine FITOUT
c  To obtain the out y(n) of filter H(Z)=B(Z)/A(Z) for input x(n).
c     If x(0)=1,x(n)=0 for n>0,then y(n)=h(n)
c  To link subroutine FITOUT
c----------------------------------------------------------------------
        dimension x(0:99),y(0:99),b(0:4),a(1:4)
        data la/4/,lb/4/,n/100/
        do 10 i=1,n-1
10         x(i)=0.0
        x(0)=1
        b(0)=.001836
        b(1)=.007344
        b(2)=.011016
        b(3)=.007374
        b(4)=.001836
        a(1)=-3.0544
        a(2)=3.8291
        a(3)=-2.2925
        a(4)=.55075
        call fitout(b,a,lb,la,x,n,y,ierror)
        write(*,*)'  ierror=',ierror
        if(ierror.ne.0) stop
        open(3,file='impuls.dat',status='NEW')
        do 20 i=0,n-1
        write(3,*)i,y(I)
20      continue
        close(3)
c----------------------------------------------------------------------
        do 30 i=0,n-1
30         x(i)=1
        call fitout(b,a,lb,la,x,n,y,ierror)
        write(*,*)'  ierror=',ierror
        if(ierror.ne.0) stop
        open(3,file='output.dat',status='NEW')
        do 40 i=0,n-1
        write(3,*)i,y(I)
40      continue
        close(3)
        stop
        end
