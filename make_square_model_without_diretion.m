function [r,t,model]=make_square_model(r,t)
    model=zeros((r+t)+1,(r+t)+1);
    for x=1:(r+t)+1
        for y=1:(r+t)+1
            if t+1<=y && y<=r+1 && t+1<=x && x<=r+1
                model(x,y)=1;
            else
                model(x,y)=-1;
            end
        end

    end
    figure;imagesc(model);colormap(gray);