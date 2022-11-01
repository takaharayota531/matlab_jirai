%再急降下法
%sのノルムが一定になるように最適化

function [s,s_list,h_list,alpha_list,df_list]=gradient_descent_takahara(s,sample,model,p)%散乱画像、ウィンドウサイズ、モデルサイズ
    %s:補間後の散乱画像
    %sample:測定位置の値を1としている
    %model:モデル
    %p:評価関数のノルム
    %his:historyの略
    Ns=sum(sample(:,:,1),'all');%取り出したデータの数
    m=size(model,1);

    h=calc_h_takahara(s,model);

    [Nx,Ny,Nf]=size(s);
    s_list = s;
    h_list = h;
    alpha_list = zeros(0,0);
    df_list = zeros(Nx,Ny,Nf,2,0);

    i=0

    while(i<10)
        df=calc_df_takahara(s,h,model,p);
        d=-2*squeeze(df(:,:,:,2));

        alpha=armijo(d,df,s_list(:,:,:,end),model,p);

        s=s+alpha*d;
        h=calc_h_takahara(s,model);

        alpha_list(end+1)=alpha;
        df_list(:,:,:,:,end+1)=df;
        s_list(:,:,:,end+1)=s;
        h_list(:,:,end+1)=h;

        if alpha<1e-6
            break;
        end
        i=i+1;
    end
end