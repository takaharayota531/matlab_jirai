function [averaged_x,averaged_y,averaged_z,variance_x,variance_y,variance_z]=calc_stokes_vector1220(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,f,window_size)
    E_rH=S_HH*E_iH+S_HV*E_iV;
    E_rV=S_VH*E_iH+S_VV*E_iV;


   
% 
%      E_rH=1*ones(46,46,201)/sqrt(2);
%      E_rV=1i*ones(46,46,201)/sqrt(2);

 
    after_size_changed_E_rH= data_size_change(E_rH,window_size);
    after_size_changed_E_rV= data_size_change(E_rV,window_size);
    
   
    J__HH=( after_size_changed_E_rH.*conj(after_size_changed_E_rH));
    J__HV=(after_size_changed_E_rH.*conj(after_size_changed_E_rV));
    J__VH=(after_size_changed_E_rV.*conj(after_size_changed_E_rH));
    J__VV=(after_size_changed_E_rV.*conj(after_size_changed_E_rV));    

    g0=J__HH+J__VV;
    g1=J__HH-J__VV;
    g2=J__HV+J__VH;
    g3=(J__HV-J__VH)*1i;

    [x,y,z]=calc_xyz_for_poincare(g0,g1,g2,g3);
    averaged_x=decide_window(x,window_size);
    averaged_y=decide_window(y,window_size);
    averaged_z=decide_window(z,window_size);

    variance_x=calc_window_for_average_and_variance(x,window_size);
    variance_y=calc_window_for_average_and_variance(y,window_size);
    variance_z=calc_window_for_average_and_variance(z,window_size);
    %[x_ordered,y_ordered,z_ordered,plot_order,plot_order_array]=make_plot_order(x,y,z,window_size);
    % [x_ordered_variance,y_ordered_variance,z_ordered_variance,plot_order_variance,plot_order_array_variance]=make_plot_order(variance_x,variance_y,variance_z,window_size);
    % [x_ordered,y_ordered,z_ordered,plot_order,plot_order_array]=make_plot_order(averaged_x,averaged_y,averaged_z,window_size);
   % averaged_window=decide_window(plot_order_array,window_size);
   % [x,y,z,plot_order,plot_order_array]=make_plot_order_full_size(g0,g1,g2,g3);
%    only_for_plot(plot_order_array,f,"experimental plot",0.25,0.36,window_size);
 %  migration_and_plot_polarization
    
end