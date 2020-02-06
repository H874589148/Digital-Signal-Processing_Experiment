        subroutine unwrap(phase,n)
c----------------------------------------------------------------------
c  Routine unwrap:To unwrap the phase function computed by
c                 fuction ATAN(HR,HI);
c input parameters:
c   PHASE:  n dimensioned real array. PHASE(0) to PHASE(n-1) are the
c           phase value to be unwraped. Note: the phase is in radian.
c    N   :  the dimension of array PHASE.
c output parameters:
c   PHASE:  n dimensioned real array, PHASE(0) to PHASE(n-1) are the
c           phase value have been unwraped;
c                                      in Chapter 2
c----------------------------------------------------------------------
        dimension phase(0:n-1)
        angle=4.*atan(1.)
        anglejump=0.
        do 20 k=1,n-1
           dx=phase(k)-(phase(k-1)-anglejump)
           if(abs(dx).le.angle) go to 10
           anglejump=anglejump-sign(2.*angle,dx)
10      phase(k)=phase(k)+anglejump
20      continue
        return
        end
