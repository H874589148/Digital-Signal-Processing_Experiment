        subroutine cztfft(x1,n,m,maxnm,dltomg,omg0,fs,ierror)
c----------------------------------------------------------------------
c Routine CZTFFT:To perform a CHIRP-Z Transform.
c input parameters:
c   N     : numbers of input signal to be transformed by CZT,
c           x1(i),i=0,..,N-1;
c   M     : numbers of output signal transformed by CZT,
c           x1(i),i=0,..,M-1;
c   MAXNM : MAXNM=MAX(N,M);
c ! Note !: the dimension of x1 must be MAXNM,otherwise the result
c           will be error!
c   dltomg: increasing angle of frequncy domain, in Hz;
c   omg0  : start angle of CZT, in Hz;
c   fs    : sampling frequency in Hz.
c output parameters:
c   x1    : MAXNM dimensioned complex array. the CZT result is stored
c           in x1(0) to x1(M-1).
c   Note  : In this program the largest length to do CZT MAXCZT=1024,
c           if you want to increase the length to do CZT please change
c           MAXCZT and  the dimension of X,WORK1 and WORK2 .
c                                        in Chapter 5
c----------------------------------------------------------------------
        complex x1(0:maxnm-1)
        complex x(0:1023),work1(0:1023),work2(0:1023),a
        maxczt=1024
        ierror=1
        m1=max0(n,m)
        if(maxnm.lt.m1) return
C-------------------- To compute W**(-n**2/2) -----------------------
        nfft=n+m
        do 10 i=0,10
           ntest=2**i
           if(ntest.ge.nfft) goto 12
10      continue
12      nfft=ntest
        ierror=2
        if(nfft.gt.maxczt) return
        pi=4.*atan(1.)
        ph=-2.*pi*dltomg/fs
        do 20 i=0,maxnm-1
           alpha=-ph*i*i/2.
           work1(i)=cmplx(cos(alpha),sin(alpha))
           work2(i)=work1(i)
20      continue
        do 30 i=1,n-1
           work1(nfft-i)=work2(i)
30      continue
        if((n+m).eq.nfft) goto 50
        do 40 i=m,nfft-n
           work1(i)=0.
40      continue
50      call cmpfft(work1,nfft,-1)
C---------------------- To compute A**(-n)*W**(n**2/2) --------------
        ang=-omg0*pi*2./fs
        do 60 i=0,n-1
           x(i)=x1(i)
           a=cmplx(cos(ang*i),sin(ang*i))
           x(i)=a*conjg(work2(i))*x(i)
60      continue
        do 70 i=n,nfft-1
           x(i)=0.
70      continue
        call cmpfft(x,nfft,-1)
C------------------------- To compute g(n)*h(n) --------------------
        do 80 i=0,nfft-1
           x(i)=x(i)*work1(i)
80      continue
        call cmpfft(x,nfft,1)
C------------------------ To multiply by W**(k**2/2) ---------------
        do 90 i=0,m-1
           x1(i)=x(i)*conjg(work2(i))
90      continue
        ierror=0
        return
        end
