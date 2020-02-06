        subroutine cmpfft(x,n,isign)
c----------------------------------------------------------------------
c Routine CMPFFT: Cooley-Tukey radix-2 DIT FFT Algorithm
c input parameters:
c       x : n dimension complex array,x(0) to x(n-1):input signal
c       n : the dimension of x ;
c ISIGN=-1: For Forward Transform;
c      =+1: For Inverse Transform.
c output parameters:
c       x :n dimension complex array, x(0) to x(n-1): DFT's result .
c Notes   :n must be a power of 2.
c                                       in Chapter 5
c----------------------------------------------------------------------
        complex x(0:n-1),t
        do 5 i=1,16
           nn=2**i
           if(n.eq.nn) go to 8
5       continue
        write(*,*)'  N is not a power of 2'
        return
8       pisign=4*isign*atan(1.)
        mr=0
        do 20 m=1,n-1
           l=n
10         l=l/2
           if(mr+l.ge.n) goto 10
           mr=mod(mr,l)+l
           if(mr.le.m) goto 20
           t=x(m)
           x(m)=x(mr)
           x(mr)=t
20      continue
c
        l=1
30      if(l.lt.n) goto 70
        if(isign.eq.-1) return
        do 60 j=0,n-1
           x(j)=x(j)/float(n)
60      continue
        return
70      do 50 m=0,l-1
           do 40 i=m,n-1,2*l
              t=x(i+l)*exp(cmplx(0.,m*pisign/float(l)))
              x(i+l)=x(i)-t
              x(i)=x(i)+t
40         continue
50      continue
        l=2*l
        goto 30
        return
        end
