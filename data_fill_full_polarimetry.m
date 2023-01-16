function [s_HH,s_HV,s_VH,s_VV, ...
    hori_dop,ver_dop,add_45_dop,sub_45_dop,left_dop,right_dop] ...
    = data_fill_full_polarimetry(s_HH,s_HV,s_VH,s_VV,hori_dop,ver_dop,add_45_dop,sub_45_dop,left_dop,right_dop,sample_list)

    s_HH=data_fill(s_HH,sample_list);
    s_HV=data_fill(s_HV,sample_list);
    s_VH=data_fill(s_VH,sample_list);
    s_VV=data_fill(s_VV,sample_list);

    hori_dop=data_fill(hori_dop,sample_list);
    ver_dop=data_fill(ver_dop,sample_list);
    add_45_dop=data_fill(add_45_dop,sample_list);
    sub_45_dop=data_fill(sub_45_dop,sample_list);
    left_dop=data_fill(left_dop,sample_list);
    right_dop=data_fill(right_dop,sample_list);

end