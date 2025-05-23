A = [2 3 -1 4;1 2 6 -7];
C = [2 3 4 7];
b = [8;-3];
n = size(A,2);
m = size(A,1);
nCm = nchoosek(n,m)
p = nchoosek(1:n,m) 
sol = []
if n > m
    for i = 1:nCm
        y = zeros(n,1);
        A1 = A(:,p(i,:));
        X = inv(A1)*b; 
    %Feasibility condition
        if all(X>0 & X ~=inf & X ~=-inf)
        y(p(i,:)) = X
        sol = [sol y]
        end
    end
else 
    error('No of variables are less than constraints')
end
%Object Value Function
Z = C*sol
[obj,index] = max(Z)
BFS = sol(:,index)

optval = [BFS' obj]
array2table(optval,'VariableNames',{'x1','x2','x3','x4','z'})