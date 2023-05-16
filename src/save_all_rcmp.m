% batch processing of predefined *.sm or *.mm files to (parsed) *.mat files as an input for simulation
% example: save_all_instance
function save_all_rcmp
tic;
fprintf('in progress...');
save_instance('data/BY', 'rcmp')
fprintf('...');
save_instance('data/RCMPSPLIB', 'rcmp')
fprintf('...');
save_instance('data/MPSPLIB', 'rcmp')
fprintf('...');
save_instance('data/MPLIB1/MPLIB 1 - Set 1', 'rcmp')
fprintf('...');
save_instance('data/MPLIB1/MPLIB 1 - Set 2', 'rcmp')
fprintf('...');
save_instance('data/MPLIB1/MPLIB 1 - Set 3', 'rcmp')
fprintf('...');
fprintf('still working...');
save_instance('data/MPLIB2/MPLIB 2 - Set 1', 'rcmp')
fprintf('...');
save_instance('data/MPLIB2/MPLIB 2 - Set 2', 'rcmp')
fprintf('...');
save_instance('data/MPLIB2/MPLIB 2 - Set 3', 'rcmp')
fprintf('...');
save_instance('data/MPLIB2/MPLIB 2 - Set 4', 'rcmp')
fprintf('...');

fprintf('done!\n');
toc;

% any additional dataset goes here
