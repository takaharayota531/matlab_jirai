function [r,t,model]=make_square_model_pipe(r,t)
   % assert(~mod(t,2))
    model=zeros(2*(r+t)+1,2*(r+t)+1);
    for x=1:2*(r+t)+1
        for y=1:2*(r+t)+1
            if (t/2+1<=y && y<=1+t+t/2)||(2*r+t*1/2+1<=y && y<=2*r+3/2*t+1)
                model(x,y)=1/2;
            elseif t+t/2+1<=y && y<=2*r+t/2+1
                model(x,y)=1;
            else 
                model(x,y)=-1;
            end
        end

    end


    figure;imagesc(model);colormap(gray);
