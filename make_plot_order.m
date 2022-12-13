function [x,y,z,plot_order,plot_order_array]=make_plot_order(g0,g1,g2,g3)
   
    x_size=size(g0,1);
    y_size=size(g0,2);
    z_size=size(g0,3);
    plot_order_array=zeros(x_size,y_size,z_size);
    tmp_index=1;
    size_length=size(g0,1);

    % pipe_width=7;
    % pipe_start_width=7;
    % tmp_index=1;
    % for j=1:y_size
    %     for i=1:x_size
    %             if 1<=pipe_start_width-j+1
    %             plot_order_array(i,pipe_start_width-j+1,:)=tmp_index;
    %             tmp_index=tmp_index+1;
    %             end
    %             if j~=1 && (pipe_start_width+j-1<=y_size)
    %                 plot_order_array(i,pipe_start_width+j-1,:)=tmp_index;
    %                 tmp_index=tmp_index+1;
    %             end
            
    %     end
    % end

%window_size=5
% for j=1:y_size
%     for i=1:x_size
%         if j==2 && (5<=i && i<=9)
%             plot_order_array(i,j,:)=1;
%         end
%     end
% end


%window_size=7
for j=1:y_size
    for i=1:x_size
        if j==2 && (3<=i && i<=9)
            plot_order_array(i,j,:)=1;
        end
    end
end

    
%  for i=1:size(g0,1)
%         for j=1:size(g0,2)
%             plot_order(size_length*(i-1)+j)=tmp_index;
%             tmp_index=tmp_index+1;
%         end
%     end
    x=reshape(g1./g0,[],1);
    y=reshape(g2./g0,[],1);
    z=reshape(g3./g0,[],1);
    plot_order=reshape(plot_order_array,[],1);

end
