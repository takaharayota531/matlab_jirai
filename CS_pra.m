clc;clear;

k=20;%kスパース
n=1024;%圧縮前の次元数
m=128;%圧縮後の次元数

%スパース信号の生成
x=zeros(n,1);
index=randperm(n,k);

for i=1:k
    x(index(i))=1;
end

O=rand(m,n);

F=dftmtx(n);
reF=conj(F)/n;

A=O*reF;

y=A*x;
%% 受信信号の受信
%行列のプロットは列ごとにプロットされる
plot(y);

%% 元信号の受信
figure(1);
plot(x);

%% OMP法による復元
[xp res]=omp(y,A,k);
figure(2);
plot(abs(xp));