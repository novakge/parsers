% batch processing of predefined *.mm files to (parsed) *.mat files as an input for simulation
% example: save_all_instance
function save_all_instance
tic;
fprintf('in progress...');
fprintf('saving rangen dataset...');
save_all_rangen
fprintf('saving protrack dataset...');
save_all_protrack
fprintf('saving psplib/mmlib datasets...');
save_all_xlib
fprintf('saving boctor datasets...');
save_all_boctor
fprintf('all done!\n');
toc;


% any additional dataset goes here
