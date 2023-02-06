%散乱画像、ウィンドウサイズ、モデルサイズ
function [s_list,h_list,f_list]=atodekesu(S,model,p,alpha_size)
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
        for i=1:Nx
            for j=1:Ny   
                 for k=1:Nf
%                   S=s_list(:,:,:,loop);
%                   f=f_list(loop);
%                   h=h_list(:,:,loop);
                        tmp_K=S;
                        [tmp_f,~]=calc_h_and_f(tmp_K,model,p);
                        alpha=complex_random(alpha_size);
                        can_S=S;
                        can_S(i,j,k)=S(i,j,k)+alpha;
                        can_K=can_S;
                        [can_f,can_h]=calc_h_and_f(can_K,model,p);

                        if can_f<tmp_f
                            S(i,j,k)=can_S(i,j,k);
                            f=can_f;
                            h=can_h;      
                        end
                end
            end
        end
        f_list(loop+1)=f;
        h_list(:,:,loop+1)=h;
        s_list(:,:,:,loop+1)=S;
       
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