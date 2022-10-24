%cal_h用の偏微分計算

function df=calc_df(s,h,model,p)
    [Nx,Ny,Nf]=size(s);
    m=size(model,1);
    dh=calc_dh(s,model);
    df=sum_dh(h,dh,p);
end


function dh=calc_dh(s,model)
    [Nx,Ny,Nf]=size(s);
    m=size(model,1);
    r=(m-1)/2;
    Ix = [Nx-r+1:Nx,1:Nx,1:r];
    Iy = [Ny-r+1:Ny,1:Ny,1:r];

    dh=zeros(Nx,Ny,m,m,Nf,2);
    pmodel=model==1;
    mmodel=model==-1;

    for xh=1:Nx
        for yh=1:Ny
            st=s(Ix(xh:xh+m-1),Iy(yh:yh+m-1),:);
            dhp=zeros(m,m,Nf,2);
            dhm=zeros(m,m,Nf,2);

            kp=squeeze(sum(pmodel.*st,[1 2]));
            km=squeeze(sum(mmodel.*st,[1 2]));

            d_kp=zeros(Nf,m,m,Nf);
            d_km=zeros(Nf,m,m,Nf);

            xs=1:m;
            ys=1:m;

            for f=1:Nf
                d_kp(f,xs,ys,f)=pmodel;
                d_km(f,xs,ys,f)=mmodel;
            end

            abs_kp=sqrt(kp'*kp);
            abs_km=sqrt(km'*km);
            kpn=kp/abs_kp;
            kmn=km/abs_km;

            d_akp=zeros(Nx,Ny,Nf,2); %|kp|の偏微分
            d_akm=zeros(Nx,Ny,Nf,2); %|km|の偏微分

            f=1:Nf;
            d_akp(xs,ys,f,1)=squeeze(sum(d_kp(:,xs,ys,f).*conj(kp),1)/2/abs_kp).*pmodel;
            d_akp(xs,ys,f,2)=squeeze(sum(conj(d_kp(:,xs,ys,f)).*kp,1)/2/abs_kp).*pmodel;
            d_akm(xs,ys,f,1)=squeeze(sum(d_km(:,xs,ys,f).*conj(km),1)/2/abs_km).*mmodel;
            d_akm(xs,ys,f,2)=squeeze(sum(conj(d_km(:,xs,ys,f)).*km,1)/2/abs_km).*mmodel;

            d_kpn=zeros(Nf,m,m,Nf,2);
            d_kmn=zeros(Nf,m,m,Nf,2);

            xs=1:m;
            ys=1:m;
            f=1:Nf;

            d_kmn(:,xs,ys,f,1)=(d_km(:,xs,ys,f)*abs_km-km.*reshape(d_akm(xs,ys,f,1),1,m,m,Nf))/abs_km^2;
            d_kmn(:,xs,ys,f,2)=(-km.*reshape(d_akm(xs,ys,f,2),1,m,m,Nf))/abs_km^2;
            dhm(xs,ys,f,1)=-sum(conj(kpn).*d_kmn(:,xs,ys,f,1)+kpn.*conj(d_kmn(:,xs,ys,f,2)),1)/2;
            dhm(xs,ys,f,2)=-sum(conj(kpn).*d_kmn(:,xs,ys,f,2)+kpn.*conj(d_kmn(:,xs,ys,f,1)),1)/2;
            dhm(xs,ys,f,:)=dhm(xs,ys,f,:).*pmodel;

            d_kpn(:,xs,ys,f,1) = (d_kp(:,xs,ys,f)*abs_kp-kp.*reshape(d_akp(xs,ys,f,1),1,m,m,Nf))/abs_kp^2;
            d_kpn(:,xs,ys,f,2) = (-kp.*reshape(d_akp(xs,ys,f,2),1,m,m,Nf))/abs_kp^2;
            dhp(xs,ys,f,1) = -sum(conj(kmn).*d_kpn(:,xs,ys,f,1)+kmn.*conj(d_kpn(:,xs,ys,f,2)),1)/2;
            dhp(xs,ys,f,2) = -sum(conj(kmn).*d_kpn(:,xs,ys,f,2)+kmn.*conj(d_kpn(:,xs,ys,f,1)),1)/2;
            dhp(xs,ys,f,:) = dhp(xs,ys,f,:).*pmodel;
                
            dh(xh,yh,:,:,:,:)=dhp+dhm;
        end
    end
end














function df=sum_dh(h,dh,p)
    [Nx,Ny,m,Nf]=size(dh,1,2,3,5);
    df=zeros(Nx,Ny,Nf,2);
    r=(m-1)/2;
    Ix=[Nx-r+1:Nx,1:Nx,1:r];
    Iy=[Ny-r+1:Ny,1:Ny,1:r];

    for x=1:Nx
        for y=1:Ny
            df(Ix(x:x+m-1),Iy(y:y+m-1),:,:)=df(Ix(x:x+m-1),Iy(y:y+m-1),:,:)...
                    +squeeze(p*h(x,y)^(p-1)*dh(x,y,:,:,:,:));
        end
    end
end