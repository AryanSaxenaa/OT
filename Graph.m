% Max z = 2x1 + x2
% Constraints:
% x1 + 2x2 <= 10
% x1 + x2 <= 6
% x1 - 2x2 <= 1
% x1, x2 >= 0
% STEP 1: Input
c = [2 1];
A = [1 2; 1 1; 1 -2];
b = [10; 6; 1]; 
x1 = 0:1:max(b); 
x21 = (b(1) - A(1,1) .* x1) ./ A(1,2);
x22 = (b(2) - A(2,1) .* x1) ./ A(2,2);
x23 = (b(3) - A(3,1) .* x1) ./ A(3,2);

x21 = max(0, x21);
x22 = max(0, x22);
x23 = max(0, x23);

plot(x1, x21, '--k', x1, x22, 'b', x1, x23, '--r');
grid on;
legend('x1 + 2x2 = 10', 'x1 + x2 = 6', 'x1 - 2x2 = 1');

cx1 = find(x1 == 0);
c1 = find(x21 == 0);
Line1 = [x1([c1, cx1]); x21([c1, cx1])]';

c2 = find(x22 == 0);
Line2 = [x1([c2, cx1]); x22([c2, cx1])]';

c3 = find(x23 == 0);
Line3 = [x1([c3, cx1]); x23([c3, cx1])]';

corpt = unique([Line1; Line2; Line3], 'rows');

pt = [0; 0];
for i = 1:size(A, 1)
    for j = i+1:size(A, 1)
        A1 = A([i j], :);
        B1 = b([i j]);
        x = inv(A1) * B1;
        pt = [pt x];
    end
end
ptt = pt';

% STEP 5: Collecting all points
allpt = [ptt; corpt];
points = unique(allpt, 'rows');

% STEP 6: Finding Feasible Region
for i = 1:size(points,1)
    const1(i) = A(1,1)*points(i,1) + A(1,2)*points(i,2) - b(1);
    const2(i) = A(2,1)*points(i,1) + A(2,2)*points(i,2) - b(2);
    const3(i) = A(3,1)*points(i,1) + A(3,2)*points(i,2) - b(3);
end

s1 = find(const1 > 0);
s2 = find(const2 > 0);
s3 = find(const3 > 0);
S = unique([s1 s2 s3]);
points(S, :) = []; 
% STEP 7: Evaluating Objective Function
values = points * c'; 
[obj, index] = max(values);

fprintf('Objective value is %f at (%f, %f)\n', obj, points(index, 1), points(index, 2));
