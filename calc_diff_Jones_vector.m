
function [diff_g0,diff_g1,diff_g2,diff_g3]=calc_diff_Jones_vector(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,DIFF_BY)
    diff_g0 =diff_J_HH(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,DIFF_BY) + diff_J_VV(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,DIFF_BY);
    diff_g1=diff_J_HH(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,DIFF_BY) - diff_J_VV(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,DIFF_BY);
    diff_g2 = diff_J_HV(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,DIFF_BY) + diff_J_VH(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,DIFF_BY);
    diff_g3=1i*(diff_J_HV(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,DIFF_BY) - diff_J_VH(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,DIFF_BY));


end

% 偏微分変更済み
function ans_J_HH= diff_J_HH(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,DIFF_BY)
    DIFF_by_S_HH='DIFF_by_S_HH';
    DIFF_by_S_HV='DIFF_by_S_HV';
    DIFF_by_S_VH='DIFF_by_S_VH';
    DIFF_by_S_VV='DIFF_by_S_VV';
    
    if DIFF_BY ==DIFF_by_S_HH   
        ans_J_HH = E_iH*conj( S_HH*E_iH+S_HV*E_iV );
    elseif DIFF_BY==DIFF_by_S_HV
        ans_J_HH = E_iV*conj( S_HH*E_iH+S_HV*E_iV );
    elseif DIFF_BY==DIFF_by_S_VH
        ans_J_HH = zeros(size(S_HH));
    elseif DIFF_BY==DIFF_by_S_VV
        ans_J_HH = zeros(size(S_HH));
    end
end

% 偏微分変更済み
function ans_J_HV= diff_J_HV(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,DIFF_BY)
    DIFF_by_S_HH='DIFF_by_S_HH';
    DIFF_by_S_HV='DIFF_by_S_HV';
    DIFF_by_S_VH='DIFF_by_S_VH';
    DIFF_by_S_VV='DIFF_by_S_VV';

    if DIFF_BY ==DIFF_by_S_HH   
        ans_J_HV = E_iH*conj( S_VH*E_iH+S_VV*E_iV);
    elseif DIFF_BY==DIFF_by_S_HV
        ans_J_HV = E_iV*conj( S_VH*E_iH+S_VV*E_iV);
    elseif DIFF_BY==DIFF_by_S_VH
        ans_J_HV = zeros(size(S_HH));
    elseif DIFF_BY==DIFF_by_S_VV
        ans_J_HV =  zeros(size(S_HH));
    end
end
% 偏微分変更済み
function ans_J_VH= diff_J_VH(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,DIFF_BY)
    DIFF_by_S_HH='DIFF_by_S_HH';
    DIFF_by_S_HV='DIFF_by_S_HV';
    DIFF_by_S_VH='DIFF_by_S_VH';
    DIFF_by_S_VV='DIFF_by_S_VV';
    
    if DIFF_BY ==DIFF_by_S_HH   
        ans_J_VH =  zeros(size(S_HH));
    elseif DIFF_BY==DIFF_by_S_HV
        ans_J_VH =  zeros(size(S_HH));
    elseif DIFF_BY==DIFF_by_S_VH
        ans_J_VH = conj( S_HH*E_iH+S_HV*E_iV )*E_iH;
    elseif DIFF_BY==DIFF_by_S_VV
        ans_J_VH = conj( S_HH*E_iH+S_HV*E_iV )*E_iV;
    end
end


% 偏微分変更済み
function ans_J_VV= diff_J_VV(S_HH,S_HV,S_VH,S_VV,E_iH,E_iV,DIFF_BY)
    DIFF_by_S_HH='DIFF_by_S_HH';
    DIFF_by_S_HV='DIFF_by_S_HV';
    DIFF_by_S_VH='DIFF_by_S_VH';
    DIFF_by_S_VV='DIFF_by_S_VV';
    
    if DIFF_BY ==DIFF_by_S_HH   
        ans_J_VV = zeros(size(S_HH));
    elseif DIFF_BY==DIFF_by_S_HV
        ans_J_VV = zeros(size(S_HH));
    elseif DIFF_BY==DIFF_by_S_VH
        ans_J_VV = E_iH*conj( S_VH*E_iH+S_VV*E_iV );
    elseif DIFF_BY==DIFF_by_S_VV
        ans_J_VV = E_iV*conj( S_VH*E_iH+S_VV*E_iV );
    end
end