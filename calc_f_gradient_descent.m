function f=calc_f_gradient_descent(s,model,p)
    h=calc_h(s,model);
    f=sum(abs(h).^p,'all');
end