        subroutine ampres(h,amp,n,fs,iamp)
c----------------------------------------------------------------------
c Routine AMPRES: To obtain amplitude response from H(exp(jw)).
c input parameters:
c  H   :  n dimension complex array. H(0) to H(n-1) are the discrete
c         value of frequency response H(exp(jw));
c  n   :  the dimension of array H and AMP.
c  fs  :  sampling frequency (Hz).
cIAMP=0:  amplitude res. AMP(k)=abs(H(k));
c    =1:  amplitude res. AMP(k)=20.*alog10(abs(H(k))).
c output parameters:
c AMP :n  dimension real array, the amplitude-frequency response is
c         stored in AMP(0) to AMP(n-1).
c Note:this program will generate a data file named "amplit.dat" .
c                                        in Chapter 2
C----------------------------------------------------------------------
        dimension amp(0:n-1)
        complex h(0:n-1)
        s=.5*fs/float(n)
        do 10 k=0,n-1
           amp(k)=abs(h(k))
           if(amp(k).le.0.)amp(k)=.000001
           if(iamp.eq.1)amp(k)=20.*alog10(amp(k))
10      continue
        open(3,file='amplit.dat',status='new')
        do 20 k=0,n-1
           write(3,*)s*k,amp(k)
20      continue
        close(3)
        return
        end
