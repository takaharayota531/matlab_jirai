function averaged_data=decide_window(data,window_size)
    after_changed_data = data;
    plus_size=0;
    while(true)
        if rem(size(data,1)+plus_size,window_size)~=0
            plus_size=plus_size+1;
            after_changed_data(end+1,end+1,:)=after_changed_data(end,end,:);
            after_changed_data(end,1:end,:)=after_changed_data(end-1,1:end,:);
            after_changed_data(1:end,end,:)=after_changed_data(1:end,end-1,:);    
        else
            break;
        end
    end


    averaged_data_size=size(after_changed_data,1)/window_size;
    averaged_data=zeros(averaged_data_size,averaged_data_size,size(after_changed_data,3));

    for i=1:size(averaged_data,1)
        for j=1:size(averaged_data,2)
            tmp_data=after_changed_data(1+(i-1)*window_size:i*window_size,1+(j-1)*window_size:j*window_size,:);
            averaged_data(i,j,:)=mean(tmp_data,[1 2]);
        end
    end

end