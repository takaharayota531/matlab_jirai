%散乱画像、ウィンドウサイズ、モデルサイズ
function [s_list,h_list,f_list]=atodekesu_hill_climbing(S,model,p,alpha_size)
    K=S;
    h=calc_h(K,model);
    loop_num=10;
    s_zsize=size(S,3);
    [Nx,Ny,Nf]=size(K);
    f_list=zeros(loop_num+1);
    h_list=zeros(Nx,Ny,loop_num+1);
    s_list=zeros(Nx,Ny,s_zsize,loop_num+1);
    s_list(:,:,:,1) = S;
    h_list(:,:,1) = h;
    f=calc_h_and_f(K,model,p);
   
    f_list(1)=f;
%     alpha_list = zeros(0,0);
%     df_list = zeros(Nx,Ny,FREQ_POINT*4,2,0);
  
    
   
    
   for loop=1:loop_num
  
%         parfor k=1:Nf
        
%               S=s_list(:,:,:,loop);
%               f=f_list(loop);
%               h=h_list(:,:,loop);
        tmp_S=s_list(:,:,:,loop);
        for i=1:Nx
            for j=1:Ny   
                tmp_K=tmp_S;
                [tmp_f,~]=calc_h_and_f(tmp_K,model,p);
                target_S=tmp_S;
                target_f=tmp_f;
                parfor k=1:Nf
                        alpha=complex_random(alpha_size);
                        can_S=target_S;
                        can_S(i,j,k)=target_S(i,j,k)+alpha;
                        can_K=can_S;
                        [can_f,~]=calc_h_and_f(can_K,model,p);

                        if can_f<target_f
                            tmp_S(i,j,k)=can_S(i,j,k);
                        
                        end
                end
                
            end
        end
        tmp_K=tmp_S;
        [tmp_f,tmp_h]=calc_h_and_f(tmp_K,model,p);   
        f_list(loop+1)=tmp_f;
        h_list(:,:,loop+1)=tmp_h;
        s_list(:,:,:,loop+1)=tmp_S;
       
    end



end

function complex_random=complex_random(alpha_size)
    a = -alpha_size;
    b = alpha_size;
    re = (b-a).*rand(1,1) + a;
    im = (b-a).*rand(1,1) + a;
    complex_random=re+1i*im;
end



function [f,h]=calc_h_and_f(K,model,p)
    h=calc_h(K,model);
   
    f=(sum(abs(h).^p,'all'));
end