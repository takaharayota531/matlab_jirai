
function f=calc_f(s,model,p,E_iH,E_iV,FREQ_POINT,WHEN,lambda)
    [K,s]=create_feature_vector_full_polarimetry(s,E_iH,E_iV,FREQ_POINT,false,WHEN,lambda);
    h=calc_h(K,model);
    f=sum(abs(h).^p,'all');
end