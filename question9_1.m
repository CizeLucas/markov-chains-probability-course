% 1. Load Matrix and Define Starting Node
P = readmatrix('matrix.txt');

% --- PART 1: GLOBAL SYSTEM ANALYSIS (The Eigenvalues) ---
% Calculate the eigenvalues of the transposed matrix
eigenvalues = eig(P'); 

% Count how many eigenvalues are equal to 1 (with a small tolerance for precision)
num_persistent_classes = sum(abs(eigenvalues - 1) < 1e-6);

fprintf('--- SYSTEM DIAGNOSTICS ---\n');
fprintf('Count of eigenvalues equal to 1: %d\n', num_persistent_classes);

if num_persistent_classes > 1
    fprintf('Because there are %d eigenvalues equal to 1, the overall reducible chain possesses an INFINITE number of stationary distributions.\n\n', num_persistent_classes);
else
    fprintf('The system has exactly 1 unique stationary distribution.\n\n');
end

% --- PART 2: LOCAL CONVERGENCE FROM THE STARTING NODE ---
% Even though the system has infinite possibilities, starting from a specific 
% node forces it to collapse into one calculable limiting distribution.
Pi_0 = zeros(1, 27);

start_node = 14; % Manually defined starting node
Pi_0(start_node) = 1; 

% Calculate the final stationary probabilities (limiting distribution)
n_steps = 1000;
Pi_inf = Pi_0 * (P^n_steps);

fprintf('--- FINAL CALCULABLE PROBABILITIES ---\n');
fprintf('By starting specifically at node %d, the system collapses into this exact limiting distribution:\n', start_node);

% Display only the states that actually receive a final probability
active_states = find(Pi_inf > 1e-4);
for state = active_states
    fprintf('State %d: %.6f (%.2f%%)\n', state, Pi_inf(state), Pi_inf(state)*100);
end