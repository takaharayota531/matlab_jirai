function model=make_square_model_re(r,t)
    assert(~mod(t,2))
    model=zeros(2*r,2*t);
    for x=1:2*r
        for y=1:2*t
            if t/2+1<=y && y<=3/2*t
                model(x,y)=1
            else
                model(x,y)=-1
            end
        end

    end
    figure;imagesc(model);colormap(gray);