function [K,s]=create_feature_vector_full_polarimetry(s,E_iH,E_iV,FREQ_POINT,IF_NORMALIZATION)
    S_HH=s(:,:,1:FREQ_POINT);
    S_HV=s(:,:,FREQ_POINT+1:2*FREQ_POINT);
    S_VH=s(:,:,2*FREQ_POINT+1:3*FREQ_POINT);
    S_VV=s(:,:,3*FREQ_POINT+1:4*FREQ_POINT);
    [g0,g1,g2,g3] = calc_stokes_vector_full_polarimetry(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV) ;
    
    
    %正規化処理
    if IF_NORMALIZATION == true
        HH_max=max(abs(S_HH) , [],'all');
        HV_max=max(abs(S_HV) , [],'all');
        VH_max=max(abs(S_VH) , [],'all');
        VV_max=max(abs(S_VV) , [],'all');
        s(:,:,1:FREQ_POINT) = S_HH / HH_max;
        s(:,:,FREQ_POINT+1:2*FREQ_POINT) = S_HV / HV_max;
        s(:,:,2*FREQ_POINT+1:3*FREQ_POINT) = S_VH / VH_max;
        s(:,:,3*FREQ_POINT+1:4*FREQ_POINT) = S_VV / VV_max;
    end

    K=cat(3,s,g1./g0, g2./g0, g3./g0);
end