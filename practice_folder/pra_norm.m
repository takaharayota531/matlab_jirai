clc;clear all;
n=1000;
p=200;

theta=randn(p,n);
y=rand(p,1);

cvx_begin;
    variable s_L1(n);
    minimize(norm(s_L1,1));
    subject theta*S_L1==y;
cvx_end;

s_L2=pinv(theta)*y;

