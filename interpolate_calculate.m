function scattering_co=interpolate_calculate(sampled_sq,index,dl,x_int,k,a)
disp('Data loading ...');
tic
    [x_point,d_point]=size(sampled_sq);
    scattering_co=zeros(x_point,d_point);
    for i=1:x_point
        if find(index==i)==false
            scattering_co(i, :) = sampled_sq(i, :);
        else
           
          

            for j = 1:d_point
                scattering_co(i, j) = calc_scattering(sampled_sq, dl, x_int, index, i, j, k, d_point,a);
            end
        end 
    end


toc

end

function s = calc_scattering(sampled_sq,dl, x_int, index, x_u, z_u,k,d_point,a)
    sum_exp=0;
    sum_s_amp=0;
    sum_s_angle=0;
    for i=1:k
        for j=1:d_point
            tmp_exp = exp(-a*calculate_distance(dl, x_int, x_u, z_u, index(i), j).^2);
            sum_s_amp=sum_s_amp+abs(sampled_sq(index(i),j))*tmp_exp;
             sum_s_angle=sum_s_angle+sampled_sq(index(i),j)*tmp_exp;
            sum_exp=sum_exp+tmp_exp;
        end
    end
    sum_s=sum_s_amp*exp(1i*angle(sum_s_angle));
    s=sum_s/sum_exp;

end

function distance=calculate_distance(dl,x_int,x_u,z_u,x_v,z_v)
    dis_2=((x_u-x_v)*x_int).^2+((z_u-z_v)*dl).^2;
    distance=sqrt(dis_2);
end