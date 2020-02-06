        subroutine aftodf(d,c,ln,iband,fln,fhn,b,a,ierror)
c----------------------------------------------------------------------
c Routine AFTODF: To convert normalized LP analog H(s) to digital H(z).
c   H(s)=D(s)/C(s),H(z)=B(z)/A(z).Filter order l is computed internally.
c   LN specifies coefficient array size. WORK(0:LN,0:LN) is a work array.
c   IF   IBAND=1:    lowpass   fln=normalized cutoff frequency
c             =2:    highpass  fln=normalized cutoff frequency
c             =3:    bandpass  fln=low  cutoff frequency
c                              fhn=high cutoff frequency
c             =4:    bandstop  fln=low  cutoff frequency
c                              fhn=high cutoff frequency
c   IF  IERROR=0:    no errors detected
c              1:    all zero transfer function
c              2:    biline: invalid transfer function
c              3:    filter order exceeds array size
c              4:    invalid filter type parameter (IBAND)
c              5:    invalid cutoff frequency
c       From Ref. [5] of Chapter 2 .      in chapter 7
c-----------------------------------------------------------------------
        dimension work(0:4,0:4),d(0:4),c(0:4),b(0:4),a(0:4)
        pi=4.*atan(1.)
        ierror=0
        if(iband.lt.1.or.iband.gt.4) ierror=4
        if(fln.le.0..or.fln.gt.0.5) ierror=5
        if(iband.ge.3.and.fln.ge.fhn) ierror=5
        if(iband.ge.3.and.fhn.gt.0.5) ierror=5
        if(ierror.ne.0) return
        do 1 i=ln,0,-1
           if(c(i).ne.0..or.d(i).ne.0.) go to 2
1       continue
        ierror=1
        return
2       m=i
        w1=tan(pi*fln)
        l=m
        if(iband.le.2) go to 3
        l=2*m
        w2=tan(pi*fhn)
        w=w2-w1
        w02=w1*w2
3       continue
        ierror=3
        if(l.gt.ln) return
        go to (30,20,40,20) iband
c-------- substitution of 1/s to generate highpass (hp,bs) ------------
20      continue
        do 25 mm=0,m/2
           tmp=d(mm)
           d(mm)=d(m-mm)
           d(m-mm)=tmp
           tmp=c(mm)
           c(mm)=c(m-mm)
           c(m-mm)=tmp
25      continue
        if(iband.eq.4) go to 40
c-------- scaling s/w1 for lowpass,highpass ---------------------------
30      continue
        do 35 mm=0,m
           d(mm)=d(mm)/(w1**mm)
           c(mm)=c(mm)/(w1**mm)
35      continue
        go to 100
c-------- substitution of (s**2+w0**2)/(w*s)  bandpass,bandstop -------
40      continue
        do 45 ll=1,l+1
           work(ll,1)=0.
           work(ll,2)=0.
45      continue
        do 52 mm=0,m
           tmpd=d(mm)*(w**(m-mm))
           tmpc=c(mm)*(w**(m-mm))
           do 50 k=0,mm
              ls=m+mm-2*k
              tmp=spbfct(mm,mm)/(spbfct(k,k)*spbfct(mm-k,mm-k))
              work(ls+1,1)=work(ls+1,1)+tmpd*(w02**k)*tmp
              work(ls+1,2)=work(ls+1,2)+tmpc*(w02**k)*tmp
50         continue
52      continue
        do 55 ll=0,l
           d(ll)=work(ll+1,1)
           c(ll)=work(ll+1,2)
55      continue
c---------- substitute (z-1)/(z+1) ------------------------------------
100     continue
        call biline(work,d,c,ln,b,a,ierror)
        if(ierror.eq.0) return
        write(*,*)'   stop at routine biline,ierror=',ierror
        return
        end
c
        function spbfct(i1,i2)
c-------- generates (i1)!/(i1-i2)!=i1*(i1-1)*...*(i1-i2+1). -----------
c-------- note: 0!=1 and spbfct(i,i)=spbfct(i,i-1)=i!.      -----------
        spbfct=0.
        if(i1.lt.0.or.i2.lt.0.or.i2.gt.i1) return
        spbfct=1.
        if(i2.eq.0) return
        do 31 i=i1,i1-i2+1,-1
           spbfct=spbfct*i
31      continue
        return
        end
