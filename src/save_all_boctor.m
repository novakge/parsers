% batch processing of predefined *.prb files to (parsed) *.mat files as an input for simulation
% example: save_all_boctor

function save_all_boctor
tic;
fprintf('in progress...');
save_instance('data/boctor50', 'boctor')
fprintf('still working...');
save_instance('data/boctor100', 'boctor')
fprintf('done!\n');
toc;


% any additional dataset goes here
