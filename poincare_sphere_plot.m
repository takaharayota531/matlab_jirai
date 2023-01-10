function [x_hori_re,y_hori_re,z_hori_re,...
    x_ver_re,y_ver_re,z_ver_re,...
    x_for_45_re,y_for_45_re,z_for_45_re,... 
    x_back_45_re,y_back_45_re,z_back_45_re,... 
    x_left_45_re,y_left_45_re,z_left_45_re,...
    x_right_45_re,y_right_45_re,z_right_45_re]=poincare_sphere_plot(S_HH,S_HV,S_VH,S_VV,f,window_size)
    
  

    [x_hori_re,y_hori_re,z_hori_re,var_x_hori_re,var_y_hori_re,var_z_hori_re]=calc_stokes_vector_1220(S_HH,S_HV,S_VH,S_VV,1,0,f,window_size);
    [x_ver_re,y_ver_re,z_ver_re,var_x_ver_re,var_y_ver_re,var_z_ver_re]=calc_stokes_vector_1220(S_HH,S_HV,S_VH,S_VV,0,1,f,window_size);
    [x_for_45_re,y_for_45_re,z_for_45_re,var_x_for_45_re,var_y_for_45_re,var_z_for_45_re]=calc_stokes_vector_1220(S_HH,S_HV,S_VH,S_VV,1/sqrt(2),1/sqrt(2),f,window_size);
    [x_back_45_re,y_back_45_re,z_back_45_re,var_x_back_45_re,var_y_back_45_re,var_z_back_45_re]=calc_stokes_vector_1220(S_HH,S_HV,S_VH,S_VV,-1/sqrt(2),1/sqrt(2),f,window_size);
    [x_left_45_re,y_left_45_re,z_left_45_re,var_x_left_45_re,var_y_left_45_re,var_z_left_45_re]=calc_stokes_vector_1220(S_HH,S_HV,S_VH,S_VV,1/sqrt(2),1i*1/sqrt(2),f,window_size);
    [x_right_45_re,y_right_45_re,z_right_45_re,var_x_right_45_re,var_y_right_45_re,var_z_right_45_re]=calc_stokes_vector_1220(S_HH,S_HV,S_VH,S_VV,1/sqrt(2),-1i*1/sqrt(2),f,window_size);


    %plot orderを行う
   
    [x_hori,y_hori,z_hori,plot_order_hori,hori1]=make_plot_order(x_hori_re,y_hori_re,z_hori_re,window_size);
    [var_x_hori, var_y_hori,var_z_hori,hori,hori]=make_plot_order(var_x_hori_re,var_y_hori_re,var_z_hori_re,window_size);

    [x_ver,y_ver,z_ver,plot_order_ver,ver]=make_plot_order(x_ver_re,y_ver_re,z_ver_re,window_size);
    [var_x_ver, var_y_ver,var_z_ver,ver,ver]=make_plot_order(var_x_ver_re,var_y_ver_re,var_z_ver_re,window_size);

    [x_for_45,y_for_45,z_for_45,plot_order_for_45,for_45]=make_plot_order(x_for_45_re,y_for_45_re,z_for_45_re,window_size);
    [var_x_for_45, var_y_for_45,var_z_for_45,for_45,for_45]=make_plot_order(var_x_for_45_re,var_y_for_45_re,var_z_for_45_re,window_size);

    [x_back_45,y_back_45,z_back_45,plot_order_back_45,back_45]=make_plot_order(x_back_45_re,y_back_45_re,z_back_45_re,window_size);
    [var_x_back_45, var_y_back_45,var_z_back_45,back_45,back_45]=make_plot_order(var_x_back_45_re,var_y_back_45_re,var_z_back_45_re,window_size);

    [x_left_45,y_left_45,z_left_45,plot_order_left_45,left_45]=make_plot_order(x_left_45_re,y_left_45_re,z_left_45_re,window_size);
    [var_x_left_45, var_y_left_45,var_z_left_45,left_45,left_45]=make_plot_order(var_x_left_45_re,var_y_left_45_re,var_z_left_45_re,window_size);
    
    [x_right_45,y_right_45,z_right_45,plot_order_right_45,right_45]=make_plot_order(x_right_45_re,y_right_45_re,z_right_45_re,window_size);
    [var_x_right_45, var_y_right_45,var_z_right_45,right_45,right_45]=make_plot_order(var_x_right_45_re,var_y_right_45_re,var_z_right_45_re,window_size);

    only_for_plot(hori1,f,"experimental plot",0.2,0.3,window_size);
    

    
    
%      scatter3(x_hori,y_hori,z_hori,12,"red","filled");
%        hold on
%     scatter3(x_ver,y_ver,z_ver,12,"blue","filled");
%     scatter3(x_for_45,y_for_45,z_for_45,12,"black","filled");
%     scatter3(x_back_45,y_back_45,z_back_45,12,"yellow","filled");
%     scatter3(x_left_45,y_left_45,z_left_45,12,"cyan","filled");   
%     scatter3(x_right_45,y_right_45,z_right_45,12,"magenta","filled");
%     legend("hori","ver","+45°","-45°","left","right");
%     xlabel("x");
%     ylabel("y");
%     zlabel("z");
%    title("data1218_0107_ver_new_all_plot");
%     sphere
%     colormap(parula);
%       hold off


    for i=1:6
        figure(i+1);
        if i==1
            scatter3(x_hori,y_hori,z_hori,12,plot_order_hori,"filled");
            title("hori");
        elseif i==2
            scatter3(x_ver,y_ver,z_ver,12,plot_order_ver,"filled");
            title("ver");
        elseif i==3
            scatter3(x_for_45,y_for_45,z_for_45,12,plot_order_for_45,"filled");
            title("+45");
        elseif i==4
            scatter3(x_back_45,y_back_45,z_back_45,12,plot_order_back_45,"filled");
            title("-45");
        elseif i==5
            scatter3(x_left_45,y_left_45,z_left_45,12,plot_order_left_45,"filled"); 
            title("left");
        elseif i==6
            scatter3(x_right_45,y_right_45,z_right_45,12,plot_order_right_45,"filled");
            title("right");
        end
      xlabel("x");
      ylabel("y");
      zlabel("z");
      colormap(cool); 
      hold on
      sphere
      colormap(parula);
      hold off
      end


%     for i=1:6
%         figure(i+7);
%         if i==1
%           scatter3(var_x_hori,var_y_hori,var_z_hori ,12,plot_order_hori,"filled");
%             title("hori");
%         elseif i==2
%             scatter3(var_x_ver , var_y_ver , var_z_ver ,12,plot_order_ver,"filled");
%             title("ver");
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