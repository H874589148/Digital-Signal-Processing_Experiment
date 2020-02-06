        subroutine remez1
c--------------------------------------------------------------------
c  from Ref. [31] of chapter 5
c                                      in chapter 8
c--------------------------------------------------------------------
        dimension iext(66),ad(66),alpha(66),x(66),y(66)
        dimension des(1045),grid(1045),wt(1045)
        dimension a(66),p(66),q(66)
        common pi2,ad,dev,x,y,grid,des,wt,alpha,iext,nfcns,ngrid
        common /oops/niter
        itrmax=25
        devl=-1.
        nz=nfcns+1
        nzz=nfcns+2
        niter=0
100     continue
        iext(nzz)=ngrid+1
        niter=niter+1
        if(niter.gt.itrmax) goto 400
        do 110 j=1,nz
           jxt=iext(j)
           dtemp=grid(jxt)
           dtemp=cos(dtemp*pi2)
           x(j)=dtemp
110     continue
        jet=(nfcns-1)/15+1
        do 120 j=1,nz
           ad(j)=d(j,nz,jet)
120     continue
        dnum=0.0
        dden=0.0
        k=1
        do 130 j=1,nz
           l=iext(j)
           dtemp=ad(j)*des(l)
           dnum=dnum+dtemp
           dtemp=k*ad(j)/wt(l)
           dden=dden+dtemp
           k=-k
130     continue
        dev=dnum/dden
        nu=1
        if(dev.gt.0.)nu=-1
        dev=-nu*dev
        k=nu
        do 140 j=1,nz
           l=iext(j)
           dtemp=k*dev/wt(l)
           y(j)=des(l)+dtemp
           k=-k
140     continue
        if(dev.gt.devl)goto 150
        call ouch
        goto 400
150     devl=dev
        jchneg=0
        k1=iext(1)
        knz=iext(nz)
        klow=0
        nut=-nu
        j=1
200     if(j.eq.nzz)ynz=comp
        if(j.ge.nzz) goto 300
        kup=iext(j+1)
        l=iext(j)+1
        nut=-nut
        if(j.eq.2)y1=comp
        comp=dev
        if(l.ge.kup) goto 220
        err=gee(l,nz)
        err=(err-des(l))*wt(l)
        dtemp=nut*err-comp
        if(dtemp.le.0.)goto 220
        comp=nut*err
210     l=l+1
        if(l.ge.kup) goto 215
        err=gee(l,nz)
        err=(err-des(l))*wt(l)
        dtemp=nut*err-comp
        if(dtemp.le.0.)goto 215
        comp=nut*err
        goto 210
215     iext(j)=l-1
        j=j+1
        klow=l-1
        jchnge=jchnge+1
        goto 200
220     l=l-1
225     l=l-1
        if(l.le.klow) goto 250
        err=gee(l,nz)
        err=(err-des(l))*wt(l)
        dtemp=nut*err-comp
        if(dtemp.gt.0.)goto 230
        if(jchnge.le.0.)goto 225
        goto 260
230     comp=nut*err
235     l=l-1
        if(l.le.klow) goto 240
        err=gee(l,nz)
        err=(err-des(l))*wt(l)
        dtemp=nut*err-comp
        if(dtemp.le.0.)goto 240
        comp=nut*err
        goto 235
240     klow=iext(j)
        iext(j)=l+1
        j=j+1
        jchnge=jchnge+1
        goto 200
250     l=iext(j)+1
        if(jchnge.gt.0.)goto 215
255     l=l+1
        if(l.ge.kup) goto 260
        err=gee(l,nz)
        err=(err-des(l))*wt(l)
        dtemp=nut*err-comp
        if(dtemp.le.0.)goto 255
        comp=nut*err
        goto 210
260     klow=iext(j)
        j=j+1
        goto 200
300     if(j.gt.nzz)goto 320
        if(k1.gt.iext(1)) k1=iext(1)
        if(knz.lt.iext(nz)) knz=iext(nz)
        nut1=nut
        nut=-nu
        l=0
        kup=k1
        comp=ynz*1.00001
        luck=1
310     l=l+1
        if(l.ge.kup) goto 315
        err=gee(l,nz)
        err=(err-des(l))*wt(l)
        dtemp=nut*err-comp
        if(dtemp.le.0.)goto 310
        comp=nut*err
        j=nzz
        goto 210
315     luck=6
        goto 325
320     if(luck.gt.9) goto 350
        if(comp.gt.y1) y1=comp
        k1=iext(nzz)
325     l=ngrid+1
        klow=knz
        nut=-nut1
        comp=y1*1.00001
330     l=l-1
        if(l.le.klow) goto 340
        err=gee(l,nz)
        err=(err-des(l))*wt(l)
        dtemp=nut*err-comp
        if(dtemp.le.0.)goto 330
        j=nzz
        comp=nut*err
        luck=luck+10
        goto 235
340     if(luck.eq.6)goto 370
        do 345 j=1,nfcns
           nzzmj=nzz-j
           nzmj=nz-j
           iext(nzzmj)=iext(nzmj)
345     continue
        iext(1)=k1
        goto 100
350     kn=iext(nzz)
        do 360 j=1,nfcns
           iext(j)=iext(j+1)
360     continue
        iext(nz)=kn
        goto 100
370     if(jchnge.gt.0) goto 100
400     continue
        nm1=nfcns-1
        fsh=1.e-06
        gtemp=grid(1)
        x(nzz)=-2.
        cn=2*nfcns-1
        delf=1./cn
        l=1
        kkk=0
        if(grid(1).le..01.and.grid(ngrid).gt.0.49) kkk=1
        if(nfcns.le.3)kkk=1
        if(kkk.eq.1)goto 405
        dtemp=cos(pi2*grid(1))
        dnum=cos(pi2*grid(ngrid))
        aa=2./(dtemp-dnum)
        bb=-(dtemp+dnum)/(dtemp-dnum)
405     continue
        do 430 j=1,nfcns
           ft=j-1
           ft=ft*delf
           xt=cos(pi2*ft)
           if(kkk.eq.1)goto 410
           xt=(xt-bb)/aa
           xt1=sqrt(1.-xt*xt)
           ft=atan2(xt1,xt)/pi2
410        xe=x(l)
           if(xt.gt.xe)goto 420
           if((xe-xt).lt.fsh)goto 415
           l=l+1
           goto 410
415        a(j)=y(l)
           goto 425
420        if((xt-xe).lt.fsh)goto 415
           grid(1)=ft
           a(j)=gee(1,nz)
425        if(l.gt.1)l=l-1
430     continue
        grid(1)=gtemp
        dden=pi2/cn
        do 510 j=1,nfcns
           dtemp=0.
           dnum=j-1
           dnum=dnum*dden
           if(nm1.lt.1)goto 505
           do 500 k=1,nm1
              dak=a(k+1)
              dk=k
              dtemp=dtemp+dak*cos(dnum*dk)
500        continue
505        dtemp=dtemp*2.+a(1)
           alpha(j)=dtemp
510     continue
        do 550 j=2,nfcns
           alpha(j)=alpha(j)*2./cn
550     continue
        alpha(1)=alpha(1)/cn
        if(kkk.eq.1) goto 545
        p(1)=2.*alpha(nfcns)*bb+alpha(nm1)
        p(2)=2.*alpha(nfcns)*aa
        q(1)=alpha(nfcns-2)-alpha(nfcns)
        do 540 j=2,nm1
           if(j.lt.nm1) goto 515
           aa=.5*aa
           bb=.5*bb
515        continue
           p(j+1)=0.
           do 520 k=1,j
              a(k)=p(k)
              p(k)=2.*bb*a(k)
520        continue
           p(2)=p(2)+a(1)*2.*aa
           jm1=j-1
           do 525 k=1,jm1
              p(k)=p(k)+q(k)+aa*a(k+1)
525        continue
           jp1=j+1
           do 530 k=3,jp1
              p(k)=p(k)+aa*a(k-1)
530        continue
           if(j.eq.nm1) goto 540
           do 535 k=1,j
              q(k)=-a(k)
535        continue
           nf1j=nfcns-j-1
           q(1)=q(1)+alpha(nf1j)
540     continue
        do 543 j=1,nfcns
           alpha(j)=p(j)
543     continue
545     continue
        if(nfcns.gt.3) return
        alpha(nfcns+1)=0.0
        alpha(nfcns+2)=0.0
        return
        end
c----------------------------------------------------------------------
        function d(k,n,m)
        dimension iext(66),ad(66),alpha(66),x(66),y(66)
        dimension des(1045),grid(1045),wt(1045)
        common pi2,ad,dev,x,y,grid,des,wt,alpha,iext,nfcns,ngrid
        d=1.
        q=x(k)
        do 3 l=1,m
           do 2 j=l,n,m
              if(j-k)1,2,1
1          d=2.*d*(q-x(j))
2          continue
3       continue
        d=1./d
        return
        end
c----------------------------------------------------------------------
        function gee(k,n)
        dimension iext(66),ad(66),alpha(66),x(66),y(66)
        dimension des(1045),grid(1045),wt(1045)
c        double precision ad,dev,x,y,p12,p,c,d,xf
        common pi2,ad,dev,x,y,grid,des,wt,alpha,iext,nfcns,ngrid
        p=0.0
        xf=grid(k)
        xf=cos(pi2*xf)
        d1=0.
        do 1 j=1,n
           c=xf-x(j)
           c=ad(j)/c
           d1=d1+c
           p=p+c*y(j)
1       continue
        gee=p/d1
        return
        end
c----------------------------------------------------------------------
        subroutine ouch
        common /oops/niter
        return
        end
