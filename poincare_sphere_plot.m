function poincare_sphere_plot(S_HH,S_HV,S_VH,S_VV,f)
    

    [x_horizontal,y_horizontal,z_horizontal,plot_order_horizontal,var_x_hori,var_y_hori,var_z_hori]=calc_stokes_vector_1220(S_HH,S_HV,S_VH,S_VV,1,0,f);
    [x_vertical,y_vertical,z_vertical,plot_order_vertical,var_x_ver,var_y_ver,var_z_ver]=calc_stokes_vector_1220(S_HH,S_HV,S_VH,S_VV,0,1,f);
    [x_for_45,y_for_45,z_for_45,plot_order_for_45,var_x_for_45,var_y_for_45,var_z_for_45]=calc_stokes_vector_1220(S_HH,S_HV,S_VH,S_VV,1/sqrt(2),1/sqrt(2),f);
    [x_back_45,y_back_45,z_back_45,plot_order_back_45,var_x_back_45,var_y_back_45,var_z_back_45]=calc_stokes_vector_1220(S_HH,S_HV,S_VH,S_VV,-1/sqrt(2),1/sqrt(2),f);
    [x_left_45,y_left_45,z_left_45,plot_order_left_45,var_x_left_45,var_y_left_45,var_z_left_45]=calc_stokes_vector_1220(S_HH,S_HV,S_VH,S_VV,1/sqrt(2),1i*1/sqrt(2),f);
    [x_right_45,y_right_45,z_right_45,plot_order_right_45,var_x_right_45,var_y_right_45,var_z_right_45]=calc_stokes_vector_1220(S_HH,S_HV,S_VH,S_VV,1/sqrt(2),-1i*1/sqrt(2),f);

    % [x_horizontal,y_horizontal,z_horizontal,plot_order_horizontal]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,1,0,f);
    % [x_vertical,y_vertical,z_vertical,plot_order_vertical]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,0,1,f);
    % [x_for_45,y_for_45,z_for_45,plot_order_for_45]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,1/sqrt(2),1/sqrt(2),f);
    % [x_back_45,y_back_45,z_back_45,plot_order_back_45]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,-1/sqrt(2),1/sqrt(2),f);
    % [x_left_45,y_left_45,z_left_45,plot_order_left_45]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,1/sqrt(2),1i*1/sqrt(2),f);
    % [x_right_45,y_right_45,z_right_45,plot_order_right_45]=calc_stokes_vector(S_HH,S_HV,S_VH,S_VV,1/sqrt(2),-1i*1/sqrt(2),f);

    

    
    
%      scatter3(x_horizontal,y_horizontal,z_horizontal,12,"red","filled");
%       hold on
%     scatter3(x_vertical,y_vertical,z_vertical,12,"blue","filled");
%     scatter3(x_for_45,y_for_45,z_for_45,12,"black","filled");
%     scatter3(x_back_45,y_back_45,z_back_45,12,"yellow","filled");
%     scatter3(x_left_45,y_left_45,z_left_45,12,"cyan","filled");   
%     scatter3(x_right_45,y_right_45,z_right_45,12,"magenta","filled");
%     legend("horizontal","vertical","+45°","-45°","left","right");
%     xlabel("x");
%     ylabel("y");
%     zlabel("z");
%    title("new-all-plot");
%     sphere
%     colormap(parula);
%       hold off


%     for i=1:6
%         figure(i);
%         if i==1
%             scatter3(x_horizontal,y_horizontal,z_horizontal,12,plot_order_horizontal,"filled");
%             title("horizontal");
%         elseif i==2
%             scatter3(x_vertical,y_vertical,z_vertical,12,plot_order_vertical,"filled");
%             title("vertical");
%         elseif i==3
%             scatter3(x_for_45,y_for_45,z_for_45,12,plot_order_for_45,"filled");
%             title("+45");
%         elseif i==4
%             scatter3(x_back_45,y_back_45,z_back_45,12,plot_order_back_45,"filled");
%             title("-45");
%         elseif i==5
%             scatter3(x_left_45,y_left_45,z_left_45,12,plot_order_left_45,"filled"); 
%             title("left");
%         elseif i==6
%             scatter3(x_right_45,y_right_45,z_right_45,12,plot_order_right_45,"filled");
%             title("right");
%         end
%       xlabel("x");
%       ylabel("y");
%       zlabel("z");
%       colormap(cool); 
%       hold on
%       sphere
%       colormap(parula);
%       hold off
%       end


%     for i=1:6
%         figure(i);
%         if i==1
%           scatter3(var_x_hori,var_y_hori,var_z_hori ,12,plot_order_horizontal,"filled");
%             title("horizontal");
%         elseif i==2
%             scatter3(var_x_ver , var_y_ver , var_z_ver ,12,plot_order_vertical,"filled");
%             title("vertical");
%         elseif i==3
%             scatter3(var_x_for_45 , var_y_for_45 , var_z_for_45 ,12,plot_order_for_45,"filled");
%             title("+45");
%         elseif i==4
%             scatter3( var_x_back_45  ,var_y_back_45 , var_z_back_45 ,12,plot_order_back_45,"filled");
%             title("-45");
%         elseif i==5
%             scatter3( var_x_left_45  , var_y_left_45 , var_z_left_45 ,12,plot_order_left_45,"filled"); 
%             title("left");
%         elseif i==6
%             scatter3( var_x_right_45 , var_y_right_45 , var_z_right_45 ,12,plot_order_right_45,"filled");
%             title("right");
%         end
%         xlabel("sigma-x");
%         ylabel("sigma-y");
%         zlabel("sigma-z");
%   
%      
%       end


   
  
      
   
     
    

end