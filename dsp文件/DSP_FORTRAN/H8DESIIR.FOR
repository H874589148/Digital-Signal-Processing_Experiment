c----------------------------------------------------------------------
c main program H8DESIIR: to test subroutine desiir.for
c To design Chebyshev band-stop IIR filter
c Please link subroutine DESIIR,ORDERB,BUTWCF,CHEBSH,AFTODF,IIRRES,
c                        UNWRAP
c----------------------------------------------------------------------
        data f1/95./,f2/99./,f3/101./,f4/105./,fs/1000./
        data alpha1/.5/,alpha2/14./,iband/4/,itype/1/
        call desiir(f1,f2,f3,f4,fs,alpha1,alpha2,iband,itype)
        stop
        end
