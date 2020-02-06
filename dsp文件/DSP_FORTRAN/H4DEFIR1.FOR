C----------------------------------------------------------------------
c  main program H4DEFIR1: to test subroutine DEFIR1
C  To design FIR band-stop filter by Fourier series method.
c  Please link subroutine DEFIR1,FIRRES,AMPRES,PHARES,UNWRAP,WINDOW
C----------------------------------------------------------------------
        dimension b(0:20),w(0:20),amp(0:255),phase(0:255)
        complex h(0:255)
        data fl/0.2/,fh/0.3/,fs/1.0/
        data lb/20/,n/256/,IBAND/4/,IWindow/5/,iamp/0/
        call defir1(lb,iband,fl,fh,fs,iwindow,b,w,ierror)
        write(*,*)'   ierror=',ierror
        if(ierror.ne.0)stop
        write(*,3)(k,b(k),k=0,lb)
3       format('                b(',i2,')=',f12.7)
        call firres(b,lb,n,h)
        call ampres(h,amp,n,fs,iamp)
        call phares(h,phase,n,fs)
        stop
        end
