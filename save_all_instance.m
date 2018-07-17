% batch processing of predefined *.mm files to (parsed) *.mat files as an input for simulation
% example: save_all_instance
function save_all_instance
tic;
fprintf('in progress...');
save_instance('data/c15')
fprintf('...');
save_instance('data/j30')
fprintf('...');
save_instance('data/m1')
fprintf('...');
save_instance('data/mmlib50')
fprintf('...');
save_instance('data/mmlib100')
fprintf('still working...');
save_instance('data/mmlibplus')
fprintf('done!\n');
toc;

% any additional dataset goes here