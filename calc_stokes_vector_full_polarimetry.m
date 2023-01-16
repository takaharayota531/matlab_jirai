% 圧縮センシング用のg0,g1,g2,g3を計算する
% 今回はwindow_sizeを指定しない
function [g0,g1,g2,g3] = calc_stokes_vector_full_polarimetry(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV)

    E_rH=S_HH*E_iH+S_HV*E_iV;
    E_rV=S_VH*E_iH+S_VV*E_iV;

    J__HH=( E_rH.*conj(E_rH));
    J__HV=(E_rH.*conj(E_rV));
    J__VH=(E_rV.*conj(E_rH));
    J__VV=(E_rV.*conj(E_rV));    



    g0=J__HH+J__VV;
    g1=J__HH-J__VV;
    g2=J__HV+J__VH;
    g3=(J__HV-J__VH)*1i;
end