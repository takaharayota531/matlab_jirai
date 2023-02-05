%散乱画像、ウィンドウサイズ、モデルサイズ
function [s_list,h_list,alpha_list,df_list,f_list]=mountain_climbing_method(s,model,p)
    K=s;
    h=calc_h(K,model);
    FREQ_POINT=size(s,3)/4;
    [Nx,Ny,Nf]=size(K);
    K_list=K;
    s_list = s;
    h_list = h;
    f_list=calc_h_and_f(K,model,p);
    alpha_list = zeros(0,0);
    df_list = zeros(Nx,Ny,FREQ_POINT*4,2,0);


    loop_num=20;
    loop=0;
    while(loop<loop_num)
        alpha=100;
        count=0;
        while(1)
            alpha=alpha*(1/2)^count;
            % todo ここ変更
            K=s_list(:,:,:,end);
            
            tmp_f=calc_h_and_f(K,model,p);

            [hh_p_direction,tmp_S1]=update_K_and_calc_f(s_list(:,:,:,end),alpha,"S_HH",FREQ_POINT,"PLUS",p,model);
            [hh_m_direction,tmp_S2]=update_K_and_calc_f(s_list(:,:,:,end),alpha,"S_HH",FREQ_POINT,"MINUS",p,model);
            [hv_p_direction,tmp_S3]=update_K_and_calc_f(s_list(:,:,:,end),alpha,"S_HV",FREQ_POINT,"PLUS",p,model);
            [hv_m_direction,tmp_S4]=update_K_and_calc_f(s_list(:,:,:,end),alpha,"S_HV",FREQ_POINT,"MINUS",p,model);
            [vh_p_direction,tmp_S5]=update_K_and_calc_f(s_list(:,:,:,end),alpha,"S_VH",FREQ_POINT,"PLUS",p,model);
            [vh_m_direction,tmp_S6]=update_K_and_calc_f(s_list(:,:,:,end),alpha,"S_VH",FREQ_POINT,"MINUS",p,model);
            [vv_p_direction,tmp_S7]=update_K_and_calc_f(s_list(:,:,:,end),alpha,"S_VV",FREQ_POINT,"PLUS",p,model);
            [vv_m_direction,tmp_S8]=update_K_and_calc_f(s_list(:,:,:,end),alpha,"S_VV",FREQ_POINT,"MINUS",p,model);

            [M,I]=min([hh_p_direction hh_m_direction hv_p_direction hv_m_direction vh_p_direction vh_m_direction vv_p_direction vv_m_direction]);
       switch I
           case 1
               tmp_S=tmp_S1
           case 2
           tmp_S=tmp_S2
           case 3
               tmp_S=tmp_S3
           case 4
               tmp_S=tmp_S4
           case 5
               tmp_S=tmp_S5
           case 6
               tmp_S=tmp_S6
            case 7
               tmp_S=tmp_S7 
            case 8
               tmp_S=tmp_S8
       end
        
            if M<tmp_f
                alpha_list(1,1,end+1)=I;
                alpha_list(1,2,end)=alpha;
                s_list(:,:,:,end+1)=tmp_S;
                f_list(end+1)=M;
                K=tmp_S;
                h=calc_h(K,model);
                h_list(:,:,end+1)=h;
                break;
            end

            if alpha<1e-7 || 10<=count
                break;
            end
            count=count+1;
        end

       
       

      
        loop=loop+1;
    end

end

function [ans,tmp_S]=update_K_and_calc_f(S,alpha,BY,FREQ_POINT,PLUS_OR_MINUS,p,model)
    S_HH=S(:,:,1:FREQ_POINT);
    S_HV=S(:,:,FREQ_POINT+1:2*FREQ_POINT);
    S_VH=S(:,:,2*FREQ_POINT+1:3*FREQ_POINT);
    S_VV=S(:,:,3*FREQ_POINT+1:4*FREQ_POINT);

    tmp_S=S;
    if PLUS_OR_MINUS=='MINUS'
        alpha=-alpha
    end
    if BY=="S_HH"
        tmp_S(:,:,1:FREQ_POINT)=tmp_S(:,:,1:FREQ_POINT)+alpha;
    elseif BY=="S_HV"
        tmp_S(:,:,FREQ_POINT+1:2*FREQ_POINT)=tmp_S(:,:,FREQ_POINT+1:2*FREQ_POINT)+alpha;
    elseif BY=="S_VH"
        tmp_S(:,:,2*FREQ_POINT+1:3*FREQ_POINT)=tmp_S(:,:,2*FREQ_POINT+1:3*FREQ_POINT)+alpha;
    elseif BY=="S_VV"
        tmp_S(:,:,3*FREQ_POINT+1:4*FREQ_POINT)=tmp_S(:,:,3*FREQ_POINT+1:4*FREQ_POINT)+alpha;
    end
    K=tmp_S;
    ans=calc_h_and_f(K,model,p);
end


function f=calc_h_and_f(K,model,p)
    h=calc_h(K,model);
    f=sum(abs(h).^p,'all');
end