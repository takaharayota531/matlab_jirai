function [s,s_list,h_list,alpha_list,df_list]= ...
    gradient_descent_full_polarimetry(s,sample,model,p,FREQ_POINT,Z_NUM)%散乱画像、ウィンドウサイズ、モデルサイズ
    %s:補間後の散乱画像
    %sample:測定位置の値を1としている
    %model:モデル
    %p:評価関数のノルム
    %his:historyの略

    Ns=sum(sample(:,:,1),'all');%取り出したデータの数
    m=size(model,1);

    % S_h=calc_h(s(1:4*FREQ_POINT),model);%TODO ここ最初からその他の情報を含むことができていない
    % データの比率を一緒にしている
    S_HH=s(:,:,1:FREQ_POINT);
    S_HV=s(:,:,FREQ_POINT+1:2*FREQ_POINT);
    S_VH=s(:,:,2*FREQ_POINT+1:3*FREQ_POINT);
    S_VV=s(:,:,3*FREQ_POINT+1:4*FREQ_POINT);
    [g0,g1,g2,g3] = calc_stokes_vector_full_polarimetry(S_HH,S_HV,S_VH,S_VV,1,0) ;
    % added_poincare_vector1=cat(3, g1./g0, g1./g0, g1./g0, g1./g0)/4;
    % added_poincare_vector2=cat(3, g2./g0, g2./g0, g2./g0, g2./g0)/4;
    % added_poincare_vector3=cat(3, g3./g0, g3./g0, g3./g0, g3./g0)/4;

    % s=cat(3,s,added_poincare_vector1,added_poincare_vector2,added_poincare_vector3);
    s=cat(3,s,g1./g0, g2./g0, g3./g0);



    h=calc_h(s,model);

    [Nx,Ny,Nf]=size(s);
    s_list = s;
    h_list = h;
    alpha_list = zeros(0,0);
    df_list = zeros(Nx,Ny,Nf,2,0);



    % 結合テスト
    % まず更新なしで試してみる
    i=0

    while(i<10)
        df=calc_df(s(:,:,1:4*FREQ_POINT),h,model,p);
        d=-2*squeeze(df(:,:,:,2));

        df_full_polarimetry=calc_df_full_polarimetry(s,h,model,p,FREQ_POINT);
        d_full_polarimetry=-2*squeeze(df_full_polarimetry(:,:,:,2));

        added_d=cat(3,d,d_full_polarimetry);
        added_df=cat(3,df,df_full_polarimetry);

        % alpha=armijo(d,df,s_list(:,:,:,end),model,p);
        alpha=armijo(added_d,added_df,s_list(:,:,:,end),model,p);


        % s=s+alpha*d;
        s=s+alpha*added_d;
        h=calc_h(s,model);

        alpha_list(end+1)=alpha;
        % df_list(:,:,:,:,end+1)=df;
        df_list(:,:,:,:,end+1)=added_df;
        s_list(:,:,:,end+1)=s;
        h_list(:,:,end+1)=h;

        if alpha<1e-6
            break;
        end
        i=i+1;
    end



end