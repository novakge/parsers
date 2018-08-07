% batch processing of predefined *.mm files to (parsed) *.mat files as an input for simulation
% example: save_all_instance
function save_all_instance
tic;
fprintf('in progress..');
save_instance('data/Patterson')
fprintf('...');
save_instance('data/RG30/Set 1')
save_instance('data/RG30/Set 2')
save_instance('data/RG30/Set 3')
save_instance('data/RG30/Set 4')
save_instance('data/RG30/Set 5')
fprintf('...');
save_instance('data/RG300_corr')
fprintf('...');
save_instance('data/SMCP')
fprintf('still working...');
save_instance('data/SMFF')
fprintf('done!\n');
toc;

% any additional dataset goes here