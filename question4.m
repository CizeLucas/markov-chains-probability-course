P = readmatrix('matrix.txt');

PI_0 = zeros(1, 27);

PI_0(8) = 1; % Starts at 14

%PI_0(8) = 0.333333333; PI_0(9) = 0.333333333; PI_0(16) = 0.333333333; % Evenly dist.

%PI_0(8) = 0.4; PI_0(9) = 0.22; PI_0(16) = 0.38; % Randomly dist.

%PI_0(8) = 0.48; PI_0(9) = 0.04; PI_0(16) = 0.48; % Randomly dist. (9's probability very low)

n_max = 200; 

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