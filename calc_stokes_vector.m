function [x,y,z,plot_order,plot_order_array]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,f)
    E_rH=S_HH*E_iH+S_HV*E_iV;
    E_rV=S_VH*E_iH+S_VV*E_iV;

    window_size=7;
    averaged_E_rH= decide_window(E_rH,window_size);
    averaged_E_rV= decide_window(E_rV,window_size);
    

    J__HH=squeeze(( averaged_E_rH.*conj( averaged_E_rH)));
    J__HV=squeeze(( averaged_E_rH.*conj( averaged_E_rV)));
    J__VH=squeeze(( averaged_E_rV.*conj( averaged_E_rH)));
    J__VV=squeeze(( averaged_E_rV.*conj( averaged_E_rV)));   

    %  J__HH=squeeze( E_rH.*conj(E_rH));
    %  J__HV=squeeze(E_rH.*conj(E_rV));
    %  J__VH=squeeze(E_rV.*conj(E_rH));
    %  J__VV=squeeze(E_rV.*conj(E_rV));    
%     HH=E_rH.*conj(E_rH);
%     HV=E_rH.*conj(E_rV);
%     VH=E_rV.*conj(E_rH);
%     VV=E_rV.*conj(E_rV);   
%     J__HH=HH(:,:,1);
%     J__HV=HV(:,:,1);
%     J__VH=VH(:,:,1);
%     J__VV=VV(:,:,1);   

    g0=J__HH+J__VV;
    g1=J__HH-J__VV;
    g2=J__HV+J__VH;
    g3=(J__HV-J__VH)*1i;

    [x,y,z,plot_order,plot_order_array]=make_plot_order(g0,g1,g2,g3);
   % averaged_window=decide_window(plot_order_array,window_size);
   % [x,y,z,plot_order,plot_order_array]=make_plot_order_full_size(g0,g1,g2,g3);
   % only_for_plot(plot_order_array,f,"experimental plot",0.25,0.36,window_size);
 %  migration_and_plot_polarization
    
end