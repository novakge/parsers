% batch processing of predefined *.sch files to (parsed) *.mat files as an input for simulation
% example: save_all_instance
function save_all_instance
tic;
fprintf('in progress...');
save_instance('data/progen_001', 'progen')
fprintf('...');
fprintf('done!\n');
toc;


% any additional dataset goes here
