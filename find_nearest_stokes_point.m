function ans_array=find_nearest_stokes_point(x,y,z)
    hori_vec=[1 0 0];
    ver_vec=[-1 0 0];
    plus45_vec=[0 1 0];
    minus45_vec=[0 -1 0];

   ans_array=zeros(4);
    
    hori_array=(x-hori_vec(1)).*(x-hori_vec(1))+(y-hori_vec(2)).*(y-hori_vec(2))+(z-hori_vec(3)).*(z-hori_vec(3));
    ver_array=(x-ver_vec(1)).*(x-ver_vec(1))+(y-ver_vec(2)).*(y-ver_vec(2))+(z-ver_vec(3)).*(z-ver_vec(3));
    plus45_array=(x-plus45_vec(1)).*(x-plus45_vec(1))+(y-plus45_vec(2)).*(y-plus45_vec(2))+(z-plus45_vec(3)).*(z-plus45_vec(3));
    minus45_array=(x-minus45_vec(1)).*(x-minus45_vec(1))+(y-minus45_vec(2)).*(y-minus45_vec(2))+(z-minus45_vec(3)).*(z-minus45_vec(3));
    
    x_size=size(hori_array,1);
    y_size=size(hori_array,2);
    z_size=size(hori_array,3);
    
    for i=1:x_size
        for j=1:y_size
            for k=1:z_size
                [M,I] = min([ hori_array(i,j,k) ver_array(i,j,k)   plus45_array(i,j,k)   minus45_array(i,j,k)]);
                ans_array(I)=ans_array(I)+1;
            end
        end
    end
end