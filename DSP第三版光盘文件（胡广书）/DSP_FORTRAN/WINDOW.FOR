
      subroutine window(w,n,iwindow,ierror)
c----------------------------------------------------------------------
c  Routine WINDOW: To Obtain Window Function.
c  Input parameters:
c   n      : the length of window data.
c   iwindow: window type desired.
c   if     : iwindow=1: rectangular window ,  =2: triangular window ,
C                   =3: cosin window ,        =4: Hanning window ,
C                   =5: Hamming window ,      =6: Blackman window ,
c                   =7: Papoulis window .
c  Output parameters:
c   w     : N dimensioned real array.the result is in w(0) to w(n-1).
C   ierror:IF IERROR=0: no error,    =1: Iwindow out of range.
c                                      in chapter 8
C----------------------------------------------------------------------
        dimension w(0:n-1)
        ierror=1
        if(iwindow.lt.1.or.iwindow.gt.7) return
        ierror=0
        pi=4.*atan(1.)
        pn=2.*pi/float(n)
        goto (1,2,3,4,5,6,7), iwindow
1       do 11 i=0,n-1
11         w(i)=1.
           return
2       do 12 i=0,n-1
12         w(i)=1.-abs(1.-2.*i/float(n))
           return
3       do 13 i=0,n-1
13         w(i)=sin(pn*i/2.)
           return
4       do 14 i=0,n-1
14         w(i)=0.5*(1.0-cos(pn*i))
           return
5       do 15 i=0,n-1
15         w(i)=0.54-0.46*cos(pn*i)
           return
6       do 16 i=0,n-1
16         w(i)=0.42-0.5*cos(pn*i)+0.08*cos(2.*pn*i)
           return
7       do 17 i=0,n-1
           a=abs(sin(pn*i))/pi
           b=1.-2.*(abs(i-n/2.))/float(n)
           c=cos(pn*i)
17         w(i)=a-b*c
           return
           end
