function h_ans=make_square_model(x_len,d_len,sampling_data)
assert(x_len>2&& d_len>2);
[x_point,d_point]=size(sampling_data);
assert(~mod(x_point,2)   && ~mod(d_point,2) && ~mod(x_len,2) && ~mod(d_len,2));
% for x=1+(x_len)/2:x_point-x_len/2
%     for d=1+(d_len/2:d_point-d_len/2



end











function h_ans=calculate_square_model(x_len,d_len,sampling_data)
    [x_point,d_point]=size(sampling_data);%点数取得
    h_ans=0;
    for x=1:x_point
        for d=1:d_point
            h_ans=h_ans +sampling_data(x,d);
        end
    end
    h_ans=h_ans/(x_point*d_point);

end