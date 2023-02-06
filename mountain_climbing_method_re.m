%散乱画像、ウィンドウサイズ、モデルサイズ
function [s_list,h_list,f_list,K_list]=mountain_climbing_method_re(S,model,p,alpha_size)
    K=S;
    h=calc_h(K,model);
    FREQ_POINT=size(S,3)/4;
    [Nx,Ny,Nf]=size(K);
    K_list=K;
    s_list = S;
    h_list = h;
    f=calc_h_and_f(K,model,p);
    f_list=f;
%     alpha_list = zeros(0,0);
%     df_list = zeros(Nx,Ny,FREQ_POINT*4,2,0);
    NUM=4;
    
    loop_num=5;
    loop=0;
    while(loop<loop_num)
      printing=  "順番変更済み"
        % for z=0:NUM-1
        %     for i=1:Nx
        %         for j=1:Ny
        %             for k=1:FREQ_POINT
        %                 tmp_K=S;
        %                 [tmp_f,~]=calc_h_and_f(tmp_K,model,p);
        %                 alpha=complex_random(alpha_size);
        %                 can_S=S;
        %                 can_S(i,j,k+FREQ_POINT*z)=S(i,j,k+FREQ_POINT*z)+alpha;
        %                 can_K=can_S;
        %                 [can_f,can_h]=calc_h_and_f(can_K,model,p);

        %                 if can_f<tmp_f
        %                     S(i,j,k+FREQ_POINT*z)=can_S(i,j,k+FREQ_POINT*z);
        %                     f=can_f;
        %                     h=can_h;
        %                 end
        %             end
        %         end
        %     end
        % end
        for k=1:Nf
            for i=1:Nx
                for j=1:Ny   
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
        f_list(end+1)=f;
        h_list(:,:,end+1)=h;
        s_list(:,:,:,end+1)=S;
        loop=loop+1;

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
    aa=(sum(abs(h).^p,'all'));
%     f=(sum(abs(h).^p,'all'))^(1/p);
 f=(sum(abs(h).^p,'all'));
end