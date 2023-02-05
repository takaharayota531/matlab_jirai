%cal_h用の偏微分計算

function df=calc_df(s,h,model,p)

    [Nx,Ny,FREQ_POINT]=size(s);
    m=size(model,1);
    dh=calc_dh(s,model);
    df=sum_dh(h,dh,p);
end


function dh=calc_dh(s,model)
    [Nx,Ny,FREQ_POINT]=size(s);
    mx=size(model,1);
    my=size(model,2);
  
    rx=floor((mx)/2);
    ry=floor((my)/2);
    Ix = [Nx-rx+1:Nx,1:Nx,1:rx];
    Iy = [Ny-ry+1:Ny,1:Ny,1:ry];

    dh=zeros(Nx,Ny,mx,my,FREQ_POINT,2);
    pmodel=model==1;
    mmodel=model==-1;
    %todo 高原

    for xh=1:Nx
        for yh=1:Ny
            st=s(Ix(xh:xh+mx-1),Iy(yh:yh+my-1),:);
            dhp=zeros(mx,my,FREQ_POINT,2);
            dhm=zeros(mx,my,FREQ_POINT,2);

            kp=squeeze(sum(pmodel.*st,[1 2]));
            km=squeeze(sum(mmodel.*st,[1 2])); 

            d_kp=zeros(FREQ_POINT,mx,my,FREQ_POINT);
            d_km=zeros(FREQ_POINT,mx,my,FREQ_POINT);

            xs=1:mx;
            ys=1:my;

            for f=1:FREQ_POINT
                d_kp(f,xs,ys,f)=pmodel;%前半のf:K(r,f)のf、後半のf:偏微分するδs(r,f)
                d_km(f,xs,ys,f)=mmodel;
            end
            
            %  d_kp_check=permute(d_kp,[ 2 3 1 4]);
            %  d_kp_ccheck=d_kp_check(:,:,:,1:10);

            

            abs_kp=sqrt(kp'*kp);% 絶対値に関する部分
            abs_km=sqrt(km'*km);
            kpn=kp/abs_kp;
            kmn=km/abs_km;

            d_akp=zeros(Nx,Ny,FREQ_POINT,2); %|kp|の偏微分
            d_akm=zeros(Nx,Ny,FREQ_POINT,2); %|km|の偏微分

            f=1:FREQ_POINT;
            d_akp(xs,ys,f,1)=squeeze(sum(d_kp(:,xs,ys,f).*conj(kp),1)/2/abs_kp).*pmodel;
            d_akp(xs,ys,f,2)=squeeze(sum(conj(d_kp(:,xs,ys,f)).*kp,1)/2/abs_kp).*pmodel;
            d_akm(xs,ys,f,1)=squeeze(sum(d_km(:,xs,ys,f).*conj(km),1)/2/abs_km).*mmodel;
            d_akm(xs,ys,f,2)=squeeze(sum(conj(d_km(:,xs,ys,f)).*km,1)/2/abs_km).*mmodel;

            d_kpn=zeros(FREQ_POINT,mx,my,FREQ_POINT,2);
            d_kmn=zeros(FREQ_POINT,mx,my,FREQ_POINT,2);

            xs=1:mx;
            ys=1:my;
            f=1:FREQ_POINT;

            d_kmn(:,xs,ys,f,1)=(d_km(:,xs,ys,f)*abs_km-km.*reshape(d_akm(xs,ys,f,1),1,mx,my,FREQ_POINT))/abs_km^2;
            d_kmn(:,xs,ys,f,2)=(-km.*reshape(d_akm(xs,ys,f,2),1,mx,my,FREQ_POINT))/abs_km^2;
            dhm(xs,ys,f,1)=-sum(conj(kpn).*d_kmn(:,xs,ys,f,1)+kpn.*conj(d_kmn(:,xs,ys,f,2)),1)/2;
            dhm(xs,ys,f,2)=-sum(conj(kpn).*d_kmn(:,xs,ys,f,2)+kpn.*conj(d_kmn(:,xs,ys,f,1)),1)/2;
            dhm(xs,ys,f,:)=dhm(xs,ys,f,:).*pmodel;

            d_kpn(:,xs,ys,f,1) = (d_kp(:,xs,ys,f)*abs_kp-kp.*reshape(d_akp(xs,ys,f,1),1,mx,my,FREQ_POINT))/abs_kp^2;
            d_kpn(:,xs,ys,f,2) = (-kp.*reshape(d_akp(xs,ys,f,2),1,mx,my,FREQ_POINT))/abs_kp^2;
            dhp(xs,ys,f,1) = -sum(conj(kmn).*d_kpn(:,xs,ys,f,1)+kmn.*conj(d_kpn(:,xs,ys,f,2)),1)/2;
            dhp(xs,ys,f,2) = -sum(conj(kmn).*d_kpn(:,xs,ys,f,2)+kmn.*conj(d_kpn(:,xs,ys,f,1)),1)/2;
            dhp(xs,ys,f,:) = dhp(xs,ys,f,:).*pmodel;
                
            dh(xh,yh,:,:,:,:)=dhp+dhm;
        end
    end
end














function df=sum_dh(h,dh,p)
    [Nx,Ny,mx,my,FREQ_POINT]=size(dh,1,2,3,4,5);
    df=zeros(Nx,Ny,FREQ_POINT,2);
 
    rx=floor((mx)/2);
    ry=floor((my)/2);
    Ix = [Nx-rx+1:Nx,1:Nx,1:rx];
    Iy = [Ny-ry+1:Ny,1:Ny,1:ry];

    for x=1:Nx
        for y=1:Ny
            df(Ix(x:x+mx-1),Iy(y:y+my-1),:,:)=df(Ix(x:x+mx-1),Iy(y:y+my-1),:,:)...
                    +squeeze(p*h(x,y)^(p-1)*dh(x,y,:,:,:,:));
        end
    end
end