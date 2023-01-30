function  [x_ordered,y_ordered,z_ordered,plot_order,plot_order_array]=make_plot_order_based_on_scattring_matrix(x,y,z,window_size,scattering_matrix)

    size_changed_scattering_matrix= decide_window(data_size_change(scattering_matrix,window_size),window_size);

    % 振幅によって変化を見る
    MUL_COEFFICIENT=100;
    abs_matrix=abs(size_changed_scattering_matrix);
    c=max(abs_matrix,[],'all');
    plot_order_array= abs_matrix/max(abs_matrix,[],'all')*MUL_COEFFICIENT;

    %位相の変化を見る
%     plot_order_array=angle(size_changed_scattering_matrix);



    x_ordered=reshape(x,[],1);
    y_ordered=reshape(y,[],1);
    z_ordered=reshape(z,[],1);
    plot_order=reshape(plot_order_array,[],1);
end