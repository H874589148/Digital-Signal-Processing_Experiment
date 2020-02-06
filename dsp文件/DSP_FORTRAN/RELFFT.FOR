        subroutine relfft(xr,xi,n,isign)
c----------------------------------------------------------------------
c  routinue RELFFT: To perform  the split-radix DIF fft algorithm.
c  input parameters:
c   xr,xi:real and image part of complex data for DFT/IDFT,n=0,...,N-1
c      n : the dimension of xr and xi ;
cISIGN=-1: For Forward Transform;
c     =+1: For Inverse Transform.
c  output parameters:
c   xr,xi:real and image part  of DFT/IDFT's result,n=0,...,N-1
c  Note  : N  must be a power of 2 .
c  From Ref. [7] of chapter 5, Modified by Lao Changan
c                                       in chapter 5
c----------------------------------------------------------------------
        dimension xr(0:n-1),xi(0:n-1)
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
              r1=xr(i0)-xr(i2)
              s1=xi(i0)-xi(i2)
              r2=xr(i1)-xr(i3)
              s2=xi(i1)-xi(i3)
              xr(i0)=xr(i0)+xr(i2)
              xi(i0)=xi(i0)+xi(i2)
              xr(i1)=xr(i1)+xr(i3)
              xi(i1)=xi(i1)+xi(i3)
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
42            xr(i2)=r1*cc1-s2*ss1
              xi(i2)=-s2*cc1-r1*ss1
              xr(i3)=s3*cc3+r2*ss3
              xi(i3)=r2*cc3-s3*ss3
30            continue
              is=2*id-n2+j
              id=4*id
              if(is.lt.n-1) goto 40
20         continue
10      continue
c
c       ------------ special last stage -------------------------
        is=0
        id=4
50      do 60 i0=is,n-1,id
           i1=i0+1
           xtr=xr(i0)
           xti=xi(i0)
           xr(i0)=xtr+xr(i1)
           xi(i0)=xti+xi(i1)
           xr(i1)=xtr-xr(i1)
           xi(i1)=xti-xi(i1)
60      continue
           is=2*id-2
           id=4*id
           if(is.lt.n-1) goto 50

100     j=1
        n1=n-1
        do 104 i=1,n1
           if(i.ge.j) goto 101
           xtr=xr(j-1)
           xti=xi(j-1)
           xr(j-1)=xr(i-1)
           xi(j-1)=xi(i-1)
           xr(i-1)=xtr
           xi(i-1)=xti
101        k=n/2
102        if(k.ge.j) goto 103
                j=j-k
                k=k/2
                goto 102
103        j=j+k
104     continue
        if(isign.eq.-1)return
        do 105 i=0,n-1
        xr(i)=xr(i)/n
        xi(i)=xi(i)/n
105     continue
        return
        end
