% 圧縮センシング用のS_HH,HV,VH,VVを+計算する
% 今回はwindow_sizeを指定しない
function [S_HH_poincare_mul,S_HV_poincare_mul,S_VH_poincare_mul,S_VV_poincare_mul] = calc_stokes_vector_full_polarimetry_0130_semifinal(S_HH,S_HV,S_VH,S_VV)

    mul_value=0.6;
    HH_max=max(abs(S_HH) , [],'all');
    HV_max=max(abs(S_HV) , [],'all');
    VH_max=max(abs(S_VH) , [],'all');
    VV_max=max(abs(S_VV) , [],'all');

    S_HH=calc_mul_value(S_HH);
    S_HV=calc_mul_value(S_HV);
    S_VH=calc_mul_value(S_VH);
    S_VV=calc_mul_value(S_VV);


    [g0_10,g1_10,~,~] = calc_stokes_vector_full_polarimetry(S_HH,S_HV,S_VH,S_VV,1,0);
    [g0_01,g1_01,~,~] = calc_stokes_vector_full_polarimetry(S_HH,S_HV,S_VH,S_VV,0,1);

    g1g0_10=g1_10./g0_10;
    g1g0_01=g1_01./g0_01;


    S_HH_poincare_mul=abs(S_HH).*g1g0_10;
    S_HV_poincare_mul=abs(S_HV).*g1g0_01;
    S_VH_poincare_mul=abs(S_VH).*g1g0_10;
    S_VV_poincare_mul=abs(S_VV).*g1g0_01;
end


function S=calc_mul_value(S)
    x_size=size(S,1);
    y_size=size(S,2);
    z_size=size(S,3);
    S_max=max(abs(S),[],'all');
    turning_point1=0.5;
    turning_point2=0.7;
    mul_value1=0.2;
    mul_value2=1.8;

    for i=1:x_size
        for j=1:y_size
            for k=1:z_size
%                 S(i,j,k)
                if abs(S(i,j,k))<= S_max*turning_point1
                    S(i,j,k)=mul_value1*S(i,j,k);
                elseif S_max*turning_point1<= abs(S(i,j,k)) && abs(S(i,j,k))<= S_max*turning_point2
                    S(i,j,k)=S(i,j,k);
                elseif S_max*turning_point2< abs(S(i,j,k))
                    S(i,j,k)=mul_value2*S(i,j,k);
                end
            end 
        end 
    end


end