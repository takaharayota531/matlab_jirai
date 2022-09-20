function show_volume_angle(v,x,y,z,cmap,dataname)

    length = size(v);
    v = permute(v,[2 1 3]);
    
    fig = uifigure('Position',[500 100 560 700]);%figureの大きさ
    axes = uiaxes(fig,'Position',[20 200 520 470]);%直行座標軸自体の大きさ
    pnl = uipanel(fig,'Position',[0 0 560 200]);%手動パネルのUIとしての大きさ
    %スライダーの位置を調整している
    sldx = uislider(pnl,...
        'Position',[25 150 500 3]);
    sldy = uislider(pnl,...
        'Position',[25 100 500 3]);
    sldz = uislider(pnl,...
        'Position',[25 50 500 3]);
    sldx.ValueChangingFcn = @(sldx,event) sliderMovingForAngle(event,sldy,sldz,v,axes,x,y,z);
    sldy.ValueChangingFcn = @(sldy,event) sliderMovingForAngle(sldx,event,sldz,v,axes,x,y,z);
    sldz.ValueChangingFcn = @(sldz,event) sliderMovingForAngle(sldx,sldy,event,v,axes,x,y,z);
    h = slice(axes,x,y,z,v,x(end),y(end),z(end));
    set(h,'edgecolor','none');
    colormap(axes,cmap);
    colorbar(axes);
    %caxis(axes,[min(v,[],'all') max(v,[],'all')]);
    coValue=10;
    minValue=min(v,[],'all');
    maxValue=max(v,[],'all')/coValue;
  
    %caxis(axes,[maxValue max(v,[],'all')]);
    caxis(axes,[min(v,[],'all') max(v,[],'all')]);
    axes.XLim = [min(x) max(x)];
    axes.YLim = [min(y) max(y)];
    axes.ZLim = [min(z) max(z)];
    axes.YDir='reverse';
    axes.ZDir = 'reverse';
    sldx.Limits = [min(x) max(x)];
    sldy.Limits = [min(y) max(y)];
    sldz.Limits = [min(z) max(z)];
    sldx.Value = max(x);
    sldy.Value = max(y);
    sldz.Value = max(z);
    
    
    
    xlabel(axes,'$x$');
    ylabel(axes,'$y$');
    zlabel(axes,'$z$');
    title(axes,horzcat(dataname,'_angle'));

    end
    
    function sliderMovingForAngle(sldx,sldy,sldz,v,axes,x,y,z)
        %coValue=10;
    h = slice(axes,x,y,z,v,sldx.Value,sldy.Value,sldz.Value,'nearest');
    set(h,'edgecolor','none');
    colorbar(axes);
    %caxis(axes,[max(v,[],'all')/coValue max(v,[],'all')]);
    end
    