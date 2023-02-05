function  variance_data=make_variance_plot_order_based_on_scattring_matrix(window_size,scattering_matrix)

    size_changed_scattering_matrix= decide_window(data_size_change(scattering_matrix,window_size),window_size);
    size_x=size( size_changed_scattering_matrix,1)/window_size;
    size_y=size( size_changed_scattering_matrix,2)/window_size;
    size_z=size( size_changed_scattering_matrix,3);

    variance_data=zeros(size_x,size_y,size_z);

    for i=1:size(variance_data,1)
        for j=1:size(variance_data,2)
            tmp_data= size_changed_scattering_matrix(1+(i-1)*window_size:i*window_size,1+(j-1)*window_size:j*window_size,:);
            variance_data(i,j,:)=sqrt(var(tmp_data,0,[1 2]));
        end
    end
end