%再急降下法
%sのノルムが一定になるように最適化
%散乱画像、ウィンドウサイズ、モデルサイズ
function [s,s_list,h_list,alpha_list,df_list,f_list]=gradient_descent_parallel(s,model,p)
  
    K=s;
    h=calc_h(K,model);
    loop_num=10;
    s_zsize=size(s,3);
    [Nx,Ny,Nf]=size(K);
    f_list=zeros(loop_num,1);
    h_list=zeros(Nx,Ny,loop_num+1);
    s_list=zeros(Nx,Ny,s_zsize,loop_num+1);
    s_list(:,:,:,1) = s;
    h_list(:,:,1) = h;
  
   
   
    alpha_list=zeros(loop_num,1);
    df_list = zeros(Nx,Ny,Nf,2,loop_num);

    

   for loop=1:loop_num
        df=calc_df_parallel(s,h,model,p);
        d=-2*squeeze(df(:,:,:,2));

        [alpha,f]=armijo(d,df,s_list(:,:,:,loop),model,p);

        s=s+alpha*d;
        h=calc_h(s,model);

        alpha_list(loop)=alpha;
        df_list(:,:,:,:,loop+1)=df;
        s_list(:,:,:,loop+1)=s;
        h_list(:,:,loop+1)=h;
        f_list(loop)=f;

    end
end


function [f,h]=calc_h_and_f(K,model,p)
    h=calc_h(K,model);
   
    f=(sum(abs(h).^p,'all'));
end