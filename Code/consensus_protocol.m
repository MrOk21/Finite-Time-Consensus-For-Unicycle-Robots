% consensus_protocol.m
function [x_traj, y_traj, theta_traj, v_traj, theta_dot_traj] = consensus_protocol(N, dt, time, beta, k_w_d, k_w_p, k_v_d, k_v_p, k_alpha)
    global x y theta v theta_dot u_w u_v delta alpha A;

    % Store trajectories over time
    x_traj = zeros(N, length(time));
    y_traj = zeros(N, length(time));
    v_traj = zeros(N, length(time)); 
    theta_traj = zeros(N, length(time)); 
    theta_dot_traj = zeros(N, length(time)); 

    %% Main Loop
    for t = 1:length(time)
        psi = 2.5 + (4 / pi) * sin(0.5 * time(t));
        
        % Update agent positions and velocities
        for i = 1:N
            % Calculate error in position
            e_z = zeros(1, 2);
            e_theta = 0;
            for j = 1:N
                if A(i, j) == 1
                    e_z = e_z + (([x(i), y(i)] - delta(i, :)) - ([x(j), y(j)] - delta(j, :)));
                    e_theta = e_theta + (theta(i) - theta(j));
                end
            end
            e_z = e_z / sum(A(i, :));
            e_theta = e_theta / sum(A(i, :));

            % Calculate the control inputs
            u_v(i) = -k_v_d * v(i) - k_v_p * sign([cos(theta(i)), sin(theta(i))] * e_z') * abs([cos(theta(i)), sin(theta(i))] * e_z')^beta;
            
            % Update velocities
            v(i) = v(i) + u_v(i) * dt;
            
            % Update positions and orientation
            x(i) = x(i) + v(i) * cos(theta(i)) * dt;
            y(i) = y(i) + v(i) * sin(theta(i)) * dt;
            
            alpha(i, t) = k_alpha * psi * ([-sin(theta(i)), cos(theta(i))] * e_z');
            u_w(i) = -k_w_d * theta_dot(i) - k_w_p * sign(e_theta)*abs(e_theta)^beta + alpha(i, t);

            theta_dot(i) = theta_dot(i) + u_w(i) * dt;
            theta(i) = theta(i) + theta_dot(i) * dt;
        end
        
        % Save current positions and velocities
        x_traj(:, t) = x;
        y_traj(:, t) = y; 
        theta_traj(:, t) = theta; 
        v_traj(:, t) = v;
        theta_dot_traj(:, t) = theta_dot; 
    end

    % Calculate the convergence point (average of final positions)
    convergence_x = mean(x);
    convergence_y = mean(y);
    
    % Print the convergence coordinates
    fprintf('Convergence Point: (%.2f, %.2f)\n', convergence_x, convergence_y);
end
