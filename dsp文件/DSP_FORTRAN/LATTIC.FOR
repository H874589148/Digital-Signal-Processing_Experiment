      subroutine lattic(work,b,a,l,k,c,itype,ierror)
c-----------------------------------------------------------------------
c Routine LATTIC: To convert transfer function coefficients from direct
c                 form to lattice form. H(z)=B(z)/A(z),
c input parameters:
c     L : the order of filter;
c   b(n): cofficient of B(z),n=0,1,...,L
c   a(n): cofficient of A(z),n=1,...,L(a(0)=1.)
c Itype : If itype=0  : for FIR system;
c         If itype=1  : for all-pole IIR system;
c         If itype=2  : for pole-zero IIR system;
c Note  : When a FIR system will be converted to Lattice form ,first let
c         A(z)=B(z), then let H(z)=1/A(z) and call this program;
c         If the order of B(z) is smaller than it of A(z),the surplus of
c         B(z) must be given to zero;  For  example: the  order of B(z)
c         is 2,the order of A(z) is 3,then b(3)=0;
c  Output parameters:.
c   k(n): lattice cofficient ,n=1,...,L,
c   c(n): lattice cofficient ,n=0,1,...,L,
C   ierror:    If ierror=0 : conversion with no errors detected;
C              if ierror=1 : unstable H(z).
c  From Ref. [5] of chapter 2,Modified by Hu Guangshu .
c                                      in Chapter 6
c-----------------------------------------------------------------------
        dimension work(0:l,1:2),b(0:l),a(0:l),c(0:l)
        real k(1:l)
        ierror=1
        work(0,1)=1.
        do 10 m=1,l
           work(m,1)=a(m)
10      continue
        do 50 m=l,1,-1
           DO 20 j=0,m
              work(j,2)=work(m-j,1)
20         continue
           k(m)=-work(m,1)
           if(abs(k(m)).ge.1.0.and.itype.ne.0) return
           do 30 j=0,m
              work(j,1)=(work(j,1)+k(m)*work(j,2))/
     *                    (1.-k(m)**2)
30         continue
           if(itype.ne.2) goto 50
           c(m)=b(m)
           do 40 j=0,m
              b(j)=b(j)-c(m)*work(j,2)
40         continue
50      continue
        c(0)=b(0)
        ierror=0
        return
        end
