        subroutine biline(work,d,c,ln,b,a,ierror)
c----------------------------------------------------------------------
c Routine BILINE: To convert analog H(S) to digital H(Z) via bilinear
c                 transformation. H(S)=D(S)/C(S), H(Z)=B(Z)/A(Z)
c LN specifies the length of the coefficient arrays and filter order L
c is computed internally.   WORK is an internal array (2D)
c   IF  IERROR=0:    no errors detected in transformation
c             =1:    all zero transfer function
c             =2:    invalid transfer function; y(k) coef=0
c       From Ref. [5] of Chapter 2 .       in chapter 7
c----------------------------------------------------------------------
        dimension work(0:4,0:4),d(0:4),c(0:4),b(0:4),a(0:4)
        do 10 i=ln,0,-1
           if(c(i).ne.0..or.d(i).ne.0.)go to 20
10      continue
        ierror=1
        return
20      l=i
        do 30 J=0,L
           work(0,j)=1.
30       continue
        tmp=1.
        do 40 i=1,l
           tmp=tmp*float(l-i+1)/float(i)
           work(i,0)=tmp
40       continue
        do 60 i=1,l
           do 50 j=1,l
              work(i,j)=work(i,j-1)-work(i-1,j)-work(i-1,j-1)
50         continue
60      continue
        do 80 i=l,0,-1
           b(i)=0.
           atmp=0.
           do 70 j=0,l
              b(i)=b(i)+work(i,j)*d(j)
              atmp=atmp+work(i,j)*c(j)
70          continue
           scale=atmp
           if(i.ne.0) a(i)=atmp
80      continue
        ierror=2
        if(scale.eq.0.) return
        b(0)=b(0)/scale
        do 90 i=1,l
           b(i)=b(i)/scale
           a(i)=a(i)/scale
90      continue
        do 100 i=l+1,ln
           b(i)=0.0
           a(i)=0.0
100     continue
        ierror=0
        return
        end
