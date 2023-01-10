function ans_array=dop_2_pipe_direction(hori_dop,ver_dop,add_45_dop,sub_45_dop,left_dop,right_dop, ...
    x_hori_re,x_ver_re,x_for_45_re,x_back_45_re,x_left_45_re,x_right_45_re, ...
    X_SIZE,Y_SIZE,Z_SIZE)

    DOP_TH=0.98;


%     hori_dop(hori_dop<DOP_TH)=0;
%     ver_dop(ver_dop<DOP_TH)=0;
%     add_45_dop(add_45_dop<DOP_TH)=0;
%     sub_45_dop(sub_45_dop<DOP_TH)=0;
%     left_dop(left_dop<DOP_TH)=0;
%     right_dop(right_dop<DOP_TH)=0;
    hori_dop(DOP_TH< hori_dop)=0;
    ver_dop(DOP_TH< ver_dop)=0;
    add_45_dop(DOP_TH< add_45_dop)=0;
    sub_45_dop(DOP_TH< sub_45_dop)=0;
    left_dop(DOP_TH< left_dop)=0;
    right_dop(DOP_TH< right_dop)=0;

    % x_TH=0;
    % x_hori_re(x_TH <x_hori_re)=0;

    ans_array=zeros(X_SIZE,Y_SIZE,Z_SIZE);
    ans_array=x_hori_re.*hori_dop+x_ver_re.*ver_dop+add_45_dop.*x_for_45_re+sub_45_dop.*x_back_45_re+left_dop.*x_left_45_re+right_dop.*x_right_45_re;
%     ans_array=sum(x_hori_re.*hori_dop+x_ver_re.*ver_dop+add_45_dop.*x_for_45_re+sub_45_dop.*x_back_45_re+left_dop.*x_left_45_re+right_dop.*x_right_45_re,3);
%     ans_array=sum(hori_dop+ver_dop+x_for_45_re+x_back_45_re+x_left_45_re+x_right_45_re,3);



end