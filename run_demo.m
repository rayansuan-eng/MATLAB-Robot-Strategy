% Run Rayan's strategy against a sample opponent from the course package.
% Open this folder as the MATLAB Current Folder, then run: run_demo
close all

team1 = struct('name', 'Rayan', 'color', [0.15 0.45 0.85], ...
    'strategy', @MyRobotStrategy2);
team2 = struct('name', 'Random opponent', 'color', [0.90 0.35 0.20], ...
    'strategy', @robostrategy_rand);

robotgame_main(team1, team2);
