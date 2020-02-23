        subroutine cmpdft(x,y,n,isign)
c----------------------------------------------------------------------
c  Routinue CMPDFT: Directly compute the DFT/IDFT of Complex Data
c                   x(n) by DFT definition;
c  If ISIGN=-1: For Forward Transform;
c     ISIGN=1 : For Inverse Transform.
c                                      in chapter 3
c----------------------------------------------------------------------
        complex x(0:n-1),y(0:n-1),t
        pi2=8.*atan(1.)
        t=cmplx(0.,isign*pi2/n)
        do 20 m=0,n-1
           y(m)=x(0)
           do 10 k=1,n-1
              y(m)=y(m)+x(k)*cexp(t*k*m)
10         continue
           if(isign.eq.1)y(m)=y(m)/n
20      continue
        return
        end
