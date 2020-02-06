        subroutine corre2(x,y,m,n,icorre,ierror)
c----------------------------------------------------------------------
c  Routinue CORRE2: To Compute the Correlation  Function of x(i) and
c  y(i) by DFT. x(i),y(i),i=0,...,m-1;But the dimension n of x,y must
c  be >=2*m and be the power of 2 ;
c  If: icorre=0:For auto-correlation
c      icorre=1:For crros-correlation
c                                       in chapter 11
c----------------------------------------------------------------------
        complex x(0:n-1),y(0:n-1)
        ierror=1
        s=n
1       s=s/2.
        if(s-2.)70,5,1
5       do 10 i=m,n-1
10          x(i)=0.
        call splfft(x,n,-1)
        if(icorre.eq.1)goto 30
        do 20 k=0,n-1
           x(k)=conjg(x(k))*x(k)/float(m)
20      continue
        goto 60
30      do 40 i=m,n-1
40         y(i)=0.
        call splfft(y,n,-1)
        do 50 k=0,n-1
           x(k)=conjg(x(k))*y(k)/float(m)
50      continue
60      call splfft(x,n,1)
        ierror=0
70      return
        end
