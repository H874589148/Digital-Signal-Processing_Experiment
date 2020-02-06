c----------------------------------------------------------------------
c  To test subroutine FIRRES
c  To link subroutine FIRRES,AMPRES,PHARES
c----------------------------------------------------------------------
        dimension b(0:2),amp(0:399),phase(0:399)
        complex h(0:399)
        data lb/2/,n/400/,iamp/0/,fs/1./
        b(0)=1.
        b(1)=-4.
        b(2)=4.
        call firres(b,lb,n,h)
        call ampres(h,amp,n,fs,iamp)
        call phares(h,phase,n,fs)
        stop
        end
