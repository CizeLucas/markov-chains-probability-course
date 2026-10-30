P = readmatrix('matrix.txt');

PI_0 = zeros(1, 27);

PI_0(14) = 1; % Starts at 14

PI_0([10,14,19,22,24]) = 1/5; % Evenly dist.

%PI_0(10) = 0.2; PI_0(14) = 0.19; PI_0(19) = 0.25; PI_0(22) = 0.30; PI_0(24) = 0.06; % Randomly dist.

n_max = 50;

history = zeros(n_max+1, 27);

history(1, :) = PI_0;

for n = 2:n_max+1
    history(n, :) = PI_0 * (P ^ n);
end

% 1. Find columns (states) with a non-zero probability at any step
active_states = any(history > 0, 1);

% 2. Plot only the filtered columns
figure('Color', 'white');
plot(0:n_max, history(:, active_states), 'LineWidth', 1.5)

% 3. Add titles and axis labels, forcing black text and larger fonts
title('Distribution evolution', 'Color', 'black', 'FontSize', 14);
xlabel('Step n', 'Color', 'black', 'FontSize', 12);
ylabel('Probability', 'Color', 'black', 'FontSize', 12);

% 4. Add the grid and increase the font size of the axes
grid on;
set(gca, 'Color', 'white', ...
         'XColor', 'black', ...
         'YColor', 'black', ...
         'GridColor', 'black', ...
         'GridAlpha', 0.15, ...
         'FontSize', 12);

% 5. Create combined labels for the legend (State + Final Probability)
state_numbers = 1:27;
active_nums = state_numbers(active_states);
final_vals = history(end, active_states); % Extracts the probabilities at the final step (n_max)

% Format strings to look like "4 (0.288)"
lgd_labels = arrayfun(@(s, v) sprintf('%d (%.3f)', s, v), active_nums, final_vals, 'UniformOutput', false);

% Add the combined legend
lgd = legend(lgd_labels);
title(lgd, 'State (Final Probabilities)');
lgd.NumColumns = 3; % Reduced from 4 to 3 columns to accommodate the wider text
lgd.Location = 'northeast';
lgd.Color = 'white';
lgd.TextColor = 'black';
lgd.FontSize = 11;

% 6. Fix interval and step sizes
ylim([0 1.0])
yticks(0:0.2:1.0)
xlim([0 n_max+1])