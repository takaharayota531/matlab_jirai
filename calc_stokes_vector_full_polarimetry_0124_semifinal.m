% 圧縮センシング用のS_HH,HV,VH,VVを+計算する
% 今回はwindow_sizeを指定しない
function [S_HH_poincare_mul,S_HV_poincare_mul,S_VH_poincare_mul,S_VV_poincare_mul] = calc_stokes_vector_full_polarimetry_0124_semifinal(S_HH,S_HV,S_VH,S_VV)

    [g0_10,g1_10,~,~] = calc_stokes_vector_full_polarimetry(S_HH,S_HV,S_VH,S_VV,1,0);
    [g0_01,g1_01,~,~] = calc_stokes_vector_full_polarimetry(S_HH,S_HV,S_VH,S_VV,0,1);

    g1g0_10=g1_10./g0_10;
    g1g0_01=g1_01./g0_01;


    S_HH_poincare_mul=S_HH.*g1g0_10;
    S_HV_poincare_mul=S_HV.*g1g0_01;
    S_VH_poincare_mul=S_VH.*g1g0_10;
    S_VV_poincare_mul=S_VV.*g1g0_01;
end