      subroutine psplot(psdr,psdi,mfre,ts)
c-----------------------------------------------------------------------
c   Routine PSPLOT: To plot the normalized power spectum curve on the
c                      normalized frequency axis from -.5 to  +.5 .
c        mfre : Points in frequency axis and must be the power of 2.
c        ts    : Sampling interval in seconds (real).
c        psdr : Real array of power spectral density values.
c        psdi : Real work array.
c                                            in Chapter 11
c-----------------------------------------------------------------------
        dimension psdr(0:mfre-1),psdi(0:mfre-1)
        m2=mfre/2
        do 40 k=0,m2-1
           psdi(k)=psdr(k)
           psdr(k)=psdr(k+m2)
           psdr(k+m2)=psdi(k)
40      continue
        pmax=psdr(0)
        do 50 k=1,mfre-1
           if(psdr(k).gt.pmax) pmax=psdr(k)
50      continue
        do 60 k=0,mfre-1
           psdr(k)=psdr(k)/pmax
           if(psdr(k).le.0.0)psdr(k)=.000001
60      continue
        fs=1./ts
        fs=fs/float(mfre)
        open(3,file='psd.dat',status='new')
        do 100 k=0,mfre-1
           faxis=fs*(k-m2)
           write(3,*)faxis,10.*alog10(psdr(k))
100      continue
        close(3)
        return
        end
