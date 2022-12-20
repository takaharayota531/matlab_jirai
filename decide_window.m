function averaged_data=decide_window(after_changed_data,window_size)
    averaged_data_size_x=size(after_changed_data,1)/window_size;
    averaged_data_size_y=size(after_changed_data,2)/window_size;
    averaged_data_size_z=size(after_changed_data,3);

    averaged_data=zeros(averaged_data_size_x,averaged_data_size_y,averaged_data_size_z);

    for i=1:size(averaged_data,1)
        for j=1:size(averaged_data,2)
            tmp_data=after_changed_data(1+(i-1)*window_size:i*window_size,1+(j-1)*window_size:j*window_size,:);
            averaged_data(i,j,:)=mean(tmp_data,[1 2]);
        end
    end

end