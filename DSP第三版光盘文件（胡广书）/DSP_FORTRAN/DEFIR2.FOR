      subroutine defir2(l,iband,fl,fh,b,trans,fs,ierror)
C-----------------------------------------------------------------------
C  Routine DEFIR2: To design FIR filter by frequency sampling method.
C  Fl:low cut-off frequency. Fh:high cut-off(For BP,BS). fl,fh,fs in Hz
c          |---        |   ---      |   ---           |--      --
c          |   |       |  |         |  |   |          |  |    |
c          |   |       |  |         |  |   |          |  |    |
c        --|------    -|--------   -|-----------    --|--------------
c          0   fl      0  fl       0   fl  fh       0    fl   fh
C
C   Digital filter coefficients are returned in b(l)
c                H(z)=b(0)+b(1)z^(-1)+ ... +b(L)z^(-L)
c  Input parameters:
c   L+1  : the length of FIR filter. L<200 and (L+1) must be the odd.
c   iband:  iband=1 low  pass FIR filter.
c           iband=2 high pass FIR filter.
c           iband=3 band pass FIR filter.
c           iband=4 band stop FIR filter.
c   trans:   0<= trans <1.0 , it is the transition point.
c  Output parameters:
c   b: (L+1) dimensioned real array.the result is in b(0) to b(L).
c
c                                      in Chapter 8
c-----------------------------------------------------------------------
        complex b(0:l),h(0:200)
        npass=0
        pi=4.*atan(1.)
        fln=fl/fs
        fhn=fh/fs
        do 5 i=0,l
           h(i)=0.
5       continue
        ierror=0
        l=l+1
        dly=float(l)/2.
        lim=l/2
        if(dly.eq.float(lim)) ierror=1
        if(l.ge.201) ierror=2
        if(iband.ne.4) goto 6
        band=(fhn-fln)*l
        if(band.ge.4.) goto 6
        write(*,*)'  Please increse the length L for Band-Stop FILTER'
        ierror=3
6       if(iband.lt.1.or.iband.gt.4) ierror=4
        if(fln.le.0..or.fln.gt.0.5) ierror=5
        if(iband.ge.3.and.fln.ge.fhn) ierror=6
        if(trans.lt.0.and.trans.ge.1.)ierror=7
        if(ierror.ne.0) return
        s=-(l-1)*pi/l
        go to(10,20,30,10) iband
10      nlow=1
        nhigh=fln*l-1
        h(0)=1.0
        do 15 i=nlow,nhigh
           h(i)=cexp(cmplx(0.0,s*i))
           h(l-i)=conjg(h(i))
15      continue
        h(nhigh+1)=trans*cexp(cmplx(0.0,s*(nhigh+1)))
        h(l-nhigh-1)=conjg(h(nhigh+1))
        if(iband.eq.1)goto 100
        nlow=fhn*l
        goto 21
c
20      h(0)=0.0
        nlow=fln*l
21      nhigh=lim
        do 25 i=nlow,nhigh
           h(i)=cexp(cmplx(0.0,s*i))
           h(l-i)=conjg(h(i))
25      continue
           h(nlow-1)=trans*cexp(cmplx(0.0,s*(nlow-1)))
           h(l-nlow+1)=conjg(h(nlow-1))
        goto 100
c
30      nlow=fln*l
        nhigh=fhn*l
        h(0)=0.0
        do 35 i=nlow,nhigh
           h(i)=cexp(cmplx(0.0,s*i))
           h(l-i)=conjg(h(i))
35      continue
        h(nhigh+1)=trans*cexp(cmplx(0.0,s*(nhigh+1)))
        h(l-nhigh-1)=conjg(h(nhigh+1))
        h(nlow-1)=trans*cexp(cmplx(0.0,s*(nlow-1)))
        h(l-nlow+1)=conjg(h(nlow-1))
c
100     call cmpdft(h,b,l,1)
        l=l-1
        return
        end
