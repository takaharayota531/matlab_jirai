function poincare_sphere_plot(S_HH,S_HV,S_VH,S_VV,f)
    

    [x_horizontal,y_horizontal,z_horizontal,plot_order_horizontal]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,1,0,f);
%     [x_vertical,y_vertical,z_vertical,plot_order_vertical]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,0,1,f);
%     [x_for_45,y_for_45,z_for_45,plot_order_for_45]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,1/sqrt(2),1/sqrt(2),f);
%     [x_back_45,y_back_45,z_back_45,plot_order_back_45]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,-1/sqrt(2),1/sqrt(2),f);
%     [x_left_45,y_left_45,z_left_45,plot_order_left_45]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,1/sqrt(2),1i*1/sqrt(2),f);
%     [x_right_45,y_right_45,z_right_45,plot_order_right_45]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,1/sqrt(2),-1i*1/sqrt(2),f);
% 

    

  
   
   
   % scatter3(x_horizontal,y_horizontal,z_horizontal,36,plot_order_horizontal,"filled");
 %   scatter3(x_horizontal,y_horizontal,z_horizontal,36,"red","filled");
   

    %scatter3(x_vertical,y_vertical,z_vertical,36,plot_order_vertical,"filled");
  % scatter3(x_vertical,y_vertical,z_vertical,36,"blue","filled");
   

 %  scatter3(x_for_45,y_for_45,z_for_45,36,plot_order_for_45,"filled");
   %  scatter3(x_for_45,y_for_45,z_for_45,36,"black","filled");
 
     % scatter3(x_back_45,y_back_45,z_back_45,36,plot_order_back_45,"filled");
   %scatter3(x_back_45,y_back_45,z_back_45,36,"yellow","filled");
      
   %  scatter3(x_left_45,y_left_45,z_left_45,36,plot_order_left_45,"filled");  
     % scatter3(x_left_45,y_left_45,z_left_45,36,"cyan","filled");   
    

       % scatter3(x_right_45,y_right_45,z_right_45,36,plot_order_right_45,"filled");
      %    scatter3(x_right_45,y_right_45,z_right_45,36,"magenta","filled");
       xlabel("x");
    ylabel("y");
    zlabel("z");
   title("-45");

    colormap(parula); 
  
       hold on
   % legend("horizontal","vertical","+45°","-45°","left","right");
    sphere
    
   
     hold off
     
    

end