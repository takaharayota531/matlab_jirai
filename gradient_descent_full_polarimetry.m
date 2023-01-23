function [s,s_list,h_list,alpha_list,df_list,K_list]= ...
    gradient_descent_full_polarimetry(s,model,p,FREQ_POINT,Z_NUM,E_iH,E_iV)%散乱画像、ウィンドウサイズ、モデルサイズ
    %s:補間後の散乱画像
    %sample:測定位置の値を1としている
    %model:モデル
    %p:評価関数のノルム
    %his:historyの略

%     Ns=sum(sample(:,:,1),'all');%取り出したデータの数
    m=size(model,1);

    % S_h=calc_h(s(1:4*FREQ_POINT),model);%TODO ここ最初からその他の情報を含むことができていない
    % データの比率を一緒にしている
    % TODO ここは後で変更するようにしておく
   


    [K,s]=create_feature_vector_full_polarimetry(s,E_iH,E_iV,FREQ_POINT,true);

    h=calc_h(K,model);

    [Nx,Ny,Nf]=size(K);
    K_list=K;
    s_list = s;
    h_list = h;
    alpha_list = zeros(0,0);
    df_list = zeros(Nx,Ny,FREQ_POINT*4,2,0);



    % 結合テスト
    % まず更新なしで試してみる
    i=0

    while(i<10)

        for POLARIMETRY_COUNT=1:4
            if POLARIMETRY_COUNT==1
                DIFF_BY='DIFF_by_S_HH'
            elseif POLARIMETRY_COUNT==2
                DIFF_BY='DIFF_by_S_HV'
            elseif POLARIMETRY_COUNT==3
                DIFF_BY='DIFF_by_S_VH'
            elseif POLARIMETRY_COUNT==4
                DIFF_BY='DIFF_by_S_VV'
            end
        df=calc_df_full_polarimetry_0121(K,h,model,p,DIFF_BY,E_iH,E_iV,FREQ_POINT);
        d=-2*squeeze(df(:,:,:,2));
        alpha=armijo_full_polarimetry(d,df,s_list(:,:,:,end),model,p,E_iH,E_iV,FREQ_POINT);
        s=s+alpha*d;
        [K,s]=create_feature_vector_full_polarimetry(s,E_iH,E_iV,FREQ_POINT,true);
        alpha_list(end+1)=alpha;
        s_list(:,:,:,end+1)=s;
        K_list(:,:,:,end+1)=K;
        h=calc_h(K,model);

        % alpha_list(end+1)=alpha;
         df_list(:,:,:,:,end+1)=df;
        % s_list(:,:,:,end+1)=s;
        h_list(:,:,end+1)=h;
        end


        % ここでg1,g2,g3を更新しておく

        if alpha<1e-6
            break;
        end
        i=i+1;
    end



end

% while(i<10)
%     df=calc_df(K(:,:,1:4*FREQ_POINT),h,model,p);
%     d=-2*squeeze(df(:,:,:,2));

%     df_full_polarimetry=calc_df_full_polarimetry(K,h,model,p,FREQ_POINT);
%     d_full_polarimetry=-2*squeeze(df_full_polarimetry(:,:,:,2));

%     added_d=cat(3,d,d_full_polarimetry);
%     added_df=cat(3,df,df_full_polarimetry);

%     % alpha=armijo(d,df,s_list(:,:,:,end),model,p);
%     alpha=armijo(added_d,added_df,s_list(:,:,:,end),model,p);


%     % s=s+alpha*d;
%     s=s+alpha*added_d;
%     h=calc_h(K,model);

%     alpha_list(end+1)=alpha;
%     % df_list(:,:,:,:,end+1)=df;
%     df_list(:,:,:,:,end+1)=added_df;
%     s_list(:,:,:,end+1)=s;
%     h_list(:,:,end+1)=h;

%     if alpha<1e-6
%         break;
%     end
%     i=i+1;
% end