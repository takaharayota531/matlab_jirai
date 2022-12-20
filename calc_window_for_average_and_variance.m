function [variance_data]=calc_window_for_average_and_variance(after_changed_data,window_size)
    size_x=size(after_changed_data,1)/window_size;
    size_y=size(after_changed_data,2)/window_size;
    size_z=size(after_changed_data,3);

    variance_data=zeros(size_x,size_y,size_z);

    for i=1:size(variance_data,1)
        for j=1:size(variance_data,2)
            tmp_data=after_changed_data(1+(i-1)*window_size:i*window_size,1+(j-1)*window_size:j*window_size,:);
            variance_data(i,j,:)=sqrt(var(tmp_data,0,[1 2]));
        end
    end

end