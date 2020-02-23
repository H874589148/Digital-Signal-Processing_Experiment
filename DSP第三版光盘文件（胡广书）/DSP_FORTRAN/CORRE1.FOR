      subroutine corre1(x,y,r,n,lag,ierror)
C-----------------------------------------------------------------------
C  Routine CORRE1:To estimate the biased cross-correlation function
C  of complex arrays x and y. If y=x,then it is auto-correlation.
c  input parameters:
c     x  :n dimensioned complex array.
c     y  :n dimensioned complex array.
c     n  :the dimension of x and y.
c     lag:the requested point numbers of correlation.
c  output parameters:
c     r  :lag dimensioned complex array, the correlation function is
c         stored in r(0) to r(lag-1).
c                                      in Chapter 1 and 11
C-----------------------------------------------------------------------
        complex x(0:n-1),y(0:n-1),r(0:lag-1)
        Ierror=1
        if(lag.gt.n) return
        Ierror=0
        do 30 k=0,lag-1
           m=n-1-k
           r(k)=0.0
           do 10 j=0,m
              r(k)=r(k)+y(j+k)*conjg(x(j))
10         continue
           r(k)=r(k)/float(n)
30     continue
       return
       end
