P = readmatrix('matrix.txt');

% Create a figure window
figure;

% --- 1. Graph and Subgraph Setup ---
G = digraph(P);
[classes, ~] = conncomp(G, 'Type', 'strong');
reduced_G = condensation(G);

% Setup a customized plot for the reduced graph
p = plot(reduced_G, 'Layout', 'layered', 'MarkerSize', 12);
title('Reduced Graph with Communicating Classes and Periods');

% --- 2. Color code Nodes based on persistence ---
out_degrees = outdegree(reduced_G);
for i = 1:numnodes(reduced_G)
    if out_degrees(i) == 0
        highlight(p, i, 'NodeColor', 'r'); % Persistent (No ways out) -> Red
    else
        highlight(p, i, 'NodeColor', 'b'); % Transient (Has exits) -> Blue
    end
end

% --- 3. Format Node Labels with Class Members AND Period ---
% Create a 1-or-0 logical adjacency matrix to track paths without precision errors
A = double(P > 0); 
num_classes = max(classes);

for i = 1:num_classes
    members = find(classes == i);
    
    % Pick the first state in the class to test its return times
    test_node = members(1); 
    class_period = 0;
    
    A_n = A; % Start at step n = 1
    
    % Test up to 100 steps (more than enough for a 27-state chain)
    for n = 1:100 
        % If there is a valid path to return to itself at step n
        if A_n(test_node, test_node) > 0
            % Find the greatest common divisor of all return times
            class_period = gcd(class_period, n);
            
            % Early optimization: If period drops to 1, it's aperiodic forever
            if class_period == 1
                break; 
            end
        end
        % Advance to the next step, capping values at 1 to prevent integer overflow
        A_n = double(A_n * A > 0); 
    end
    
    % Construct the label format: {1,2,3} (d=1)
    label = sprintf('{%s} (d=%d)', join(string(members), ','), class_period);
    p.NodeLabel{i} = label;
end

% --- 4. Add the Custom Legend ---
hold on;
h1 = plot(nan, nan, 'o', 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'b', 'MarkerSize', 10);
h2 = plot(nan, nan, 'o', 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r', 'MarkerSize', 10);
hold off;
legend([h1, h2], {'Transient Class', 'Persistent Class'}, 'Location', 'best');