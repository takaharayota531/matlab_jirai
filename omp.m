function [x res]=omp(y,A,k)
    [m,N]=size(A);
    x=zeros(N,1);
    res=y;
    column=[];

    for i=1:k 
        [c n]=max(abs(A'*res));
        column(end+1)=n;
        x(column)=pinv(A(:,column))*y;
        res=y-A(:,column)*x(column);
    end 
end