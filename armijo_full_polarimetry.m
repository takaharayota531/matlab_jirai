%アルミホの条件からステップ幅を計算
function alpha=armijo_full_polarimetry(d,df,s,model,p,E_iH,E_iV,FREQ_POINT,WHEN,lambda)
    alpha=100;
%     c=2/3;
    c=0.5;
    rho=0.5;
    df1=squeeze(df(:,:,:,1));
    df2=squeeze(df(:,:,:,2));
    f=calc_f(s,model,p,E_iH,E_iV,FREQ_POINT,WHEN,lambda);

    while 1
        tmp_s=s+alpha*d;
        fi=calc_f(s+alpha*d,model,p,E_iH,E_iV,FREQ_POINT,WHEN,lambda);
        fi2=f+(sum(df1.*d,'all')+sum(df2.*conj(d),'all'))*c*alpha;
        if fi<=fi2  || alpha<1e-6
            break;
        end
        alpha=alpha*rho;
    end
end



function f=calc_f(s,model,p,E_iH,E_iV,FREQ_POINT,WHEN,lambda)
    [K,s]=create_feature_vector_full_polarimetry(s,E_iH,E_iV,FREQ_POINT,false,WHEN,lambda);
    h=calc_h(K,model);
    f=sum(abs(h).^p,'all');
end