function scattering_co=interpolate_calculate(sampled_sq,index,Nfft,x_int,k)
disp('Data loading ...');
tic
    [x_point,d_point]=size(sampled_sq);
    scattering_co=zeros(x_point,d_point);
    for i=1:x_point
        if find(index==i)==false
            scattering_co(i, :) = sampled_sq(i, :);
        else
           
          

            for j = 1:d_point
                scattering_co(i, j) = calc_sacttering(sampled_sq, Nfft, x_int, index, i, j, k, d_point);
            end
        end 
    end


toc

end

function s = calc_sacttering(sampled_sq,Nfft, x_int, index, x_u, z_u,k,d_point)
    sum_s=0;
    sum_exp=0;
    for i=1:k
        for j=1:d_point
            tmp_exp = exp(-calculate_distance(Nfft, x_int, x_u, z_u, index(i), j).^2);
            sum_s=sum_s+sampled_sq(index(i),j)*tmp_exp;
            sum_exp=sum_exp+tmp_exp;
        end
    end
    s=sum_s/sum_exp;

end

function distance=calculate_distance(Nfft,x_int,x_u,z_u,x_v,z_v)
    dis_2=((x_u-x_v)*x_int).^2+((z_u-z_v)*Nfft).^2;
    distance=sqrt(dis_2);
end