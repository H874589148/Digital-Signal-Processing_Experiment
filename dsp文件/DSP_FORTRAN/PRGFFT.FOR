             subroutine prgfft(x,N,L,LF,k1,isign)
c----------------------------------------------------------------------
c  Routinue PRGFFT:To perform an fft algorithm with pruning both in
c   input and output. In output side the transformed data points is
c   from k1 to k2,k2=k1+lf-1, lf is the lenghth.
c input parameters:
c       X : complex array,X(0) to X(N-1),but only X(0) to  X(L-1)
c           is nonzero, L<N
c       N : the dimension of X ;
c       LF: Length of output data ;
c       K1: start data point of output ;
c ISIGN=-1: For Forward Transform ;
c ISIGN=+1: For Inverse Transform ;
c output parameters:
c       X : complex array,X(K1) to X(K1+LF-1) is DFT's result.
c    Notes: N ,L and LF must be a power of 2 .
c   From Ref. [15] of chapter 5,Modified by Lao Changan .
c                                      in chapter 5
c----------------------------------------------------------------------
        dimension nx(0:15),ny(0:15)
        complex x(0:n-1),xt
        do 2 m=1,16
           n1=2**m
           if(n.eq.n1) go to 4
2       continue
        write(*,*)'  N is not a power of 2'
        return
4       do 5 l5=1,15
           n1=2**l5
           if(l.eq.n1) go to 6
5       continue
        write(*,*)'  L is not a power of 2'
        return
6       do 7 lf2=1,15
           n1=2**lf2
           if(lf.eq.n1) go to 8
7       continue
        write(*,*)'  LF is not a power of 2'
        return
8       k2=k1+LF-1
        ntemp=n
c---------- digital reverse loops ----------------------------------
100     j=1
        n1=ntemp-1
        do 104 i=1,n1
        if(i.ge.j) goto 101
        xt=x(j-1)
        x(j-1)=x(i-1)
        x(i-1)=xt
101     k=n/2
102     if(k.ge.j) goto 103
        j=j-k
        k=k/2
        goto 102
103     j=j+k
104     continue
c
        np=2**(m-L5)
        if(l.eq.m)goto 20
        nl=2**L5
        j1=nl*np
        do 10 i=1,j1,np
                do 10 j=1,np-1
                j2=i+j
                x(j2-1)=x(i-1)
10      continue
20      ntm1=k1-1
        ntm2=NTEMP
        ntm3=k2-1
        i1=max(LF2,m-L5)+1
        do 30 i=m,i1,-1
        ntm2=ntm2/2
        ntm1=mod(ntm1,ntm2)
        ntm3=mod(ntm3,ntm2)
        ny(i)=ntm3+1
        nx(i)=ntm1+1
30      continue
        nr=np
        do 60 i=m-L5+1,m
        nbtf=nr
        nr=2*nr
        arg=atan(1.)*8.0/nr
        nd=nbtf
        ns=1
        if(i.le.lf)goto 40
        ns=nx(i)
        nd=ny(i)
        if(nd.ge.ns)goto 40
        flg=1
        nd=nbtf
40      continue
                do 50 j=ns,nd
                wt=arg*(j-1)
                c=cos(wt)
                s=sin(wt)*(0-isign)
                do 50 k=j,NTEMP,nr
                   j2=k+nbtf
                   t1=c*real(x(j2-1))+s*aimag(x(j2-1))
                   t2=-s*real(x(j2-1))+c*aimag(x(j2-1))
                   x(j2-1)=x(k-1)-cmplx(t1,t2)
                   x(k-1)=x(k-1)+cmplx(t1,t2)
50      continue
        if(flg.eq.0) goto 60
        flg=0
        ns=1
        nd=ny(i)
        goto 40
60      continue
        return
        end
