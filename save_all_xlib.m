% batch processing of predefined *.mm files to (parsed) *.mat files as an input for simulation
% example: save_all_instance
function save_all_instance
tic;
fprintf('in progress...');
save_instance('data/c15', 'xlib')
fprintf('...');
save_instance('data/j20mm', 'xlib')
fprintf('...');
save_instance('data/j30mm', 'xlib')
fprintf('...');
save_instance('data/m1', 'xlib')
fprintf('...');
save_instance('data/m2mm', 'xlib')
fprintf('...');
save_instance('data/mmlib50', 'xlib')
fprintf('...');
save_instance('data/mmlib100', 'xlib')
fprintf('still working...');
save_instance('data/mmlibplus', 'xlib')
fprintf('done!\n');
toc;


% any additional dataset goes here
