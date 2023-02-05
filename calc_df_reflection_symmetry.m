function diff_ans=calc_df_reflection_symmetry(S,DIFF_BY,FREQ_POINT)
    S_HH=S(:,:,1:FREQ_POINT);
    S_HV=S(:,:,FREQ_POINT+1:2*FREQ_POINT);
    S_VH=S(:,:,2*FREQ_POINT+1:3*FREQ_POINT);
    S_VV=S(:,:,3*FREQ_POINT+1:4*FREQ_POINT);


end

function diff_amp=(S,DIFF_BY,FREQ_POINT)
    S_HH=S(:,:,1:FREQ_POINT);
    S_HV=S(:,:,FREQ_POINT+1:2*FREQ_POINT);
    S_VH=S(:,:,2*FREQ_POINT+1:3*FREQ_POINT);
    S_VV=S(:,:,3*FREQ_POINT+1:4*FREQ_POINT);
    if DIFF_BY=='DIFF_by_S_HH'
        diff_amp=(conj(S_HH)-conj(S_VV));
    elseif

end

function diff_phase(S,DIFF_BY,FREQ_POINT)
    S_HH=S(:,:,1:FREQ_POINT);
    S_HV=S(:,:,FREQ_POINT+1:2*FREQ_POINT);
    S_VH=S(:,:,2*FREQ_POINT+1:3*FREQ_POINT);
    S_VV=S(:,:,3*FREQ_POINT+1:4*FREQ_POINT);
end