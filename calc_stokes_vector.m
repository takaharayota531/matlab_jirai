function [x,y,z]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV)
    E_rH=S_HH*E_iH+S_HV*E_iV;
    E_rV=S_VH*E_iH+S_VV*E_iV;

    J__HH=mean( E_rH.*conj(E_rH),3);
    J__HV=mean(E_rH.*conj(E_rV),3);
    J__VH=mean(E_rV.*conj(E_rH),3);
    J__VV=mean(E_rV.*conj(E_rV),3);    

    g0=J__HH+J__VV;
    g1=J__HH-J__VV;
    g2=J__HV+J__VH;
    g3=(J__HV-J__VH)*1i;
    x=reshape(g1./g0,[],1);
    y=reshape(g2./g0,[],1);
    z=reshape(g3./g0,[],1);

end