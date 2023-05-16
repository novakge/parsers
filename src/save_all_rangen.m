% batch processing of predefined *.rcp files to (parsed) *.mat files as an input for simulation
% example: save_all_rangen
function save_all_rangen
tic;
fprintf('in progress..');
save_instance('../data/Patterson','rangen')
fprintf('...');
save_instance('../data/RG30/Set 1','rangen')
save_instance('../data/RG30/Set 2','rangen')
save_instance('../data/RG30/Set 3','rangen')
save_instance('../data/RG30/Set 4','rangen')
save_instance('../data/RG30/Set 5','rangen')
fprintf('...');
save_instance('../data/RG300','rangen')
fprintf('...');
save_instance('../data/SMCP','rangen')
fprintf('still working...');
save_instance('../data/SMFF','rangen')
fprintf('done!\n');
toc;

% any additional dataset goes here