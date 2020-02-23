        subroutine defir3(nfilt,nbands,edge,fx,wtx,h)
C----------------------------------------------------------------------
C DEFIR3: To design FIR filter by Weighted Chebyshev Approximation.
c  Input parameters:
c nfilt+1: the length of FIR filter,in this program nfilt<128;
c nbands :Number of bands,in this program nbands<=10;
c fx     :Desired function array for each band,from fx(1) to fx(nbands);
c wtx    :Weight function array in each band,from wtx(1) to wtx(nbands);
c edge   :Bandedge array,lower and upper freq. for each band,from
c          edge(1) to edge(2*nbands);
c  Output parameters:
c       h: (nfilt+1) dimensioned real array,the impulse response.
c                                       in chapter 8
C----------------------------------------------------------------------
        dimension h(0:nfilt),x(1:66),y(1:66)
        dimension iext(1:66),ad(1:66),alpha(1:66)
        dimension edge(1:20),fx(1:nbands),wtx(1:nbands)
        dimension des(1:1045),grid(1:1045),wt(1:1045)
        common pi2,ad,dev,x,y,grid,des,wt,alpha,iext,nfcns,ngrid
        common /oops/niter
        pi2=8.*atan(1.)
        pi=pi2/2.
        nfmax=128
        lgrid=16
        if(nbands.gt.10)return
        if(nfilt.le.nfmax.and.nfilt.ge.3)goto 115
        return
115     if(nbands.le.0) nband=1
        jb=2*nbands
        nfilt=nfilt+1
        nodd=nfilt/2
        nodd=nfilt-2*nodd
        nfcns=nfilt/2
        if(nodd.eq.1)nfcns=nfcns+1
        grid(1)=edge(1)
        delf=lgrid*nfcns
        delf=0.5/delf
        if(edge(1).lt.delf) grid(1)=delf
        j=1
        l=1
        lband=1
140     fup=edge(l+1)
145     temp=grid(j)
        des(j)=fx(lband)
        wt(j)=wtx(lband)
        j=j+1
        grid(j)=temp+delf
        if(grid(j).gt.fup)goto 150
        goto 145
150     grid(j-1)=fup
        des(j-1)=fx(lband)
        wt(j-1)=wtx(lband)
        lband=lband+1
        l=l+2
        if(lband.gt.nbands) goto 160
        grid(j)=edge(l)
        goto 140
160     ngrid=j-1
        if(nodd.ne.0)goto 165
        if(grid(ngrid).gt.(.5-delf))ngrid=ngrid-1
165     continue
c
        if(nodd.eq.1)goto 200
        do 175 j=1,ngrid
           change=cos(pi*grid(j))
           des(j)=des(j)/change
           wt(j)=wt(j)*change
175     continue
200     continue
        temp=float(ngrid-1)/float(nfcns)
        do 210 j=1,nfcns
           xt=j-1
           iext(j)=xt*temp+1.
210     continue
        iext(nfcns+1)=ngrid
        nm1=nfcns-1
        nz=nfcns+1
c----------------------------------------------------------------------
        call remez1
c----------------------------------------------------------------------
        if(nodd.eq.0)goto 310
        do 305 j=0,nm1-1
           nzmj=nfcns-j
           h(j)=.5*alpha(nzmj)
           h(nfilt-j-1)=h(j)
305     continue
        h(nm1)=alpha(1)
        goto 350
310     h(0)=.25*alpha(nfcns)
        h(nfilt-1)=h(0)
        do 315 j=1,nm1-1
           nzmj=nfcns-j
           nf2j=nz-j
           h(j)=.25*(alpha(nzmj)+alpha(nf2j))
           h(nfilt-j-1)=h(j)
315     continue
        h(nm1)=.5*alpha(1)+.25*alpha(2)
        h(nfcns)=h(nm1)
350     continue
        write(*,*)'                         Deviation   Deviation(db)'
        do 370 j=1,nbands
           a=dev/wtx(j)
           write(*,*)' Band',j,'     ',a,20.*alog10(a+fx(j))
370     continue
        nfilt=nfilt-1
           return
           end
