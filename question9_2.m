% 1. Load the original 27x27 transition matrix
P = readmatrix('matrix.txt');

% 2. Isolate the specific persistent communicating classes
class_nodes = [1, 4, 11, 18, 26, 27];
%class_nodes = [2, 5, 12, 21, 25];
%class_nodes = [6, 17, 20];
%class_nodes = [8, 9, 16];

P_sub = P(class_nodes, class_nodes);

% 3. Set up the system of linear equations: pi * P_sub = pi  =>  pi * (P_sub - I) = 0
% We transpose it to solve the standard Ax = b form in MATLAB: (P_sub - I)' * pi' = 0
num_nodes = length(class_nodes);
A = (P_sub - eye(num_nodes))';
b = zeros(num_nodes, 1);

% 4. Add the normalization rule: sum(pi) = 1
% Replace the last redundant row of the system with the normalization constraint
A(end, :) = ones(1, num_nodes);
b(end) = 1;

% 5. Solve the linear system
pi_col = A \ b;
pi_dist = pi_col'; % Convert back to a row vector

% 6. Display the results with both exact fractions and decimals
fprintf('--- EXACT STATIONARY DISTRIBUTION ---\n');
fprintf(['For Persistent Comunicating Class: {' repmat(' %1.0f ',1,numel(class_nodes)) '}\n'],class_nodes);
[N, D] = rat(pi_dist); % MATLAB's built-in decimal-to-fraction converter

for i = 1:num_nodes
    state = class_nodes(i);
    frac_str = sprintf('%d/%d', N(i), D(i));
    fprintf('State %2d:  %-6s  (~ %.4f or %.2f%%)\n', state, frac_str, pi_dist(i), pi_dist(i)*100);
end