
c----------------------------------------------------------------------
c main program H2DESIIR: to test subroutine desiir.for
c To design Chebyshev  low-pass IIR filter
c Please link subroutine DESIIR,ORDERB,BUTWCF,CHEBSH,AFTODF,IIRRES,
c                        UNWRAP
c----------------------------------------------------------------------
        data f1/100./,f2/300./,fs/1000./
        data alpha1/1.0/,alpha2/40./,iband/1/,itype/1/
        call desiir(f1,f2,f3,f4,fs,alpha1,alpha2,iband,itype)
        stop
        end
