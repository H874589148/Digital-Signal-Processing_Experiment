        subroutine aryuwa(x,a,r,n,ip,ep,ierror)
c----------------------------------------------------------------------
c  Routine ARYUWA: To estimate the AR model parameters by solving
c                     Yule-Walker equation with Levinson algorithm.
c  Input Parameters:
c     N     : Number of data samples;
c    IP     : Order of autoregressive model
c     X     : Array of complex data samples, X(0) to X(N-1)
c  Output Parameters:
c    EP     : Real variable representing driving noise variance;
c     A     : Array of complex AR parameters, A(0) to A(ip)
c  IERROR=0 : No error
c        =1 : Ep<=0 .
c                                      in chapter 12
c----------------------------------------------------------------------
        complex x(0:n-1),r(0:ip),a(0:ip),sum
        ierror=1
        call corre1(x,x,r,n,ip+1,ierror)
        if(ierror.ne.0) return
        a(0)=1.
        r0=real(r(0))
        a(1)=-r(1)/r0
        ep=r0*(1.-a(1)*conjg(a(1)))
c
        do 40 k=2,ip
           sum=0.
           do 10 i=1,k-1
              sum=sum+r(k-i)*a(i)
10         continue
           sum=sum+r(k)
           a(k)=-sum/ep
           ep=ep*(1.-a(k)*conjg(a(k)))
           if(ep.le.0.0) return
           do 20 i=1,k-1
              x(i)=a(i)+conjg(a(k-I))*a(k)
20         continue
           do 30 i=1,k-1
              a(i)=x(i)
30         continue
40      continue
        ierror=0
        return
        end
