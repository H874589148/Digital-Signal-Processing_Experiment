        subroutine firres(b,lb,n,h)
c----------------------------------------------------------------------
c Routine FIRRES : To Obtain Frequence Responce H(exp(jw)) of
c                   a FIR System H(Z)=B(Z)
c The explanation of parameters is same as subroutine IIRRES.FOR
c                                      in Chapter 2
c----------------------------------------------------------------------
        dimension b(0:lb)
        complex h(0:n-1),z,bsum
        pi=4.*atan(1.)
        s=pi/float(n)
        do 30 k=0,n-1
           sf=s*k
           bsum=0.
           if(lb.le.0) GO TO 20
           do 10 i=1,lb
              if(b(i).eq.0.0) goto 10
              sb=sf*i
              z=cmplx(cos(sb),-sin(sb))
              bsum=bsum+b(i)*z
10         continue
20         h(k)=bsum+b(0)
30      continue
      return
      end
