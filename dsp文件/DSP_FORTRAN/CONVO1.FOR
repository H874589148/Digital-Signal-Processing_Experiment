        subroutine convo1(x,h,y,n,m,L,Ierror)
c--------------------------------------------------------------------
c Routine CONVO1: To implement Linear Convolution y(n)=x(n)*h(n)
c input parameters:
c x(n):L dimensioned real array,signal data is stored in x(0) to x(n-1).
c h(n):L dimensioned real array,impulse response is stored in h(0) to h(m-1).
c n   : the data length of x.
c m   : the data length of h.
c L   : the data length of y, L must be >=n+m-1
c output parameters:
c y(n):L dimensioned real array, y(n)=x(n)*h(n),n=0,...L-1.
c                                      in Chapter 1
c--------------------------------------------------------------------
        dimension x(0:L-1),h(0:L-1),y(0:L-1)
        Ierror=0
        if(l.ge.(m+n-1))goto 1
        Ierror=1
        return
1       do 2 i=n,L-1
2          x(i)=0.0
        do 3 i=m,L-1
3          h(i)=0.0
c
        do 11 k=0,L-1
           sum=0.0
           do 12 i=0,k
              sum=sum+x(i)*h(k-i)
12          continue
           y(k)=sum
11       continue
        return
        end
