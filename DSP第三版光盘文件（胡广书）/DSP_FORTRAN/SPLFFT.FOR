        subroutine splfft(x,n,isign)
c----------------------------------------------------------------------
c Routine SPLFFT:To perform the split-radix DIF fft algorithm.
c input parameters:
c x : complex array.Input signal is stored in x(0) to x(n-1).
c n : the dimension of x.
c isign:if ISIGN=-1 For Forward Transform
c       if ISIGN=+1 For Inverse Transform.
c output parameters:
c x : complex array. DFT result is stored in x(0) to x(n-1).
c Notes:n must be a power of 2
c  From Ref. [7] of chapter 5, Modified by Lao Changan .
c                                        in chapter 5
c----------------------------------------------------------------------
        complex  x(0:n-1),xt
        do 5 m=1,16
           n2=2**m
           if(n.eq.n2) go to 8
5       continue
        write(*,*)'  N is not a power of 2'
        return
8       n2=n*2
        es=-isign*atan(1.0)*8.0
        do 10 k=1,m-1
           n2=n2/2
           n4=n2/4
           e=es/n2
           a=0
           do 20 j=0,n4-1
              a3=3*a
              cc1=cos(a)
              ss1=sin(a)
              cc3=cos(a3)
              ss3=sin(a3)
              a=(j+1)*e
              is=j
              id=2*n2
40            do 30 i0=is,n-1,id
              i1=i0+n4
              i2=i1+n4
              i3=i2+n4
              r1=real(x(i0)-x(i2))
              s1=aimag(x(i0)-x(i2))
              r2=real(x(i1)-x(i3))
              s2=aimag(x(i1)-x(i3))
              x(i0)=x(i0)+x(i2)
              x(i1)=x(i1)+x(i3)
              if(isign.eq.1)goto 41
              s3=r1-s2
              r1=r1+s2
              s2=r2-s1
              r2=r2+s1
              goto 42
41            s3=r1+s2
              r1=r1-s2
              s2=-r2-s1
              r2=-r2+s1
42            x(i2)=cmplx(r1*cc1-s2*ss1,-s2*cc1-r1*ss1)
              x(i3)=cmplx(s3*cc3+r2*ss3,r2*cc3-s3*ss3)
30            continue
              is=2*id-n2+j
              id=4*id
              if(is.lt.n-1) goto 40
20         continue
10      continue
c       ------------ special last stage -------------------------
        is=0
        id=4
50      do 60 i0=is,n-1,id
           i1=i0+1
           xt=x(i0)
           x(i0)=xt+x(i1)
           x(i1)=xt-x(i1)
60      continue
           is=2*id-2
           id=4*id
           if(is.lt.n-1) goto 50
100     j=1
        n1=n-1
        do 104 i=1,n1
           if(i.ge.j) goto 101
           xt=x(j-1)
           x(j-1)=x(i-1)
           x(i-1)=xt
101        k=n/2
102        if(k.ge.j) goto 103
                j=j-k
                k=k/2
                goto 102
103        j=j+k
104     continue
        if(isign.eq.-1)return
        do 105 i=0,n-1
        x(i)=x(i)/n
105     continue
        return
        end
