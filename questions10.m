P = readmatrix('matrix.txt');

PI_0 = zeros(1, 27);

PI_0(1) = 1; % QUESTION 1) state 2

n_max = 50; 

history = zeros(n_max, 27);

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

% 4. Fixes interval and step sizes
ylim([0 0.4])
yticks(0:0.05:0.5)