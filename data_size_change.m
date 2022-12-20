function after_changed_data=data_size_change(data,window_size)
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

end