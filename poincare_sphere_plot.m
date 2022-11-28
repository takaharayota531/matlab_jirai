function poincare_sphere_plot(S_HH,S_HV,S_VH,S_VV)
    
   
    [x_horizontal,y_horizontal,z_horizontal]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,1,0);
    
    c = linspace(0,length(x_horizontal),length(x_horizontal));
    %plot_object=scatter3(x_horizontal,y_horizontal,z_horizontal,'o','Color','red');
    plot_object=scatter3(x_horizontal,y_horizontal,z_horizontal,36,x_horizontal);
    colormap(parula);
%     ax1=tiledlayout(1,1) ;
%     colormap(ax1,parula)
%    
    
     hold on
%     [x_vertical,y_vertical,z_vertical]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,0,1);
%     plot3(x_vertical,y_vertical,z_vertical,'o','Color','blue');
%     [x_for_45,y_for_45,z_for_45]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,1/sqrt(2),1/sqrt(2));
%     plot3(x_for_45,y_for_45,z_for_45,'o','Color','black');
%     [x_back_45,y_back_45,z_back_45]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,-1/sqrt(2),1/sqrt(2));
%     plot3(x_back_45,y_back_45,z_back_45,'o','Color','yellow');
% 
%     [x_left_45,y_left_45,z_left_45]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,1/sqrt(2),1i*1/sqrt(2));
%     plot3(x_left_45,y_left_45,z_left_45,'o','Color','cyan');
%     [x_right_45,y_right_45,z_right_45]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,1/sqrt(2),-1i*1/sqrt(2));
%     plot3(x_right_45,y_right_45,z_right_45,'o','Color','magenta');

    %sphere
    hold off
%     xlim([-1.0 1.0])
%     ylim([-1.0 1.0])
%     zlim([-1.0 1.0])
end