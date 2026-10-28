P = readmatrix('clock-matrix.txt');

PI_0 = zeros(1, 12);
PI_0(1) = 1; % state 1 (being at 13h)

n_max = 100; 

history = zeros(n_max, 12);

for n = 1:n_max
    history(n, :) = PI_0 * (P ^ n);
end

% 1. Find columns (states) with a non-zero probability at any step
active_states = any(history > 0, 1);

% 2. Plot only the filtered columns
plot(1:n_max, history(:, active_states))

% 3. Add a legend to properly identify the plotted states
state_numbers = 1:27;
legend(string(state_numbers(active_states)))