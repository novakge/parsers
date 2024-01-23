% batch processing of predefined *.sm or *.mm files to (parsed) *.mat files as an input for simulation
% example: save_all_instance
function save_all_xlib
tic;
fprintf('in progress...');
save_instance('../data/PSPLIB/j30sm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/j60sm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/j90sm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/j120sm', 'xlib')
fprintf('still working...');

save_instance('../data/PSPLIB/c15mm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/c21mm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/j10mm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/j12mm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/j14mm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/j16mm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/j18mm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/j20mm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/j30mm', 'xlib')
fprintf('still working...');

save_instance('../data/PSPLIB/m1mm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/m2mm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/m4mm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/m5mm', 'xlib')
fprintf('still working...');

save_instance('../data/PSPLIB/n0mm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/n1mm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/n3mm', 'xlib')
fprintf('still working...');

save_instance('../data/PSPLIB/r1mm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/r3mm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/r4mm', 'xlib')
fprintf('...');
save_instance('../data/PSPLIB/r5mm', 'xlib')
fprintf('still working...');

save_instance('../data/mmlib50', 'xlib')
fprintf('...');
save_instance('../data/mmlib100', 'xlib')
fprintf('still working...');
save_instance('../data/mmlibplus', 'xlib')
fprintf('done!\n');
toc;


% any additional dataset goes here