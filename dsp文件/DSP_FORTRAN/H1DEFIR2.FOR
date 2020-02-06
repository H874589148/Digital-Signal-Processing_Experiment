C----------------------------------------------------------------------
c  main program H1DEFIR2: to test subroutine DEFIR2
C  To design FIR low-pass filter by frequency sampling method
c  Please link subroutine DEFIR2,FIRRES,AMPRES,PHARES,UNWRAP
C----------------------------------------------------------------------
        dimension b(0:30),amp(0:255),phase(0:255)
        complex h(0:255),bcmplx(0:30)
        data l/30/,n/256/,iband/1/,iamp/0/
        data fs/1.0/,fl/0.1/,trans/0.5/
        call defir2(l,iband,fl,fh,bcmplx,trans,fs,ierror)
        write(*,*)'     ierror=',ierror
        if(ierror.ne.0)stop
        do 10 i=0,l
           b(i)=real(bcmplx(i))
           write(*,*)i,b(i)
10      continue
        call firres(b,l,n,h)
        call ampres(h,amp,n,fs,iamp)
        call phares(h,phase,n,fs)
        stop
        end

