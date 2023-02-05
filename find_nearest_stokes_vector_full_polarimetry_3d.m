function  [ans_array_S_HH,ans_array_S_HV,ans_array_S_VH,ans_array_S_VV] = find_nearest_stokes_vector_full_polarimetry_3d(s,FREQ_POINT)
    hori_vec=[1 0 0];
    ver_vec=[-1 0 0];
    plus45_vec=[0 1 0];
    minus45_vec=[0 -1 0];

    
    mul_value=0.6;

    S_HH=s(:,:,1:FREQ_POINT);
    S_HV=s(:,:,FREQ_POINT+1:2*FREQ_POINT);
    S_VH=s(:,:,2*FREQ_POINT+1:3*FREQ_POINT);
    S_VV=s(:,:,3*FREQ_POINT+1:4*FREQ_POINT);


    [g0_10,g1_10,g2_10,g3_10] = calc_stokes_vector_full_polarimetry(S_HH,S_HV,S_VH,S_VV,1,0) ;
    [g0_01,g1_01,g2_01,g3_01] = calc_stokes_vector_full_polarimetry(S_HH,S_HV,S_VH,S_VV,0,1) ;

    HH_max=max(abs(S_HH) , [],'all');
    HV_max=max(abs(S_HV) , [],'all');
    VH_max=max(abs(S_VH) , [],'all');
    VV_max=max(abs(S_VV) , [],'all');

    d_HH=sum((mul_value*HH_max <= abs(S_HH)),'all');

    % S_HH_re=S_HH.*(mul_value*HH_max <= abs(S_HH));
    % S_HV_re=S_HV.*(mul_value*HV_max <= abs(S_HV));
    % S_VH_re=S_VH.*(mul_value*VH_max <= abs(S_VH));
    % S_VV_re=S_VH.*(mul_value*VV_max <= abs(S_VV));

    S_HH_re=(mul_value*HH_max <= abs(S_HH));
    S_HV_re=(mul_value*HV_max <= abs(S_HV));
    S_VH_re=(mul_value*VH_max <= abs(S_VH));
    S_VV_re=(mul_value*VV_max <= abs(S_VV));



    x_10=g1_10./g0_10;
    y_10=g2_10./g0_10;
    z_10=g3_10./g0_10;

    x_01=g1_01./g0_01;
    y_01=g2_01./g0_01;
    z_01=g3_01./g0_01;

    [ans_array_S_HH,ans_count_S_HH]=find_nearest_stokes_point_0120(x_10,y_10,z_10,S_HH_re);
    [ans_array_S_HV,ans_count_S_HV]=find_nearest_stokes_point_0120(x_01,y_01,z_01,S_HV_re);
    [ans_array_S_VH,ans_count_S_VH]=find_nearest_stokes_point_0120(x_10,y_10,z_10,S_VH_re);
    [ans_array_S_VV,ans_count_S_VV]=find_nearest_stokes_point_0120(x_01,y_01,z_01,S_VV_re);


%     x=reshape(x_10.*S_HH_re,[],1);
%     y=reshape(y_10.*S_HH_re,[],1);
%     z=reshape(z_10.*S_HH_re,[],1);
%   x=reshape(x_01.*S_VV_re,[],1);
%     y=reshape(y_01.*S_VV_re,[],1);
%     z=reshape(z_01.*S_VV_re,[],1);
      x=reshape(x_10.*S_VH_re,[],1);
    y=reshape(y_10.*S_VH_re,[],1);
    z=reshape(z_10.*S_VH_re,[],1);


%     scatter3(x,y,z,12 ,'filled');
%     title(horzcat("","")); 
% %     view(fai,theta);
%     xlabel("x");
%     ylabel("y");
%     zlabel("z");
%     colormap(cool); 
%     hold on
%     sphere
%     colormap(parula);
%     %   colormap(hsv);
%     hold off








end


function [ans_array,ans_count]=find_nearest_stokes_point_0120(x,y,z,s)
    hori_vec=[1 0 0];
    ver_vec=[-1 0 0];
    plus45_vec=[0 1 0];
    minus45_vec=[0 -1 0];
    ans_array=zeros(size(s));
    ans_count=zeros(4,1);

  

    
    hori_array=(x-hori_vec(1)).*(x-hori_vec(1))+(y-hori_vec(2)).*(y-hori_vec(2))+(z-hori_vec(3)).*(z-hori_vec(3));
    ver_array=(x-ver_vec(1)).*(x-ver_vec(1))+(y-ver_vec(2)).*(y-ver_vec(2))+(z-ver_vec(3)).*(z-ver_vec(3));
    plus45_array=(x-plus45_vec(1)).*(x-plus45_vec(1))+(y-plus45_vec(2)).*(y-plus45_vec(2))+(z-plus45_vec(3)).*(z-plus45_vec(3));
    minus45_array=(x-minus45_vec(1)).*(x-minus45_vec(1))+(y-minus45_vec(2)).*(y-minus45_vec(2))+(z-minus45_vec(3)).*(z-minus45_vec(3));
    % left_array=(x-left_vec(1)).*(x-left_vec(1))+(y-left_vec(2)).*(y-left_vec(2))+(z-left_vec(3)).*(z-left_vec(3));
    % right_array=(x-right_vec(1)).*(x-right_vec(1))+(y-right_vec(2)).*(y-right_vec(2))+(z-right_vec(3)).*(z-right_vec(3));
    
    x_size=size(hori_array,1);
    y_size=size(hori_array,2);
    z_size=size(hori_array,3);
    
    for i=1:x_size
        for j=1:y_size
            for k=1:z_size
                if s(i,j,k)~=0
                   
                        [M,I] = min([ hori_array(i,j,k) ver_array(i,j,k)   plus45_array(i,j,k)   minus45_array(i,j,k) ]);
                        ans_array(i,j,k)=I+1;
                        ans_count(I)=ans_count(I)+1;
                   
                end
            end
        end
    end

end