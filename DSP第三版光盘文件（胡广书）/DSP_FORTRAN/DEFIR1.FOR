      subroutine defir1(l,iband,fl,fh,fs,iwindow,b,w,ierror)
c-----------------------------------------------------------------------
C  Subroutine DEFIR1: To Design FIR Filter By Windowed Fourier Series.
C  Fl:low cut-off frequency. Fh:high cut-off(For BP,BS). fl,fh,fs in Hz
C  Digital filter coefficients are returned in b(l)
c                H(z)=b(0)+b(1)z^(-1)+ ... +b(L)z^(-L)
c  Input parameters:
c   L+1  : the length of FIR filter. (L+1) must be odd .
c   iband:  iband=1 low  pass FIR filter.
c           iband=2 high pass FIR filter.
c           iband=3 band pass FIR filter.
c           iband=4 band stop FIR filter.
c   fln,fhn: the edge frequency desired, in normalized form, 0.<=fln,fhn<=.5
c          |---        |   ---       |   ---           |--      --
c          |   |       |  |          |  |   |          |  |    |
c          |   |       |  |          |  |   |          |  |    |
c        --|------    -|--------    -|-----------    --|--------------
c          0  fln      0  fln        0 fln  fhn        0  fln  fhn
c             fhn=*       fhn=*
c        iband=1 LP    iband=2 HP      iband=3 BP        iband=4 BS
c  iwindow: window type desired.
c           iwindow=1: rectangular window ,   =2: triangular window ,
C                  =3: cosin window ,         =4: Hanning window ,
C                  =5: Hamming window ,       =6: Blackman window ,
c                  =7: Papoulis window .
c        w: L dimensioned real work array.
c  Output parameters:
c   b: L+1 dimensioned real array.the result is in b(0) to b(L).
C   ierror: ierror=0:      no errors detected
C                 =1:      invalid length  (L<=0)
C                 =2:      invalid window type
C                 =3:      invalid filter type
C                 =4:      invalid cut-off frequency
c       From Ref. [5] in chapter 2 .
c                                      in Chapter 8
c-----------------------------------------------------------------------
        dimension b(0:l),w(0:l)
        pi=4.*atan(1.)
        fln=fl/fs
        fhn=fh/fs
        do 1 i=0,l
           b(i)=0.
1       continue
        ierror=0
        l=l+1
        dly=float(l)/2.
        lim=l/2
        if(dly.eq.float(lim)) ierror=1
        if(iwindow.lt.1.or.iwindow.gt.7) ierror=2
        if(iband.lt.1.or.iband.gt.4) ierror=3
        if(fln.le.0..or.fln.gt.0.5) ierror=4
        if(iband.ge.3.and.fln.ge.fhn) ierror=4
        if(iband.ge.3.and.fhn.ge.0.5) ierror=4
        if(ierror.ne.0) return
        dly=dly-.5
        lim=lim-1
        wc1=2.*pi*fln
        if(iband.ge.3) wc2=2.*pi*fhn
        call window(w,l,iwindow,ierron)
        l=l-1
        go TO (5,10,15,20) iband
c----------- lowpass FIR filter design --------------------------------
5       continue
        do 6 i=0,lim
           s=i-dly
           b(i)=((sin(wc1*s))/(pi*s))
           b(i)=b(i)*w(i)
           b(l-i)=b(i)
6       continue
        b((l)/2)=wc1/pi
        return
c--------- highpass FIR filter design ---------------------------------
10      continue
        do 11 i=0,lim
           s=i-dly
           b(i)=((sin(pi*s)-sin(wc1*s))/(pi*s))
           b(i)=b(i)*w(i)
           b(l-i)=b(i)
11      continue
        b((l)/2)=1.-wc1/pi
        return
c-------- bandpass FIR filter design ----------------------------------
15      continue
        do 16 i=0,lim
           s=i-dly
           b(i)=((sin(wc2*s)-sin(wc1*s))/(pi*s))
           b(i)=b(i)*w(i)
           b(l-i)=b(i)
16      continue
        b((l)/2)=(wc2-wc1)/pi
        return
c-------- bandstop FIR filter design ----------------------------------
20      continue
        do 21 i=0,lim
           s=i-dly
           b(i)=((sin(wc1*s)+sin(pi*s)-sin(wc2*s))/(pi*s))
           b(i)=b(i)*w(i)
           b(l-i)=b(i)
21      continue
        b((l)/2)=(wc1+pi-wc2)/pi
        return
        end
