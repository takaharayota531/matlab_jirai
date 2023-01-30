function poincare_sphere_data_management(S_HH,S_HV,S_VH,S_VV,f,window_size,target_point)

window_size=1;



s_HH_re=S_HH(:,:,target_point);
s_HV_re=S_HV(:,:,target_point);
s_VH_re=S_VH(:,:,target_point);
s_VV_re=S_VV(:,:,target_point);

[x_hori_re,y_hori_re,z_hori_re,...
x_ver_re,y_ver_re,z_ver_re,...
x_for_45_re,y_for_45_re,z_for_45_re,... 
x_back_45_re,y_back_45_re,z_back_45_re,... 
x_left_45_re,y_left_45_re,z_left_45_re,...
x_right_45_re,y_right_45_re,z_right_45_re]=poincare_sphere_plot(s_HH_re,s_HV_re,s_VH_re,s_VV_re,f,window_size);


%  poincare_sphere_arrange(S_HH_re,S_HV_re,S_VH_re,S_VV_re,f,window_size);
end