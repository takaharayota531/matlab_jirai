% 微分した形を計算しておく
%  TODO ここの配列は入れ替える

function [g1_diff_by_g0_HH,g1_diff_by_g0_HV,g1_diff_by_g0_VH,g1_diff_by_g0_VV, ...
        g2_diff_by_g0_HH,g2_diff_by_g0_HV,g2_diff_by_g0_VH,g2_diff_by_g0_VV, ...
        g3_diff_by_g0_HH,g3_diff_by_g0_HV,g3_diff_by_g0_VH,g3_diff_by_g0_VV] ... 
    =calc_complex_diff_full_polarimetry(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV)


    [g1_diff_by_g0_HH,g2_diff_by_g0_HH,g3_diff_by_g0_HH]    = DIFF_BY_G0_IN_S_HH(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV);
    [g1_diff_by_g0_HV,g2_diff_by_g0_HV,g3_diff_by_g0_HV]    = DIFF_BY_G0_IN_S_HV(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV);
    [g1_diff_by_g0_VH,g2_diff_by_g0_VH,g3_diff_by_g0_VH]    = DIFF_BY_G0_IN_S_VH(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV);
    [g1_diff_by_g0_VV,g2_diff_by_g0_VV,g3_diff_by_g0_VV]    = DIFF_BY_G0_IN_S_VV(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV);
    

end


% % 単に結合してくれるだけ
% function [tmp_S_HH,tmp_S_HV,tmp_S_VH,tmp_S_VV] = combine_g(diff_g0,diff_g1,diff_g2,diff_g3,g0,g1,g2,g3)

%     g1_diff_by_g0    =G1_DIFF_BY_G0(diff_g0,diff_g1,diff_g2,diff_g3,g0,g1,g2,g3,DIFF_BY_S);
%     g2_diff_by_g0    =G2_DIFF_BY_G0(diff_g0,diff_g1,diff_g2,diff_g3,g0,g1,g2,g3,DIFF_BY_S);
%     g3_diff_by_g0    =G3_DIFF_BY_G0(diff_g0,diff_g1,diff_g2,diff_g3,g0,g1,g2,g3,DIFF_BY_S);
    


% end

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