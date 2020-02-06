        subroutine random(u,n,iseed,itype,p,ierror)
c---------------------------------------------------------------------
c Routine RANDOM :  Random number(pseudo-white noise) generator.
c input Parameters:
c n    : the random data numbers requested; integer .
c iseed: the seed for generating pseudo-random data .it must be
c        initialized by main program(suggested value is ISEED=12357)
c        and the random number is cycled,the cycle length=1,048,576 .
c itype: random data distribution type, as below:
C       ITYPE=1: Uniform  distributed,from 0.0 to 1.0
c       ITYPE=2: Uniform  distributed,Mean=0.0, Variance(Power) p=1.0
c       ITYPE=3: Uniform  distributed,Mean=0.0, Variance(Power) p=p.
c       ITYPE=4: Gaussian distributed,Mean=0.0, Variance(Power) p=1.0
c       ITYPE=5: Gaussian distributed,Mean=0.0, Variance(Power) p=p.
c p    :variance(Power) of random, only used when itype=3 or itype=5.
c out parameters:
c u    :n dimensioned real array, data is stored in u(0) to u(n-1).
c                                 in Chapter 1
c---------------------------------------------------------------------
        dimension u(0:n-1)
        Ierror=0
        if(itype.ge.1.and.itype.le.5) goto 1
        Ierror=1
        return
1       do 10 k=0,n-1
           u(k)=randnu(iseed)
10      continue
        if(itype.eq.1)goto 1000
        if(itype.eq.4.or.itype.eq.5) goto 200
        call meavar(u,n,umean,uvari)
c-------- to obtain a zero mean and P-power random sequence u(k)------
        a=12.
        if(itype.eq.2) p=sqrt(a)
        if(itype.eq.3) p=sqrt(p*a)
        do 40 k=0,n-1
           u(k)=(u(k)-umean)*p
40      continue
        if(itype.eq.2.or.itype.eq.3) goto 1000
c
c-- to generate a Gaussian randow sequence u(k),k=0,1,2,...,ns-1 ----
200     ksection=12
        ns=n/ksection
        ks=0
        if(itype.eq.4) p=1
        p=sqrt(p)
        do 50 k=0,ns-1
           v=0.0
                do 60 j=0,ksection-1
60              v=v+p*(u(j+ks)-.5)
           u(k)=v
           ks=ks+ksection
50      continue
        n=ns
1000    call meavar(u,n,umean,uvari)
        write(*,*)'   The mean     of u(n)=',umean
        write(*,*)'   The variance of u(n)=',uvari
        return
        end
c
        function randnu(iseed)
        iseed=2045*iseed+1
        iseed=iseed-(iseed/1048576)*1048576
        randnu=float(iseed+1)/1048577.0
        return
        end
c
        subroutine meavar(u,n,umean,uvari)
        dimension u(0:n-1)
        umean=0.0
        do 100 k=0,n-1
           umean=umean+u(k)
100      continue
        umean=umean/n
        uvari=0.0
        do 110 i=0,n-1
           uvari=uvari+(u(i)-umean)**2
110      continue
        uvari=uvari/(n-1.)
        return
        end
