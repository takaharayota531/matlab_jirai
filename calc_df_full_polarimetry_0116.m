
function df=calc_df_full_polarimetry_0116(K,h,model,p,DIFF_BY,E_iH,E_iV,FREQ_POINT)

    [Nx,Ny,ALL_FREQ_POINT]=size(K);
    
    [g1_diff_by_g0,g2_diff_by_g0,g3_diff_by_g0]=poincare_diff(K,DIFF_BY,E_iH,E_iV,FREQ_POINT);
    m=size(model,1);
    dh=calc_dh(K,model,g1_diff_by_g0,g2_diff_by_g0,g3_diff_by_g0,DIFF_BY,FREQ_POINT);
    df=sum_dh(h,dh,p,FREQ_POINT);
end


function [g1_diff_by_g0,g2_diff_by_g0,g3_diff_by_g0]=poincare_diff(K,DIFF_BY,E_iH,E_iV,FREQ_POINT)

    S_HH=K(:,:,1:FREQ_POINT);
    S_HV=K(:,:,FREQ_POINT+1:2*FREQ_POINT);
    S_VH=K(:,:,2*FREQ_POINT+1:3*FREQ_POINT);
    S_VV=K(:,:,3*FREQ_POINT+1:4*FREQ_POINT);

    if   DIFF_BY=='DIFF_by_S_HH'
        [g1_diff_by_g0,g2_diff_by_g0,g3_diff_by_g0]   = DIFF_BY_G0_IN_S_HH(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV);
    elseif  DIFF_BY=='DIFF_by_S_HV'
        [g1_diff_by_g0,g2_diff_by_g0,g3_diff_by_g0]   = DIFF_BY_G0_IN_S_HV(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV);
    elseif   DIFF_BY=='DIFF_by_S_VH'
        [g1_diff_by_g0,g2_diff_by_g0,g3_diff_by_g0]   = DIFF_BY_G0_IN_S_VH(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV);
    elseif  DIFF_BY=='DIFF_by_S_VV'
        [g1_diff_by_g0,g2_diff_by_g0,g3_diff_by_g0]   = DIFF_BY_G0_IN_S_VV(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV);


    end

end

function dh=calc_dh(K,model,g1_diff_by_g0,g2_diff_by_g0,g3_diff_by_g0,DIFF_BY,FREQ_POINT)
    [Nx,Ny,ALL_FREQ_POINT]=size(K);
    POLARIMETRY_NUM=4;
    mx=size(model,1);
    my=size(model,2);
  
    rx=floor((mx)/2);
    ry=floor((my)/2);
    Ix = [Nx-rx+1:Nx,1:Nx,1:rx];
    Iy = [Ny-ry+1:Ny,1:Ny,1:ry];

    dh=zeros(Nx,Ny,mx,my,FREQ_POINT*4,2);
    pmodel=model==1;
    mmodel=model==-1;
    %todo 高原

    % これがモデル掃引の役割をはたしている
    for xh=1:Nx
        for yh=1:Ny
            % モデル掃引領域内のデータを取得
            st=K(Ix(xh:xh+mx-1),Iy(yh:yh+my-1),:);
            dhp=zeros(mx,my,FREQ_POINT*4,2);
            dhm=zeros(mx,my,FREQ_POINT*4,2);

            % モデル領域内の平均データを取得
            kp=squeeze(sum(pmodel.*st,[1 2]));
            km=squeeze(sum(mmodel.*st,[1 2]));

            % TODO ここを修正する必要あり
            % 偏微分変更
            d_kp=zeros(ALL_FREQ_POINT,mx,my,FREQ_POINT*4);
            d_km=zeros(ALL_FREQ_POINT,mx,my,FREQ_POINT*4);

            d_kp_conj=zeros(ALL_FREQ_POINT,mx,my,FREQ_POINT*4);
            d_km_conj=zeros(ALL_FREQ_POINT,mx,my,FREQ_POINT*4);

            xs=1:mx;
            ys=1:my;

            MUL_COEEFICIENT=0;
            if DIFF_BY == 'DIFF_by_S_HH'
                MUL_COEEFICIENT=0;
            elseif DIFF_BY == 'DIFF_by_S_HV'
                MUL_COEEFICIENT=1;
            elseif DIFF_BY == 'DIFF_by_S_VH'
                MUL_COEEFICIENT=2;
            elseif DIFF_BY == 'DIFF_by_S_VV'
                MUL_COEEFICIENT=3;      
            end

            for f=1:FREQ_POINT
                
                d_kp(MUL_COEEFICIENT*FREQ_POINT+f,xs,ys,MUL_COEEFICIENT*FREQ_POINT+f)=pmodel;%前半のf:K(r,f)のf、後半のf:偏微分するδK(r,f)
                d_km(MUL_COEEFICIENT*FREQ_POINT+f,xs,ys,MUL_COEEFICIENT*FREQ_POINT+f)=mmodel;
                d_kp(4*FREQ_POINT+f,xs,ys,MUL_COEEFICIENT*FREQ_POINT+f)=pmodel.*g1_diff_by_g0(xs,ys,f);%前半のf:K(r,f)のf、後半のf:偏微分するδK(r,f)
                d_km(4*FREQ_POINT+f,xs,ys,MUL_COEEFICIENT*FREQ_POINT+f)=mmodel.*g1_diff_by_g0(xs,ys,f);   
                d_kp(5*FREQ_POINT+f,xs,ys,MUL_COEEFICIENT*FREQ_POINT+f)=pmodel.*g2_diff_by_g0(xs,ys,f);%前半のf:K(r,f)のf、後半のf:偏微分するδK(r,f)
                d_km(5*FREQ_POINT+f,xs,ys,MUL_COEEFICIENT*FREQ_POINT+f)=mmodel.*g2_diff_by_g0(xs,ys,f);   
                d_kp(6*FREQ_POINT+f,xs,ys,MUL_COEEFICIENT*FREQ_POINT+f)=pmodel.*g3_diff_by_g0(xs,ys,f);%前半のf:K(r,f)のf、後半のf:偏微分するδK(r,f)
                d_km(6*FREQ_POINT+f,xs,ys,MUL_COEEFICIENT*FREQ_POINT+f)=mmodel.*g3_diff_by_g0(xs,ys,f);   

                d_kp_conj(4*FREQ_POINT+f,xs,ys,MUL_COEEFICIENT*FREQ_POINT+f)=pmodel.*g1_diff_by_g0(xs,ys,f);%前半のf:K(r,f)のf、後半のf:偏微分するδK(r,f)
                d_km_conj(4*FREQ_POINT+f,xs,ys,MUL_COEEFICIENT*FREQ_POINT+f)=mmodel.*g1_diff_by_g0(xs,ys,f);   
                d_kp_conj(5*FREQ_POINT+f,xs,ys,MUL_COEEFICIENT*FREQ_POINT+f)=pmodel.*g2_diff_by_g0(xs,ys,f);%前半のf:K(r,f)のf、後半のf:偏微分するδK(r,f)
                d_km_conj(5*FREQ_POINT+f,xs,ys,MUL_COEEFICIENT*FREQ_POINT+f)=mmodel.*g2_diff_by_g0(xs,ys,f);   
                d_kp_conj(6*FREQ_POINT+f,xs,ys,MUL_COEEFICIENT*FREQ_POINT+f)=pmodel.*g3_diff_by_g0(xs,ys,f);%前半のf:K(r,f)のf、後半のf:偏微分するδK(r,f)
                d_km_conj(6*FREQ_POINT+f,xs,ys,MUL_COEEFICIENT*FREQ_POINT+f)=mmodel.*g3_diff_by_g0(xs,ys,f);   


            end

%            d_kp_check=permute(d_kp,[ 2 3 1 4]);


            abs_kp=sqrt(kp'*kp);
            abs_km=sqrt(km'*km);
            % 絶対値で正規化したもの
            kpn=kp/abs_kp;
            kmn=km/abs_km;

            d_akp=zeros(Nx,Ny,FREQ_POINT*4,2); %|kp|の偏微分
            d_akm=zeros(Nx,Ny,FREQ_POINT*4,2); %|km|の偏微分

            f=1:FREQ_POINT*4;
            % ここも偏微分の仕方を変更する
            % TODO
            d_akp(xs,ys,f,1)=squeeze(sum(d_kp(:,xs,ys,f).*conj(kp),1)/2/abs_kp).*pmodel;
            d_akp(xs,ys,f,2)=squeeze(sum(conj(d_kp_conj(:,xs,ys,f)).*kp,1)/2/abs_kp).*pmodel;
            d_akm(xs,ys,f,1)=squeeze(sum(d_km(:,xs,ys,f).*conj(km),1)/2/abs_km).*mmodel;
            d_akm(xs,ys,f,2)=squeeze(sum(conj(d_km_conj(:,xs,ys,f)).*km,1)/2/abs_km).*mmodel;


            % 正規化Kの微分を行っている
            d_kpn=zeros(ALL_FREQ_POINT,mx,my,FREQ_POINT*4,2);
            d_kmn=zeros(ALL_FREQ_POINT,mx,my,FREQ_POINT*4,2);
            % 正規化kの複素共役を微分をしている
            % d_kpn_conj=zeros(ALL_FREQ_POINT,mx,my,FREQ_POINT*4,2);
            % d_kmn_conj=zeros(ALL_FREQ_POINT,mx,my,FREQ_POINT*4,2);

            xs=1:mx;
            ys=1:my;
            f=1:FREQ_POINT*4;

            checking1=d_akm(xs,ys,f,1);
            checking=reshape(d_akm(xs,ys,f,1),1,mx,my,FREQ_POINT*4);
            % ここも偏微分対応しておく必要がある
            % TODO
            d_kmn(:,xs,ys,f,1)=(d_km(:,xs,ys,f)*abs_km-km.*reshape(d_akm(xs,ys,f,1),1,mx,my,FREQ_POINT*4))/abs_km^2;
            d_kmn(:,xs,ys,f,2)=(-km.*reshape(d_akm(xs,ys,f,2),1,mx,my,FREQ_POINT*4))/abs_km^2;



            dhm(xs,ys,f,1)=-sum(conj(kpn).*d_kmn(:,xs,ys,f,1)+kpn.*conj(d_kmn(:,xs,ys,f,2)),1)/2;
            dhm(xs,ys,f,2)=-sum(conj(kpn).*d_kmn(:,xs,ys,f,2)+kpn.*conj(d_kmn(:,xs,ys,f,1)),1)/2;
            dhm(xs,ys,f,:)=dhm(xs,ys,f,:).*pmodel;


            

            d_kpn(:,xs,ys,f,1) = (d_kp(:,xs,ys,f)*abs_kp-kp.*reshape(d_akp(xs,ys,f,1),1,mx,my,FREQ_POINT*4))/abs_kp^2;
            d_kpn(:,xs,ys,f,2) = (-kp.*reshape(d_akp(xs,ys,f,2),1,mx,my,FREQ_POINT*4))/abs_kp^2;


            dhp(xs,ys,f,1) = -sum(conj(kmn).*d_kpn(:,xs,ys,f,1)+kmn.*conj(d_kpn(:,xs,ys,f,2)),1)/2;
            dhp(xs,ys,f,2) = -sum(conj(kmn).*d_kpn(:,xs,ys,f,2)+kmn.*conj(d_kpn(:,xs,ys,f,1)),1)/2;
            dhp(xs,ys,f,:) = dhp(xs,ys,f,:).*pmodel;
                
            dh(xh,yh,:,:,:,:)=dhp+dhm;
        end
    end
end


function df=sum_dh(h,dh,p,FREQ_POINT)
    [Nx,Ny,mx,my,ALL_FREQ_POINT]=size(dh,1,2,3,4,5);
    df=zeros(Nx,Ny,ALL_FREQ_POINT,2);
 
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


% 計算してくれる
function [g1_diff_by_g0,g2_diff_by_g0,g3_diff_by_g0]    = DIFF_BY_G0_IN_S_HH(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV)
    DIFF_by_S_HH='DIFF_by_S_HH';
    [diff_g0,diff_g1,diff_g2,diff_g3]=calc_diff_Jones_vector(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,DIFF_by_S_HH);
    [g0,g1,g2,g3] = calc_stokes_vector_full_polarimetry(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV);


    g1_diff_by_g0=1./g0.*(diff_g1)+g1*(-1)./g0./g0.*diff_g0;
    g2_diff_by_g0=1./g0.*(diff_g2)+g2*(-1)./g0./g0.*diff_g0;
    g3_diff_by_g0=1./g0.*(diff_g3)+g3*(-1)./g0./g0.*diff_g0;
end

function [g1_diff_by_g0,g2_diff_by_g0,g3_diff_by_g0]    = DIFF_BY_G0_IN_S_HV(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV)
    DIFF_by_S_HV='DIFF_by_S_HV';
    [diff_g0,diff_g1,diff_g2,diff_g3]=calc_diff_Jones_vector(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,DIFF_by_S_HV);
    [g0,g1,g2,g3] = calc_stokes_vector_full_polarimetry(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV);


    g1_diff_by_g0=1./g0.*(diff_g1)+g1*(-1)./g0./g0.*diff_g0;
    g2_diff_by_g0=1./g0.*(diff_g2)+g2*(-1)./g0./g0.*diff_g0;
    g3_diff_by_g0=1./g0.*(diff_g3)+g3*(-1)./g0./g0.*diff_g0;
end

function [g1_diff_by_g0,g2_diff_by_g0,g3_diff_by_g0]    = DIFF_BY_G0_IN_S_VH(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV)
    DIFF_by_S_VH='DIFF_by_S_VH';
    [diff_g0,diff_g1,diff_g2,diff_g3]=calc_diff_Jones_vector(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,DIFF_by_S_VH);
    [g0,g1,g2,g3] = calc_stokes_vector_full_polarimetry(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV);


    g1_diff_by_g0=1./g0.*(diff_g1)+g1*(-1)./g0./g0.*diff_g0;
    g2_diff_by_g0=1./g0.*(diff_g2)+g2*(-1)./g0./g0.*diff_g0;
    g3_diff_by_g0=1./g0.*(diff_g3)+g3*(-1)./g0./g0.*diff_g0;
end

function [g1_diff_by_g0,g2_diff_by_g0,g3_diff_by_g0]    = DIFF_BY_G0_IN_S_VV(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV)
    DIFF_by_S_VV='DIFF_by_S_VV';
    [diff_g0,diff_g1,diff_g2,diff_g3]=calc_diff_Jones_vector(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,DIFF_by_S_VV);
    [g0,g1,g2,g3] = calc_stokes_vector_full_polarimetry(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV);


    g1_diff_by_g0=1./g0.*(diff_g1)+g1*(-1)./g0./g0.*diff_g0;
    g2_diff_by_g0=1./g0.*(diff_g2)+g2*(-1)./g0./g0.*diff_g0;
    g3_diff_by_g0=1./g0.*(diff_g3)+g3*(-1)./g0./g0.*diff_g0;
end