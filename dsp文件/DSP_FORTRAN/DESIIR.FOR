
        subroutine desiir(f1,f2,f3,f4,fs,alpha1,alpha2,iband,itype)
c----------------------------------------------------------------------
c Routine DESIIR:To design LP,HP,BP,BS digital Butterworth and Chebyshev
c filter. All array has been specified internally,so user only need to
c input f1,f2,f3,f4,fs(in hz), alpha1,alpha2(in db) and IBAND (to specify
c the type of to design). This program output Hk(z)=Bk(z)/Ak(z),k=1,2,...,
c ksection and the freq. response H(exp(jwk)),k=0,1,...,n-1
c Input parameters:
c   f1,f2,f3,f4: the edge frequency desired(in Hz):
c      For LP IIR Filter(iband=1): f1=(fp),f2=(fs),f3=0,f4=0
c      For HP IIR Filter(iband=2): f1=(fs),f2=(fp),f3=0,f4=0
c      For BP IIR Filter(iband=3): f1=(fsl),f2=(f1),f3=(f3),f4=(fsh)
c      For BS IIR Filter(iband=4): f1=(f1),f2=(fsl),f3=(fsh),f4=(f3)
c  The definition of freq. in ( ) is given in Fig. 7.1.5
c                       fs: sampling frequnecy in Hz.
c   alpha1: attenuate coef. of passing band, in dB form.
c   alpha2: attenuate coef. of stopping band, in dB form.
c    itype:  itype=0 Butterworth IIR filter.
c           itype=1 Chebyshev  I IIR filter.
c  Output parameters: None
c   Note: the screen output will demostrate your IIR system function
c         in cascade form.
c                                      in chapter 7
c----------------------------------------------------------------------
        dimension b(0:4),a(0:4),d(0:4),c(0:4)
        dimension amp(0:299),phase(0:299),freq(0:299)
        complex h(0:299)
        data n/300/,ln/2/
        do 10 i=0,n-1
           phase(i)=0.0
           amp(i)=1.
10      continue
        call orderb(f1,f2,f3,f4,fs,alpha1,alpha2,l,iband,itype,ierror)
        if(ierror.eq.0) goto 15
        write(*,*)' stop at routine ORDERB, ierror=',ierror
        return
15      if(itype.eq.0)goto 17
        a1=alpha1/10.0
        eps=sqrt(10.0**a1-1.0)
        phi2=log(1.0/eps+sqrt(1.0/eps**2+1))/l
17      fln=f1/fs
        flh=f2/fs
        if(l.gt.1) goto 25
        ksection=1
        goto 30
25      t1=l/2.
        lh=int(l/2)
        if(t1.ne.float(lh)) ksection=(l+1)/2
        if(t1.eq.float(lh)) ksection=l/2
30      if(iband.eq.3.or.iband.eq.4)ln=4
        do 200 k1=1,ksection
           if(itype.eq.0)call butwcf(l,k1,ln,d,c,ierror)
           if(itype.eq.1)call chebsh(l,k1,ln,d,c,phi2,ierror)
           if(ierror.eq.0)goto 35
           write(*,*)' stop at routine BUTWCF,  ierror=',ierror
           return
35         write(*,*)'--------------- for ksection=',k1,'------------'
           write(*,*)'    Analog low-pass filter hk(s)=dk(s)/ck(s)'
           do 60 k=0,ln
60            write(*,70)k,d(k),k,c(k)
70            format('     d(',i2,')=',f10.4,'        c(',i2,')=',f10.4)
           call aftodf(d,c,ln,iband,fln,flh,b,a,ierror)
           if(ierror.eq.0)goto 45
           write(*,*)' stop at routine AFTODF, ierror=',ierror
           return
45         a(0)=1.
           write(*,*)'    Digital low-pass filter hk(z)=dk(z)/ck(z)'
           do 80 k=0,ln
80            write(*,90)k,b(k),k,a(k)
90            format('     b(',i2,')=',f10.4,'        a(',i2,')=',f10.4)
c
           call iirres(a,b,ln,ln,h,n)
           do 100 i=0,n-1
              amp(i)=abs(h(i))*amp(i)
              hr=real(h(i))
              if(hr.eq.0.0)hr=.00001
              phase(i)=atan2(aimag(h(i)),hr)+phase(i)
100        continue
200     continue
c-----------------------------------------------------------------------
        s=.5*fs/float(n)
        open(3,file='ampres.dat',status='NEW')
        do 110 i=0,n-1
           freq(i)=s*i
           if(amp(i).le.0)amp(i)=.00001
           if(itype.eq.1)amp(i)=amp(I)/(eps*2.0**(l-1))
           amp(i)=20.*alog10(amp(i))
           write(3,*)freq(i),amp(I)
110      continue
        close(3)
c
        call unwrap(phase,n)
        open(3,file='phase.dat',status='NEW')
        do 120 I=0,n-1
           write(3,*)freq(i),phase(I)
120     continue
        close(3)
        return
        end
