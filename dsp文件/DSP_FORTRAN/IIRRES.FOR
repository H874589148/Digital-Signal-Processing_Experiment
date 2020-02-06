        subroutine iirres(a,b,lb,la,h,n)
c----------------------------------------------------------------------
c Routinue IIRRES:To obtain the frequency response H(exp(jw)) of system
c                 function H(Z)=B(Z)/A(Z) having form as :
c            b(0)+b(1)z^(-1)+ ... + b(lb)z^(-lb)
c       H(z)=------------------------------------
c            1.0 +a(1)z^(-1)+ ... + a(la)z^(-la)
c input parameters:
c a :la   dimensioned real array, A(1) to A(la) are the coef. of A(Z);
c b :lb+1 dimensioned real array, b(0) to b(lb) are the coef. of B(Z);
c n :data point number  in frequency axis ;
c output parameters:
c H :n dimensioned complex frequency response array .
c Note: If H(k)=0/0,then let H(K)=H(k+1) (This is for the case of that
c       H(exp(jw)) is a sinc function)
c     : If la=0: for FIR system.
c                                       in Chapter 2
c----------------------------------------------------------------------
        dimension a(1:la),b(0:lb)
        complex h(0:n-1),z,bsum,asum
        hmin=1.e-10
        hmax=1.e+10
        isign=0
        pi=4.*atan(1.)
        s=pi/float(n)
        do 70 k=0,n-1
           sf=s*k
           bsum=b(0)
           if(lb.le.0) goto 20
           do 10 i=1,lb
              if(b(i).eq.0.0) goto 10
              sb=sf*i
              z=cmplx(cos(sb),-sin(sb))
              bsum=bsum+b(i)*z
10         continue
20         asum=1.
           if(la.eq.0)goto 40
           do 30 i=1,la
              if(a(i).eq.0.0) goto 30
              sa=sf*i
              z=cmplx(cos(sa),-sin(sa))
              asum=asum+a(i)*z
30         continue
40         if(abs(asum).lt.hmin) goto 50
           h(k)=bsum/asum
           if(isign.eq.0) goto 70
           h(k-1)=h(k)
           isign=0
           goto 70
50         if(abs(bsum).lt.hmin) goto 60
           h(k)=hmax
           goto 70
60         isign=1
70      continue
        return
        end
