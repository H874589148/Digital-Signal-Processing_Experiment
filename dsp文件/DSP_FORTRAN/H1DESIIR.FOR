c----------------------------------------------------------------------
c main program H1DESIIR: to test subroutine desiir.for
c To design Butterworth low-pass IIR filter
c Please link subroutine DESIIR,ORDERB,BUTWCF,CHEBSH,AFTODF,IIRRES,
c                        UNWRAP
c----------------------------------------------------------------------
        data f1/100./,f2/300/,fs/1000./
        data alpha1/3.0/,alpha2/40./,iband/1/,itype/0/
        call desiir(f1,f2,f3,f4,fs,alpha1,alpha2,iband,itype)
        stop
        end
