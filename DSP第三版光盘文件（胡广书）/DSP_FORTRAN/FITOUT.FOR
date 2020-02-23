      subroutine fitout(b,a,lb,la,x,n,y,ierror)
c-----------------------------------------------------------------------
c Routine FITOUT: To obtain the output of an IIR or a FIR filter;
c                 System function H(Z)=B(Z)/A(Z) has form as:
c                    b(0)+b(1)z^(-1)+ ... + b(lb)z^(-lb)
c              H(z)=------------------------------------
c                    1.0 +a(1)z^(-1)+ ... + a(la)z^(-la)
c input parameters:
c b :lb+1 dimensioned real array. b(0) to b(lb) is the coef. of B(z)
c a :la   dimensioned real array. a(1) to a(la) is the coef. of A(z)
c n :data point number of input and output signal.
c x :n dimensioned real array, x(0) to x(n-1):input signal ;
c output parameters:
c y :n dimensioned real array, y(0) to y(n-1):output signal;
c   if ierror=0: no errors detected,
c      ierror=1: output exceeds 1.E10.
c Note:
c If LA=0: For FIR system.
c If x(0)=1,x(n)=0 for n>0,the output is the impulse response h(n).
c                                          in Chapter 2
c-----------------------------------------------------------------------
        dimension x(0:n-1),b(0:lb),a(1:la),y(0:n-1)
        ierror=1
        do 50 k=0,n-1
           sum=0.0
           do 10 i=0,lb
              ki=k-i
              if(ki.lt.0) goto 20
              if(b(i).eq.0.0.or.x(ki).eq.0.0) goto 10
              sum=sum+b(i)*x(ki)
              if(sum.gt.1.e10)return
10         continue
20         if(la.eq.0) goto 40
           do 30 i=1,la
              ki=k-i
              if(ki.lt.0) goto 40
              if(a(i).eq.0.0) goto 30
              sum=sum-a(i)*y(ki)
              if(sum.gt.1.e10)return
30         continue
40         y(k)=sum
50      continue
        ierror=0
        return
        end
