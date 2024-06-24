% unicycle_definition.m
function[check_connectivity]= unicycle_definition(N, shape_offset, time, num_connections_to_remove)
    global x y theta v theta_dot u_w u_v delta alpha A;

    % Initial state of the robots (random positions and velocities)
    x = rand(N, 1) * 30;
    y = rand(N, 1) * 30; 
    theta = rand(N, 1) * (2 * pi);
    
    % Initial velocities (for completeness, even though they are set to zero)
    v = zeros(N, 1); % Linear velocity
    theta_dot = zeros(N, 1); % Angular velocity
    u_w = zeros(N, 1); % Control input for angular velocity
    u_v = zeros(N, 1); % Control input for linear velocity
    
    % Calculate desired positions for each agent in the hexagon formation
    delta = zeros(N, 2); % Offset for hexagon
    for i = 1:N
        delta(i, 1) = shape_offset * cos(i * (2 * pi / N));
        delta(i, 2) = shape_offset * sin(i * (2 * pi / N));
    end
    
    % Initialize positional and angular errors based on random initial conditions
    alpha = zeros(N, length(time));

    % Adjacency matrix (fully connected graph)
    A = ones(N) - eye(N);
    
    % Loop to remove random connections
    k=0;
    if (2*num_connections_to_remove + N) > N*N
        disp("Cannot cut "+ num_connections_to_remove+" connection in a symmetric graph of "+ N+ " agents")
        check_connectivity =false;
    else
        while k ~= num_connections_to_remove
            i = randi(N);
            j = randi(N); 
            if (i ~= j) && ( A(i,j) == 1)
                A(i, j) = 0;
                A(j, i) = 0;
                k=k+1;
            end
        end
        check_connectivity = not(any(all(A==0,2))) %%If true the graph is connected
        A
    end
    
    
end