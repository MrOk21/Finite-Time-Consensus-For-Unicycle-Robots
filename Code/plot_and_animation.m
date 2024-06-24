% plot_and_animation.m

% With save_folder
% function plot_and_animation(N, x_traj, y_traj, theta_traj, v_traj, theta_dot_traj, time, save_folder) 

% Without save_folder
 function plot_and_animation(N, x_traj, y_traj, theta_traj, v_traj, theta_dot_traj, time) 

    colors = lines(N);
    
    % Create folder if it doesn't exist
    % if ~exist(save_folder, 'dir')
    %     mkdir(save_folder);
    % end
    
    % Animation of the shape formation
    figure; axis equal;
    set(gcf, 'Position', get(0, 'Screensize')); 
    hold on;
    grid on;
    xlim([-120 120])
    ylim([-70 70])
    h_agents = gobjects(N, 1);
    h_agents_ball = gobjects(N, 1);
    for i = 1:N
        % Plot an arrow
        h_agents(i) = quiver(x_traj(i, 1), y_traj(i, 1), cos(theta_traj(i, 1)), sin(theta_traj(i, 1)), 'Color', colors(i, :), 'MaxHeadSize', 5, 'LineWidth', 3, 'AutoScaleFactor', 0.7);
        h_agents_ball(i) = plot(x_traj(i, 1), y_traj(i, 1), 'o', 'MarkerSize', 8, 'MarkerFaceColor', colors(i, :), 'Color', colors(i, :));
    end
    plot(mean(x_traj(:, end)), mean(y_traj(:, end)), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
    
   
    xlabel('X');
    ylabel('Y');
    title('Trajectories and shape formation');
    for t = 1:5:length(time)
        for i = 1:N
            set(h_agents_ball(i), 'XData', x_traj(i, t), 'YData', y_traj(i, t));
            set(h_agents(i), 'XData', x_traj(i, t), 'YData', y_traj(i, t));
            set(h_agents(i), 'UData', (0.5 * v_traj(i, t) + 3 * sign(v_traj(i, t))) * cos(theta_traj(i, t)), 'VData', (0.5 * v_traj(i, t) + 3 * sign(v_traj(i, t))) * sin(theta_traj(i, t)));
        end
        pause(0.01);
    end
    hold off;
    
    % Save the animation plot
    % saveas(gcf, fullfile(save_folder, 'animation_plot.png'));

    % Position Trajectories
    figure;
    set(gcf, 'Position', get(0, 'Screensize')); % Set to fullscreen
    hold on;
    for i = 1:N
        plot(time, x_traj(i, :), 'Color', colors(i, :), 'DisplayName', sprintf('Agent %d - X', i));
        plot(time, y_traj(i, :), 'Color', colors(i, :), 'LineStyle', '--', 'DisplayName', sprintf('Agent %d - Y', i));
    end
    xlabel('Time');
    ylabel('Position');
    title('Position trajectories of agents');
    legend show;
    hold off;
    grid on;
    
    % Save the position trajectories plot
    % saveas(gcf, fullfile(save_folder, 'position_trajectories.png'));

    % Velocity Trajectories
    figure;
    set(gcf, 'Position', get(0, 'Screensize')); % Set to fullscreen
    hold on;
    for i = 1:N
        plot(time, v_traj(i, :), 'Color', colors(i, :), 'DisplayName', sprintf('Agent %d - V', i));
    end
    xlabel('Time');
    ylabel('Velocity');
    title('Velocity trajectories of agents');
    legend show;
    hold off;
    grid on;
    
    % Save the velocity trajectories plot
    % saveas(gcf, fullfile(save_folder, 'velocity_trajectories.png'));

    % Theta and Theta Dot Trajectories
    figure;
    set(gcf, 'Position', get(0, 'Screensize')); % Set to fullscreen
    subplot(2, 1, 1);
    hold on;
    for i = 1:N
        plot(time, theta_traj(i, :), 'Color', colors(i, :), 'DisplayName', sprintf('Agent %d - Theta', i));
    end
    xlabel('Time');
    ylabel('Theta');
    title('Theta trajectories of agents');
    legend show;
    grid on;
    hold off;

    subplot(2, 1, 2);
    hold on;
    for i = 1:N
        plot(time, theta_dot_traj(i, :), 'Color', colors(i, :), 'DisplayName', sprintf('Agent %d - Theta Dot', i));
    end
    xlabel('Time');
    ylabel('Theta Dot');
    title('Theta Dot trajectories of agents');
    legend show;
    grid on;
    hold off;
    
    % Save the theta and theta dot trajectories plot
    % saveas(gcf, fullfile(save_folder, 'theta_theta_dot_trajectories.png'));
end
