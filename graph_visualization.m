P = readmatrix('matrix.txt');

% Define the target nodes you want to inspect
target_nodes = [11];

% 1. Create a basic numeric graph to search for all reachable paths
G_search = digraph(P);
nodes_to_plot = target_nodes;

for i = 1:length(target_nodes)
    % Trace all descendants starting from each target node
    reachable = bfsearch(G_search, target_nodes(i));
    nodes_to_plot = [nodes_to_plot, reachable'];
end
nodes_to_plot = unique(nodes_to_plot); % Remove duplicates

% 2. Create the visual graph with string labels to lock original state numbers
G = digraph(P, string(1:27));
subG = subgraph(G, string(nodes_to_plot));

% 3. Plot with physics-based layout
figure;
%p = plot(subG, 'Layout', 'force', 'MarkerSize', 8, 'ArrowSize', 16);
p = plot(subG, 'Layout', 'circle', 'MarkerSize', 10, 'NodeColor', 'blue', 'ArrowSize', 18, 'LineWidth', 1.5);
p.EdgeLabel = round(subG.Edges.Weight, 2);
highlight(p, string(target_nodes), 'NodeColor', 'red', 'MarkerSize', 10);