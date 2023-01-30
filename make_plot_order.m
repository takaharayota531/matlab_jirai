function [x_ordered,y_ordered,z_ordered,plot_order,plot_order_array]=make_plot_order(x,y,z,window_size,index_distance)
   
    x_size=size(x,1);
    y_size=size(x,2);
    z_size=size(x,3);
    plot_order_array=zeros(x_size,y_size,z_size);
    tmp_index=1;
    size_length=size(x,1);
    
%  plot_order_array=first_model(plot_order_array,window_size);
    % plot_order_array= permute (second_model(plot_order_array,window_size),[2 1 3]);
%     plot_order_array=permute(first_model(plot_order_array,window_size),[2 1 3]);
%     plot_order_array=second_model(plot_order_array,window_size);
%   plot_order_array=freq_order_array(plot_order_array,window_size);
% plot_order_array=permute( array_decide(plot_order_array,window_size),[2 1 3]);
% plot_order_array = array_decide(plot_order_array,window_size);
% plot_order_array=verticalmodel(plot_order_array,window_size,index_distance);
plot_order_array=verticalmodel_without_index_distance(plot_order_array,window_size);



    
%  for i=1:size(g0,1)
%         for j=1:size(g0,2)
%             plot_order(size_length*(i-1)+j)=tmp_index;
%             tmp_index=tmp_index+1;
%         end
%     end
    x_ordered=reshape(x,[],1);
    y_ordered=reshape(y,[],1);
    z_ordered=reshape(z,[],1);
    %plot_order_array=permute(plot_order_array,[2 1 3]);
    plot_order=reshape(plot_order_array,[],1);

end


function plot_order_array=verticalmodel_without_index_distance(plot_order_array,window_size)
    x_size=size(plot_order_array,1);
    y_size=size(plot_order_array,2);
    z_size=size(plot_order_array,3);


    if window_size==1
%         pipe_width=20;
        pipe_width=40;
        pipe_start_width=67;
%         tmp_index=30;
tmp_index=60;
        for j=0:pipe_width

                    if j==0
                        plot_order_array(:,pipe_start_width,:)=tmp_index;
                        % plot_order_array(:,pipe_start_width-j,:)=tmp_index;
                        
                    else 
                        if 1<=pipe_start_width-j
                        plot_order_array(:,pipe_start_width-j,:)=tmp_index;
                        end
                        if pipe_start_width+j<=y_size
                        plot_order_array(:,pipe_start_width+j,:)=tmp_index;
                        end
                    end
                    tmp_index=tmp_index-1;
                        
        end
    end


     if window_size==7
        pipe_width=5;
        pipe_start_width=8;
        tmp_index=10;
        for j=0:pipe_width

                    if j==0
                        plot_order_array(:,pipe_start_width,:)=tmp_index;
                        % plot_order_array(:,pipe_start_width-j,:)=tmp_index;
                        
                    else 
                        plot_order_array(:,pipe_start_width-j,:)=tmp_index;
                        plot_order_array(:,pipe_start_width+j,:)=tmp_index;
                    end
                    tmp_index=tmp_index-1;
                        
        end
    end

end


function plot_order_array=verticalmodel(plot_order_array,window_size,index_distance)
    x_size=size(plot_order_array,1);
    y_size=size(plot_order_array,2);
    z_size=size(plot_order_array,3);


    if window_size==1
        pipe_width=20;
        pipe_start_width=67;
        tmp_index=30;
        for j=0:pipe_width

                    if j==0
                        plot_order_array(:,pipe_start_width,index_distance)=tmp_index;
                        % plot_order_array(:,pipe_start_width-j,:)=tmp_index;
                        
                    else 
                        plot_order_array(:,pipe_start_width-j,index_distance)=tmp_index;
                        plot_order_array(:,pipe_start_width+j,index_distance)=tmp_index;
                    end
                    tmp_index=tmp_index-1;
                        
        end
    end


     if window_size==7
        pipe_width=5;
        pipe_start_width=8;
        tmp_index=10;
        for j=0:pipe_width

                    if j==0
                        plot_order_array(:,pipe_start_width,index_distance)=tmp_index;
                        % plot_order_array(:,pipe_start_width-j,:)=tmp_index;
                        
                    else 
                        plot_order_array(:,pipe_start_width-j,index_distance)=tmp_index;
                        plot_order_array(:,pipe_start_width+j,index_distance)=tmp_index;
                    end
                    tmp_index=tmp_index-1;
                        
        end
    end
end


function plot_order_array=  first_model(plot_order_array,window_size)
    x_size=size(plot_order_array,1);
    y_size=size(plot_order_array,2);
    z_size=size(plot_order_array,3);
    if window_size==5
        for j=1:y_size
            for i=1:x_size
                if j==2 && (5<=i && i<=9)
                    plot_order_array(i,j,:)=5;
                end
            end
        end
   end
   
    
   if  window_size==7
     for j=1:y_size
         for i=1:x_size
             if j==2 && (3<=i && i<=9)
                 plot_order_array(i,j,:)=5;
             end
         end
     end
   end
end


function plot_order_array= second_model(plot_order_array,window_size)
    x_size=size(plot_order_array,1);
    y_size=size(plot_order_array,2);
    z_size=size(plot_order_array,3);
    
    if window_size==1
        pipe_width=30;
        pipe_start_width=68;
        tmp_index=35;
        for j=1:1+pipe_width
            % for i=1:x_size
                    % if 1<=pipe_start_width-j+1
                    % plot_order_array(:,pipe_start_width-j+1,:)=tmp_index;
                    % tmp_index=tmp_index+1;
                    % end
                    % if j~=1 && (pipe_start_width+j-1<=y_size)
                    %     plot_order_array(:,pipe_start_width+j-1,:)=tmp_index;
                    %     tmp_index=tmp_index+1;
                    % end

                    if j==1
                        plot_order_array(:,pipe_start_width-j+1,:)=tmp_index;
                        plot_order_array(:,pipe_start_width-j,:)=tmp_index;
                        
                    else 
                        if 1<pipe_start_width-j
                        plot_order_array(:,pipe_start_width-j,:)=tmp_index;
                        end
                        if pipe_start_width+j-1<y_size
                        plot_order_array(:,pipe_start_width+j-1,:)=tmp_index;
                        end
                    end
                    tmp_index=tmp_index-1;
                        
                
            % end
        end
    end
        

    if window_size==5
        pipe_width=2;
        pipe_start_width=3;
        tmp_index=10;
        for j=0:pipe_width

                    if j==0
                        plot_order_array(:,pipe_start_width,:)=tmp_index;    
                    else 
                        plot_order_array(:,pipe_start_width-j,:)=tmp_index;
                        plot_order_array(:,pipe_start_width+j,:)=tmp_index;
                    end
                    tmp_index=tmp_index-1;
                                
        end

    end

    if window_size==7
        pipe_width=2;
        pipe_start_width=9;
        tmp_index=10;
        for j=1:1+pipe_width
            % for i=1:x_size
                    % if 1<=pipe_start_width-j+1
                    % plot_order_array(:,pipe_start_width-j+1,:)=tmp_index;
                    % tmp_index=tmp_index+1;
                    % end
                    % if j~=1 && (pipe_start_width+j-1<=y_size)
                    %     plot_order_array(:,pipe_start_width+j-1,:)=tmp_index;
                    %     tmp_index=tmp_index+1;
                    % end

                    if j==1
                        plot_order_array(:,pipe_start_width-j+1,:)=tmp_index;
                        plot_order_array(:,pipe_start_width-j,:)=tmp_index;
                        
                    else 
                        plot_order_array(:,pipe_start_width-j,:)=tmp_index;
                        plot_order_array(:,pipe_start_width+j-1,:)=tmp_index;
                    end
                    tmp_index=tmp_index-1;
                        
                
            % end
        end
    end

end

function plot_order_array=array_decide(plot_order_array,window_size)
    tmp_index=0;
    y_size=size(plot_order_array,2);

    for j=1:y_size
        plot_order_array(:,j,:)=tmp_index;
        tmp_index=tmp_index+1;
    
    end

end

function plot_order_array=freq_order_array(plot_order_array,window_size)
    z_size=size(plot_order_array,3);
    tmp_index=0;
    for i=1:z_size
        plot_order_array(:,:,i)=tmp_index;
        tmp_index=tmp_index+1;
    end
end