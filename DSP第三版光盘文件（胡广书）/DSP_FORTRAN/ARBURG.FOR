        subroutine arburg(x,a,ef,eb,n,ip,ep,ierror)
c----------------------------------------------------------------------
c   Routine ARBURG: To estimate the AR parameters by Burg algorithm.
c   Input Parameters:
c          N  : Number of data samples;
c          IP : Order of autoregressive model;
c          X  : Array of complex data samples, X(0) through X(N-1);
c   Output Parameters:
c         EP  : Real variable representing driving noise variance;
c          A  : Array of complex AR parameters A(0) to A(IP);
c    IERROR=0 : No error
c          =1 : Ep<=0 .
c                                      in chapter 12
c----------------------------------------------------------------------
        complex x(0:n-1),a(0:ip),ef(0:n-1),eb(0:n-1),sum
        ierror=1
        a(0)=1.
        r0=0.
        do 10 i=0,n-1
           r0=r0+x(i)*conjg(x(i))
           ef(i)=x(i)
           eb(i)=x(i)
10      continue
        den=0.0
        r0=r0/float(n)
        sum=0.0
        do 20 i=1,n-1
           den=den+ef(i)*conjg(ef(i))+eb(i-1)*conjg(eb(i-1))
           sum=sum+ef(i)*conjg(eb(i-1))
20      continue
        sum=-2.*sum
        a(1)=sum/den
        ep=r0*(1.-a(1)*conjg(a(1)))
        do 30 i=n-1,1,-1
           sum=ef(i)
           ef(i)=sum+a(1)*eb(i-1)
           eb(i)=eb(i-1)+conjg(a(1))*sum
30      continue
c--------------------------------------------------------------------
        do 80 m=2,ip
           sum=0.0
           do 40 i=m,n-1
              sum=sum+ef(i)*conjg(eb(i-1))
40         continue
           sum=-2.*sum
           den=(1.-a(m-1)*conjg(a(m-1)))*den-ef(m-1)*conjg(ef(m-1))
     *         -eb(n-1)*conjg(eb(n-1))
           a(m)=sum/den
           ep=ep*(1.-a(m)*conjg(a(m)))
           if(ep.le.0) return
           do 50 i=1,m-1
              x(i)=a(i)+a(m)*conjg(a(m-i))
50         continue
           do 60 i=1,m-1
              a(i)=x(i)
60         continue
           do 70 i=n-1,m,-1
              sum=ef(i)
              ef(i)=sum+a(m)*eb(i-1)
              eb(i)=eb(i-1)+conjg(a(m))*sum
70         continue
80      continue
        ierror=0
        return
        end
