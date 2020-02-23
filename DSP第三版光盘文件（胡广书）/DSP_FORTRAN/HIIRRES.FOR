c----------------------------------------------------------------------
c   main program HIIRRES: to  test subroutine IIRRES
c   Please link subroutine IIRRES,AMPRES,PHARES
c----------------------------------------------------------------------
        dimension a(1:3),b(0:1),amp(0:399),phase(0:399)
        complex h(0:399)
        data la/3/,lb/1/,n/400/,iamp/0/,fs/1./
        b(0)=.01
        b(1)=-.02
        a(1)=-1.75
        a(2)=1.66
        a(3)=-.72
        call iirres(a,b,lb,la,h,n)
        call ampres(h,amp,n,fs,iamp)
        call phares(h,phase,n,fs)
        stop
        end
