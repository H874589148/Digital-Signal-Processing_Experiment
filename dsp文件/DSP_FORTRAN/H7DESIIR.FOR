c----------------------------------------------------------------------
c main program H7DESIIR: to test subroutine desiir.for
c To design Butterworth band-stop IIR filter
c Please link subroutine DESIIR,ORDERB,BUTWCF,CHEBSH,AFTODF,IIRRES,
c                        UNWRAP
c----------------------------------------------------------------------
        data f1/95./,f2/99./,f3/101./,f4/105./,fs/1000./
        data alpha1/3.0/,alpha2/14./,iband/4/,itype/0/
        call desiir(f1,f2,f3,f4,fs,alpha1,alpha2,iband,itype)
        stop
        end
