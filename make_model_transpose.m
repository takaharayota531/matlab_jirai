function [r,t,model]=make_square_model(r,t,model)
  
    model=model.';
  
    figure;imagesc(model);colormap(gray);