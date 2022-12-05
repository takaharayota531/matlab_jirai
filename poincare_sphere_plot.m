function poincare_sphere_plot(S_HH,S_HV,S_VH,S_VV)
    

    [x_horizontal,y_horizontal,z_horizontal,plot_order_horizontal]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,1,0);
    
    
    figure(1);
   
   % scatter3(x_horizontal,y_horizontal,z_horizontal,36,plot_order_horizontal);
   % scatter3(x_horizontal,y_horizontal,z_horizontal,36,"red");
%     title("horizontal_xdirection");
  
    colormap(parula);

    
    % hold on
    %figure(2);
    [x_vertical,y_vertical,z_vertical,plot_order_vertical]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,0,1);
   % scatter3(x_vertical,y_vertical,z_vertical,36,plot_order_vertical);
% scatter3(x_vertical,y_vertical,z_vertical,36,"blue");
   
   
    


    [x_for_45,y_for_45,z_for_45,plot_order_for_45]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,1/sqrt(2),1/sqrt(2));
    % plot3(x_for_45,y_for_45,z_for_45,'o','Color','black');
    scatter3(x_for_45,y_for_45,z_for_45,36,plot_order_for_45);
   
%     [x_back_45,y_back_45,z_back_45]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,-1/sqrt(2),1/sqrt(2));
%     plot3(x_back_45,y_back_45,z_back_45,'o','Color','yellow');
% 
%     [x_left_45,y_left_45,z_left_45]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,1/sqrt(2),1i*1/sqrt(2));
%     plot3(x_left_45,y_left_45,z_left_45,'o','Color','cyan');
%     legend("right");
%     [x_right_45,y_right_45,z_right_45]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,1/sqrt(2),-1i*1/sqrt(2));
%     plot3(x_right_45,y_right_45,z_right_45,'o','Color','magenta');
%     legend("left");
    colormap(parula);
    title("45degrees_xdirection");
    %sphere
    % hold off
%     xlim([-1.0 1.0])
%     ylim([-1.0 1.0])
%     zlim([-1.0 1.0])
end