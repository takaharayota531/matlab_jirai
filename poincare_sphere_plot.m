function [g0,g1,g2,g3]=poincare_sphere_plot(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV)
    
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
    x=g1./g0;
    y=g2./g0;
    z=g3./g0;
    plot3(x,y,z,'o');
    xlim([-1.0 1.0])
    ylim([-1.0 1.0])
    zlim([-1.0 1.0])
end