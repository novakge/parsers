% batch processing of predefined *.mm files to (parsed) *.mat files as an input for simulation
% example: save_all_instance

function save_all_instance
tic;
fprintf('in progress...');
save_instance('data/boctor50', 'boctor')
fprintf('still working...');
save_instance('data/boctor100', 'boctor')
fprintf('done!\n');
toc;


% any additional dataset goes here
