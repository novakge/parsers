% batch save all libraries to (parsed) *.mat files
% example: save_all
function save_all
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
