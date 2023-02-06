function [s,s_list,h_list,alpha_list,df_list,K_list,f_list]= ...
    gradient_descent_full_polarimetry(s,model,p,FREQ_POINT,E_iH,E_iV,WHEN,lambda,c)%散乱画像、ウィンドウサイズ、モデルサイズ
    %s:補間後の散乱画像
    %sample:測定位置の値を1としている
    %model:モデル
    %p:評価関数のノルム
    %his:historyの略

%     Ns=sum(sample(:,:,1),'all');%取り出したデータの数
    

    % S_h=calc_h(s(1:4*FREQ_POINT),model);%TODO ここ最初からその他の情報を含むことができていない
    % データの比率を一緒にしている
    % TODO ここは後で変更するようにしておく
   


    [K,s]=create_feature_vector_full_polarimetry(s,E_iH,E_iV,FREQ_POINT,false,WHEN,lambda);

    h=calc_h(K,model);

    [Nx,Ny,K_Nf]=size(K);
    [~,~,Nf]=size(s);
    loop_num=3;
    K_list=zeros(Nx,Ny,K_Nf,loop_num*4+1);
    h_list=zeros(Nx,Ny,loop_num*4+1);
    s_list=zeros(Nx,Ny,Nf,loop_num*4+1);
    alpha_list = zeros(loop_num*4,1);
    f_list=zeros(loop_num*4,1);
   
    s_list(:,:,:,1) = s;
    h_list(:,:,1)  = h;
    K_list(:,:,:,1)=K;
   
    
    
    df_list = zeros(Nx,Ny,FREQ_POINT*4,2,4*loop_num);

   for loop=1:loop_num

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
        if WHEN=="0116"
            df=calc_df_full_polarimetry_0116(K,h,model,p,DIFF_BY,E_iH,E_iV,FREQ_POINT);
        elseif WHEN=="0121"
            df=calc_df_full_polarimetry_0121(K,h,model,p,DIFF_BY,E_iH,E_iV,FREQ_POINT);
%         elseif WHEN=="0124" || WHEN=="0130"
%             df=calc_df_full_polarimetry_0124_semifinal(K,h,model,p,DIFF_BY,FREQ_POINT);
             elseif WHEN=="0125" 
            df=calc_df_full_polarimetry_0124_semifinal_change(K,h,model,p,DIFF_BY,FREQ_POINT);
        end
        looping_num=(loop-1)*4+POLARIMETRY_COUNT;
        d=-2*squeeze(df(:,:,:,2));
        [alpha,f]=armijo_full_polarimetry(d,df,s_list(:,:,:,looping_num),model,p,E_iH,E_iV,FREQ_POINT,WHEN,lambda,c);
        f_list(looping_num)=f;
        s=s+alpha*d;
        [K,~]=create_feature_vector_full_polarimetry(s,E_iH,E_iV,FREQ_POINT,false,WHEN,lambda);
        alpha_list(looping_num)=alpha;
        s_list(:,:,:,looping_num+1)=s;
        K_list(:,:,:,looping_num+1)=K;
        h=calc_h(K,model);

      
         df_list(:,:,:,:,looping_num)=df;
        h_list(:,:,looping_num+1)=h;
        end
    end



end



