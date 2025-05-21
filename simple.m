clc; clear; format short;

% Maximize Z = 2x1 + 5x2
A = [1 4; 3 1; 1 1];
b = [24; 21; 9];
C = [2 5];
[m, n] = size(A);

A = [A eye(m) b];                  
cost = [C zeros(1, m+1)];          
bv = n+1 : n+m;                    
zjcj = cost(bv)*A - cost;         

while any(zjcj(1:end-1) < 0)
    fprintf('Current BFS is not optimal\n');
    [~, pvt_col] = min(zjcj(1:end-1));
    
    col = A(:, pvt_col);
    if all(col <= 0), error('LPP is unbounded'); end
    
    ratios = A(:, end) ./ col;
    ratios(col <= 0) = inf;
    [~, pvt_row] = min(ratios);

    bv(pvt_row) = pvt_col;
    A(pvt_row, :) = A(pvt_row, :) / A(pvt_row, pvt_col);

    for i = 1:m
        if i ~= pvt_row
            A(i,:) = A(i,:) - A(i,pvt_col) * A(pvt_row,:);
        end
    end

    zjcj = cost(bv)*A - cost;
end

fprintf('Optimal solution found.\n');
solution = zeros(1, n + m + 1);
solution(bv) = A(:, end);
fprintf('Optimal Z = %.2f\n', zjcj(end));
disp('Variable Values:'); disp(array2table(solution(1:n), 'VariableNames', {'x1','x2'}));
