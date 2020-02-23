        subroutine convo2(x,h,y,n1,n2,n)
c----------------------------------------------------------------------
c  Routine CONVO2: To Compute the Convolution of x(i) and h(i) by DFT.
c  x(i),i=0,...,n1-1; h(n),i=0,...,n2-1,But the dimension n of x,h,y
c       must be >=(n1+n2-1) and be the power of 2 ;
c input parameters:
c x( ):n dimensioned real array,signal data is stored in x(0) to x(n1-1).
c h( ):n dimensioned real array,impuls response is stored in h(0) to h(n2-1).
c output parameters:
c y( ):n dimensioned real array, y(i)=x(i)*h(i),i=0,...n-1.
c Notes:
c     n must be a power of 2.
c                                      in chapter 3
c----------------------------------------------------------------------
        complex x(0:n-1),y(0:n-1),h(0:n-1)
        do 10 i=1,16
           nn=2**i
           if(n.eq.nn) go to 20
10       continue
        write(*,*)'  N is not a power of 2'
        return
20      do 30 i=n1,n-1
30          x(i)=0.
        do 40 i=n2,n-1
40         h(i)=0.
        call splfft(x,n,-1)
        call splfft(h,n,-1)
        do 50 k=0,n-1
50         y(k)=x(k)*h(k)
        call splfft(y,n,1)
        return
        end
