
      subroutine chebsh(l,k,ln,d,c,phi2,ierror)
c----------------------------------------------------------------------
c    routine CHEBSH: To design low-pass Chebyshev analog filter:
c                    H(s)=D(s)/C(s)
c       If IERROR=0: no errors detected
c                =1: invalid filter order l and k
c                                       in Chapter 7
c--------------------------------------------------------------------
        dimension d(0:4),c(0:4)
        pi=4.*atan(1.)
        ierror=1
        if(l.le.0.or.k.gt.int((l+1)/2)) return
        ierror=0
        do 10 i=1,ln
           d(i)=0.
           c(i)=0.
10      continue
        d(0)=1.0
        c(0)=1.0
        orderk=k-(l+1.)/2.
        if(orderk.eq.0) goto 20
        c(0)=(sin((2*k-1)*pi/(2*l))*(exp(phi2)-exp(-phi2))/2.0)**2 +
     $       (cos((2*k-1)*pi/(2*l))*(exp(phi2)+exp(-phi2))/2.0)**2
        c(1)=2.*sin((2*k-1)*pi/(2*l))*(exp(phi2)-exp(-phi2))/2.0
        c(2)=1.
        return
20      c(0)=(exp(phi2)-exp(-phi2))/2.0
        c(1)=1.0
        return
        end
