function h_ans=make_model_alongline(x_len,sampling_data)
    assert(x_len>2);
    [x_point,d_point]=size(sampling_data);
    assert(~mod(x_point,2)   && ~mod(d_point,2) && ~mod(x_len,4) );
    h_ans=zeros(x_point-x_len,1);
    for x=1:x_point-x_len
        [K_s,K_t]=calculate_vector_alongline(x_len,x,sampling_data);  
        c=norm(K_s);
        d=norm(K_t);
        aa=dot((K_s),K_t);%dot→複素数は自動でやってくれる
        inner_product=dot(K_s,K_t)/(norm(K_s)*norm(K_t));  
        h_tmp=(1-real(inner_product))/2;
        h_ans(x)=h_tmp;
    
    end
    
    
end    
    
    
    
    
    
    
    
    
    function [K_s,K_t]=calculate_vector_alongline(x_len,start_xindex,sampling_data)
        [x_point,d_point]=size(sampling_data);%点数取得
        K_s=sum(sampling_data(start_xindex+1/4*x_len:start_xindex+x_len*3/4-1,:),1);
        K_t_1=sum(sampling_data(start_xindex:start_xindex+x_len/4-1,:),1);
        K_t_2=sum(sampling_data(start_xindex+3/4*x_len:start_xindex+x_len-1,:),1);
        K_s=K_s/(x_len/2);
        K_t=(K_t_1+K_t_2)/(x_len/2);
        
    
    end