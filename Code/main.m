% main.m
clear;
clc;
close all;

% Parameters
N = 6;
dt = 0.005;
ft = 30;
time = 0:dt:ft;
shape_offset = 25;
beta = 0.5;
k_w_d = 1;
k_w_p = 1;
k_v_d = 1;
k_v_p = 1;
k_alpha = 0.5;
num_connections_to_remove = 0;

% Folder to save plots
% save_folder = "Insert_your_save_folder_path";

% Initialize the system
check_connectivity = unicycle_definition(N, shape_offset, time, num_connections_to_remove);
if check_connectivity
    % Run the consensus protocol 
    [x_traj, y_traj, theta_traj, v_traj, theta_dot_traj] = consensus_protocol(N, dt, time, beta, k_w_d, k_w_p, k_v_d, k_v_p, k_alpha);

    % Plot and animate the results (with save_folder)
    % plot_and_animation(N, x_traj, y_traj, theta_traj, v_traj, theta_dot_traj, time, save_folder);

    % Plot and animate the results (without save_folder)
    plot_and_animation(N, x_traj, y_traj, theta_traj, v_traj, theta_dot_traj, time);

 else
    disp("The graph is not connected anymore! Try lower the parameter for random edge connection cut")
end
