function [x_ordered,y_ordered,z_ordered,plot_order,plot_order_array]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,f)
    E_rH=S_HH*E_iH+S_HV*E_iV;
    E_rV=S_VH*E_iH+S_VV*E_iV;


    window_size=7;

%      E_rH=1*ones(46,46,201);
%      E_rV=1*zeros(46,46,201)/sqrt(2);

    % window_size=7;
    after_size_changed_E_rH= data_size_change(E_rH,window_size);
    after_size_changed_E_rV= data_size_change(E_rV,window_size);
    
    averaged_E_rH= decide_window(after_size_changed_E_rH,window_size);
    averaged_E_rV= decide_window(after_size_changed_E_rV,window_size);

      J__HH=squeeze(( averaged_E_rH.*conj( averaged_E_rH)));
      J__HV=squeeze(( averaged_E_rH.*conj( averaged_E_rV)));
      J__VH=squeeze(( averaged_E_rV.*conj( averaged_E_rH)));
      J__VV=squeeze(( averaged_E_rV.*conj( averaged_E_rV)));   
% 
%         J__HH=( E_rH.*conj(E_rH));
%         J__HV=(E_rH.*conj(E_rV));
%         J__VH=(E_rV.*conj(E_rH));
%         J__VV=(E_rV.*conj(E_rV));    
%     HH=E_rH.*conj(E_rH);
%     HV=E_rH.*conj(E_rV);
%     VH=E_rV.*conj(E_rH);
%     VV=E_rV.*conj(E_rV);   
%     J__HH=HH(:,:,1);
%     J__HV=HV(:,:,1);
%     J__VH=VH(:,:,1);
%     J__VV=VV(:,:,1);   


   
    % averaged_J_HH=decide_window(J__HH,window_size);
    % averaged_J_HV=decide_window(J__HV,window_size);
    % averaged_J_VH=decide_window(J__VH,window_size);
    % averaged_J_VV=decide_window(J__VV,window_size);

    % g0=averaged_J_HH+averaged_J_VV;
    % g1=averaged_J_HH-averaged_J_VV;
    % g2=averaged_J_HV+averaged_J_VH;
    % g3=(averaged_J_HV-averaged_J_VH)*1i;

    g0=J__HH+J__VV;
    g1=J__HH-J__VV;
    g2=J__HV+J__VH;
    g3=(J__HV-J__VH)*1i;

    [x,y,z]=calc_xyz_for_poincare(g0,g1,g2,g3);
    % averaged_x=decide_window(x,window_size);
    % averaged_y=decide_window(y,window_size);
    % averaged_z=decide_window(z,window_size);
    [x_ordered,y_ordered,z_ordered,plot_order,plot_order_array]=make_plot_order(x,y,z,window_size);
   % [x_ordered,y_ordered,z_ordered,plot_order,plot_order_array]=make_plot_order(averaged_x,averaged_y,averaged_z,window_size);
   % averaged_window=decide_window(plot_order_array,window_size);
   % [x,y,z,plot_order,plot_order_array]=make_plot_order_full_size(g0,g1,g2,g3);
   % only_for_plot(plot_order_array,f,"experimental plot",0.25,0.36,window_size);
 %  migration_and_plot_polarization
    
end