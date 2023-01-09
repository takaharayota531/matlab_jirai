function ans_array=dop_2_pipe_direction(hori_dop,ver_dop,add_45_dop,sub_45_dop,left_dop,right_dop, ...
    x_hori_re,x_ver_re,x_for_45_re,x_back_45_re,x_left_45_re,x_right_45_re)

    DOP_TH=0.98;
    hori_dop(hori_dop<DOP_TH)=0;





end