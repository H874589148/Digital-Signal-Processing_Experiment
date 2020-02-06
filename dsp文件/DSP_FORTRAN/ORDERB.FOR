
        subroutine orderb(f1,f2,f3,f4,fs,alpha1,alpha2,l,
     $                    iband,itype,ierror)
c----------------------------------------------------------------------
c  subroutine ORDERB: To find the order L of lowpass Butterworth AF
c  and Chebyshev AF for LP,HP,BP and BS DF by frequence transformation.
c   IF IBAND=1:  lowpass   f1,f2,alpha1,alph2<>0, others=0
c           =2:  highpass  f1,f2,alpha1,alph2<>0, others=0
c           =3:  bandpass  all not equal zero
c           =4:  bandstop  all not equal zero
c                                       in Chapter 7
c----------------------------------------------------------------------
        ierror=1
        if(iband.lt.1.or.iband.gt.4)return
        pi=4.*atan(1.)
c------------------  for low-pass -------------------------
        omga1=tan(pi*f1/fs)
        omga2=tan(pi*f2/fs)
        a1=alpha1/10.
        a1=10.**a1-1.
        b1=alpha2/10.
        b1=10.**b1-1.
        p=omga1/omga2
        if(iband.eq.3.or.iband.eq.4)goto 40
        if(iband.eq.1) goto 60
c------------------  for high pass ------------------------
        p=omga1/omga2
        f1=f2
        f2=0.0
        goto 60
c------------------  for band pass ------------------------
40      omga3=tan(pi*f3/fs)
        omga4=tan(pi*f4/fs)
        if(iband.eq.4) goto 50
        f1=f2
        f2=f3
        omgar=omga3-omga2
        omga0=omga3*omga2
        omga0=sqrt(omga0)
        ada1=omga1/omgar
        ada2=omga2/omgar
        ada3=omga3/omgar
        ada4=omga4/omgar
        ada0=omga0/omgar
        omga1=(ada3*ada3-ada0*ada0)/ada3
        omga2=(ada4*ada4-ada0*ada0)/ada4
        p1=omga1/omga2
        omga1=(ada2*ada2-ada0*ada0)/ada2
        omga2=(ada1*ada1-ada0*ada0)/ada1
        p2=omga1/omga2
        p=p1
        if(p1.lt.p2) p=p2
        goto 60
c-------------------  for band stop -----------------------
50      f1=f1
        f2=f4
        omgar=omga4-omga1
        omga0=omga4*omga1
        omga0=sqrt(omga0)
        ada1=omga1/omgar
        ada2=omga2/omgar
        ada3=omga3/omgar
        ada4=omga4/omgar
        ada0=omga0/omgar
        omga1=ada1/(ada1*ada1-ada0*ada0)
        omga2=ada2/(ada2*ada2-ada0*ada0)
        p1=omga1/omga2
        omga1=ada4/(ada4*ada4-ada0*ada0)
        omga2=ada3/(ada3*ada3-ada0*ada0)
        p2=omga1/omga2
        p=p1
        if(p1.lt.p2) p=p2
c
60      if(itype.eq.0)then
          ab=(alog10(a1)-alog10(b1))/alog10(p)
          l=ab/2.+.9
        else
          ab=log(sqrt(b1/a1)+sqrt(b1/a1-1))/log(1.0/p+sqrt(1.0/p**2-1))
          l=ab+.9
        endif
        ierror=0
        write(*,*)'  The order of low-pass AF,  L=',L
        return
        end
