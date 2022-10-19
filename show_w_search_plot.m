function show_w_search_plot(model_result,w,fig)
    figure(fig);
    [x_size,d_size]=size(w);
    search_result=zeros(x_size,d_size);
    for i = 1:size(model_result)
        search_result(i,:)=model_result(i);
    end

 
    data_result_max = max(search_result,[],'all');
    data_result_min = min(search_result,[],'all');

    data_max = max(abs(w),[],'all');
    data_min = min(abs(w),[],'all');
    
    row = 1; % subplot行数
    col = 2; % subplot列数
    
    figure_size = [ 0, 200, 1000, 1000/col*1.2*row];
    set(fig, 'Position', figure_size);
    ax=subplot(1,3,1);
    result=imagesc(search_result,[data_result_min data_result_max]);
    colormap(ax,flipud(gray));
    colorbar(ax);
set(result, 'AlphaData',0.8);

    ax1 = subplot(1,3,2);
   


    imagesc(abs(w),[data_min data_max]);
            colormap(ax1,parula(4096));
            colorbar(ax1);
   
   

    hold off;
    ax2 = subplot(1,3,3);
    imagesc(angle(w),[-pi pi]);
            colormap(ax2,hsv(4096));
            colorbar(ax2);
    