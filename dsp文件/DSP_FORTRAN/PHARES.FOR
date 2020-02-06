        subroutine phares(h,phase,n,fs)
c----------------------------------------------------------------------
c Routine PHARES: To Obtain Phase Response of H(exp(jw))
c input parameters:
c  H   :  n dimensioned complex array. H(0) to H(n-1) are the discrete
c         value of frequency response H(exp(jw));
c  N   :  the dimension of array H and PHASE.
c  fs  :  sampling frequency (Hz).
c output parameters:
c PHASE:  n dimensioned real array, the phase-frequency response is
c         stored in PHASE(0) to PHASE(N-1).
c Note:   this program will generate a data file named "phase.dat" .
c                                       in Chapter 2
C----------------------------------------------------------------------
        dimension phase(0:n-1)
        complex h(0:n-1)
        s=.5*fs/float(n)
        do 10 k=0,n-1
           x=real(h(k))
           y=aimag(h(k))
           if(x.ne.0.0) goto 5
             if(y.eq.0.0) goto 4
             if(k.eq.0)   goto 4
               x1=real(h(k-1))
               if(x1.eq.0.0) goto 4
               if(x1.gt.0.0) x=0.000001
               if(x1.lt.0.0) x=-0.000001
               goto 5
4            phase(k)=0.0
             goto 10
5          phase(k)=atan2(y,x)
10      continue
        call unwrap(phase,n)
        open(3,file='phases.dat',status='new')
        do 20 k=0,n-1
           write(3,*)s*k,phase(k)
20      continue
        close(3)
        return
        end
