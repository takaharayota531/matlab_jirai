clc;clear all;

%モデルの作成
cvx_begin
variables x y
minimize((x+y+3)^2)
y>=0
cvx_end

x
y

cvx_status%最適化の成否
cvx_optval%最終値

%% 二値問題の最適化

A=randn(100,30);
b=randn(100,1);

cvx_begin
variable x(30)
x>=0
sum(x)==1
minimize(norm(A*x-b))
cvx_end

x

%% L1norm
n=1000;
p=200;
theta=randn(p,n);
y=randn(p,1);

cvx_begin;
    variable s_L1(n);
    minimize(norm(s_L1,1));
    subject to
            theta*s_L1==y;
cvx_end;

%% L1norm
s_L2=pinv(theta)*y;

%% plot
figure(1);
plot(s_L1)
figure(2);
plot(s_L2)




