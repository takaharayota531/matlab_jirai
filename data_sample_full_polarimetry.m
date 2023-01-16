function [s_HH,s_HV,s_VH,s_VV,hori_dop,ver_dop,add_45_dop,sub_45_dop,left_dop,right_dop,sample,sample_list] = ...
    data_sample_full_polarimetry(s_HH,s_HV,s_VH,s_VV,hori_dop,ver_dop,add_45_dop,sub_45_dop,left_dop,right_dop,ratio)
    [Nx,Ny] = size(s_HH,1,2);
    n =10%floor( Nx*Ny*ratio/100);
    sample_tmp = randsample(Nx*Ny,n);
    sample_tmp = sort(sample_tmp)';
    sample_list = [floor((sample_tmp-1)/Nx)+1;rem(sample_tmp-1,Nx*ones(1,n))+1];
    sample = zeros(Nx,Ny);
    i = 1;
    for x = 1:Nx
        for y = 1:Ny
            if i<=n && x==sample_list(1,i) && y==sample_list(2,i)
                sample(x,y) = 1;
                i = i+1;
            else
                s_HH(x,y,:) = 0;
                s_HV(x,y,:) = 0;
                s_VH(x,y,:) = 0;
                s_VV(x,y,:) = 0;

                hori_dop(x,y,:) = 0;
                ver_dop(x,y,:) = 0;
                add_45_dop(x,y,:) = 0;
                sub_45_dop(x,y,:) = 0;
                left_dop(x,y,:) = 0;
                right_dop(x,y,:) = 0;

            end
        end
    end
    