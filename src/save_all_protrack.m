% batch processing of predefined *.p2x files to (parsed) *.mat files as an input for simulation
% example: save_all_protrack
function save_all_protrack
tic;
fprintf('in progress...');
save_instance('../data/protrack', 'protrack')
fprintf('...');
fprintf('still working...');
fprintf('done!\n');
toc;


% any additional dataset goes here