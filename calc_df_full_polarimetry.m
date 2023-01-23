function df=calc_df_full_polarimetry(s,h,model,p,FREQ_POINT)
    [Nx,Ny,Nf]=size(s(:,:,1:FREQ_POINT));
    m=size(model,1);

    S_HH=s(:,:,1:FREQ_POINT);
    S_HV=s(:,:,FREQ_POINT+1:2*FREQ_POINT);
    S_VH=s(:,:,2*FREQ_POINT+1:3*FREQ_POINT);
    S_VV=s(:,:,3*FREQ_POINT+1:4*FREQ_POINT);

%    df= create_hori_polarimetry(s,S_HH,S_HV,S_VH,S_VV,model,p,FREQ_POINT,h);
df= create_ver_polarimetry(s,S_HH,S_HV,S_VH,S_VV,model,p,FREQ_POINT,h);



end

% 全偏波について実装
% function create_6_polarimetry(S_HH,S_HV,S_VH,S_VV,model,p)

% end

% 水平偏波のみについて実装
function ans_array = create_hori_polarimetry(s,S_HH,S_HV,S_VH,S_VV,model,p,FREQ_POINT,h)
    [g1_diff_by_g0_HH,g1_diff_by_g0_HV,g1_diff_by_g0_VH,g1_diff_by_g0_VV, ...
        g2_diff_by_g0_HH,g2_diff_by_g0_HV,g2_diff_by_g0_VH,g2_diff_by_g0_VV, ...
        g3_diff_by_g0_HH,g3_diff_by_g0_HV,g3_diff_by_g0_VH,g3_diff_by_g0_VV] ... 
    =calc_complex_diff_full_polarimetry(S_HH,S_HV,S_VH,S_VV,1,0);


    df_combined_g1=create_df_interface( s(:,:,4*FREQ_POINT+1:5*FREQ_POINT) , ... 
    g1_diff_by_g0_HH,g1_diff_by_g0_HV,g1_diff_by_g0_VH,g1_diff_by_g0_VV,model,p,h);
    df_combined_g2=create_df_interface( s(:,:,5*FREQ_POINT+1:6*FREQ_POINT) , ... 
    g2_diff_by_g0_HH,g2_diff_by_g0_HV,g2_diff_by_g0_VH,g2_diff_by_g0_VV,model,p,h);
    df_combined_g3=create_df_interface( s(:,:,6*FREQ_POINT+1:7*FREQ_POINT), ... 
    g3_diff_by_g0_HH,g3_diff_by_g0_HV,g3_diff_by_g0_VH,g3_diff_by_g0_VV,model,p,h);

    ans_array=cat(3,df_combined_g1,df_combined_g2,df_combined_g3);


end

function ans_array = create_ver_polarimetry(s,S_HH,S_HV,S_VH,S_VV,model,p,FREQ_POINT,h)
    [g1_diff_by_g0_HH,g1_diff_by_g0_HV,g1_diff_by_g0_VH,g1_diff_by_g0_VV, ...
        g2_diff_by_g0_HH,g2_diff_by_g0_HV,g2_diff_by_g0_VH,g2_diff_by_g0_VV, ...
        g3_diff_by_g0_HH,g3_diff_by_g0_HV,g3_diff_by_g0_VH,g3_diff_by_g0_VV] ... 
    =calc_complex_diff_full_polarimetry(S_HH,S_HV,S_VH,S_VV,0,1);


    df_combined_g1=create_df_interface( s(:,:,4*FREQ_POINT+1:5*FREQ_POINT) , ... 
    g1_diff_by_g0_HH,g1_diff_by_g0_HV,g1_diff_by_g0_VH,g1_diff_by_g0_VV,model,p,h);
    df_combined_g2=create_df_interface( s(:,:,5*FREQ_POINT+1:6*FREQ_POINT) , ... 
    g2_diff_by_g0_HH,g2_diff_by_g0_HV,g2_diff_by_g0_VH,g2_diff_by_g0_VV,model,p,h);
    df_combined_g3=create_df_interface( s(:,:,6*FREQ_POINT+1:7*FREQ_POINT), ... 
    g3_diff_by_g0_HH,g3_diff_by_g0_HV,g3_diff_by_g0_VH,g3_diff_by_g0_VV,model,p,h);

    ans_array=cat(3,df_combined_g1,df_combined_g2,df_combined_g3);


end



% 水平偏波と垂直偏波について実装
function create_2_polarimetry()
    [g0_hori,g1_hori,g2_hori,g3_hori] = calc_stokes_vector_full_polarimetry(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,1,0);
    [g0_ver,g1_ver,g2_ver,g3_ver] = calc_stokes_vector_full_polarimetry(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,0,1);


end


function df_combined= create_df_interface(s_ranged, ... 
                            diff_by_g0_HH,diff_by_g0_HV,diff_by_g0_VH,diff_by_g0_VV,model,p,h)

    hh_alpha=1;
    hv_alpha=1;
    vh_alpha=1;
    vv_alpha=1;

    % 偏微分の結果
    % [tmp_S_HH,tmp_S_HV,tmp_S_VH,tmp_S_VV]=calc_complex_diff_full_polarimetry(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,DIFF_BY_S);
    % model_g2_divide_by_g0=calc_complex_diff_full_polarimetry(s,g0,g1,g2,g3,DIFF_BY);
    % model_g3_divide_by_g0=calc_complex_diff_full_polarimetry(s,g0,g1,g2,g3,DIFF_BY);


    df_S_HH=calc_df(s_ranged,h,model,diff_by_g0_HH);
    df_S_HV=calc_df(s_ranged,h,model,diff_by_g0_HV);
    df_S_VH=calc_df(s_ranged,h,model,diff_by_g0_VH);
    df_S_VV=calc_df(s_ranged,h,model,diff_by_g0_VV);

    % df_combined=cat(3,df_S_HH,df_S_HV,df_S_VH,df_S_VV);
    df_combined=hh_alpha*df_S_HH+hv_alpha*df_S_HV+vh_alpha*df_S_VH+vv_alpha*df_S_VV;


end


%cal_h用の偏微分計算

function df=calc_df(s,h,model,tmp_S_diff)
    dh=calc_dh(s,model,tmp_S_diff);
    p=0.1; % TODO p=0.1を何とかしておく
    df=sum_dh(h,dh,p);
end


function dh=calc_dh(s,model,tmp_S_diff)
    [Nx,Ny,Nf]=size(s);
    mx=size(model,1);
    my=size(model,2);
  
    rx=floor((mx)/2);
    ry=floor((my)/2);
    Ix = [Nx-rx+1:Nx,1:Nx,1:rx];
    Iy = [Ny-ry+1:Ny,1:Ny,1:ry];

    dh=zeros(Nx,Ny,mx,my,Nf,2);
    pmodel=model==1;
    mmodel=model==-1;
    %todo 高原

    for xh=1:Nx
        for yh=1:Ny
            st=s(Ix(xh:xh+mx-1),Iy(yh:yh+my-1),:);
            dhp=zeros(mx,my,Nf,2);
            dhm=zeros(mx,my,Nf,2);

            kp=squeeze(sum(pmodel.*st,[1 2]));
            km=squeeze(sum(mmodel.*st,[1 2]));

            d_kp=zeros(Nf,mx,my,Nf);
            d_km=zeros(Nf,mx,my,Nf);

            xs=1:mx;
            ys=1:my;

            for f=1:Nf
                d_kp(f,xs,ys,f)=pmodel.*tmp_S_diff(xs,ys,f);%前半のf:s(r,f)のf、後半のf:偏微分するδs(r,f)
                d_km(f,xs,ys,f)=mmodel.*tmp_S_diff(xs,ys,f);%;
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

            d_kpn=zeros(Nf,mx,my,Nf,2);
            d_kmn=zeros(Nf,mx,my,Nf,2);

            xs=1:mx;
            ys=1:my;
            f=1:Nf;

            d_kmn(:,xs,ys,f,1)=(d_km(:,xs,ys,f)*abs_km-km.*reshape(d_akm(xs,ys,f,1),1,mx,my,Nf))/abs_km^2;
            d_kmn(:,xs,ys,f,2)=(-km.*reshape(d_akm(xs,ys,f,2),1,mx,my,Nf))/abs_km^2;
            dhm(xs,ys,f,1)=-sum(conj(kpn).*d_kmn(:,xs,ys,f,1)+kpn.*conj(d_kmn(:,xs,ys,f,2)),1)/2;
            dhm(xs,ys,f,2)=-sum(conj(kpn).*d_kmn(:,xs,ys,f,2)+kpn.*conj(d_kmn(:,xs,ys,f,1)),1)/2;
            dhm(xs,ys,f,:)=dhm(xs,ys,f,:).*pmodel;

            d_kpn(:,xs,ys,f,1) = (d_kp(:,xs,ys,f)*abs_kp-kp.*reshape(d_akp(xs,ys,f,1),1,mx,my,Nf))/abs_kp^2;
            d_kpn(:,xs,ys,f,2) = (-kp.*reshape(d_akp(xs,ys,f,2),1,mx,my,Nf))/abs_kp^2;
            dhp(xs,ys,f,1) = -sum(conj(kmn).*d_kpn(:,xs,ys,f,1)+kmn.*conj(d_kpn(:,xs,ys,f,2)),1)/2;
            dhp(xs,ys,f,2) = -sum(conj(kmn).*d_kpn(:,xs,ys,f,2)+kmn.*conj(d_kpn(:,xs,ys,f,1)),1)/2;
            dhp(xs,ys,f,:) = dhp(xs,ys,f,:).*pmodel;
                
            dh(xh,yh,:,:,:,:)=dhp+dhm;
        end
    end
end














function df=sum_dh(h,dh,p)
    [Nx,Ny,mx,my,Nf]=size(dh,1,2,3,4,5);
    df=zeros(Nx,Ny,Nf,2);
 
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