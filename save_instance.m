% batch processing of *.sm / *.mm / *.p2x / *.rcp / *.sch / *.prb files to (parsed) *.mat files as an input for simulation
% input: <folder name> containing files in the given format and extension
% output: parsed *.mat file for each input file stored in ../<folder name>/output folder
% example #1: save_instance('data_folder', 'rangen')
% example #2: save_instance('data_folder', 'protrack')
% example #3: save_instance('data_folder', 'xlib')
% example #3: save_instance('data_folder', 'progen')
% example #4: save_instance('data_folder', 'boctor')

function save_instance(directory, parser_type)

% select the existing parser function and the corresponding file extension

switch parser_type
    
    case 'rangen'
        if exist('parse_rangen') % RanGen1-2
            parser = @parse_rangen; % create common function handle
            extension_filter = '*.rcp'; % select extension
        end
        
    case 'protrack'
        if exist('parse_protrack') % ProTrack (Real-Life)
            parser = @parse_protrack; % create common function handle
            extension_filter = '*.p2x'; % select extension
        end

    case 'xlib'
        if exist('parse_xlib') % MMLIB, PSPLIB
            parser = @parse_xlib; % create common function handle
            extension_filter = '*.?m'; % select extension *.sm or *.mm depending on single/multimode instances
        end

    case 'progen'
        if exist('parse_progen') % Progen/MAX (~PSPLIB)
            parser = @parse_progen; % create common function handle
            extension_filter = '*.sch'; % select extension
        end

    case 'boctor'
        if exist('parse_progen') % Boctor
            parser = @parse_boctor; % create common function handle
            extension_filter = '*.prb'; % select extension
        end

    otherwise
        error('Invalid parser type selected, please choose one of: rangen | protrack | xlib | progen | boctor \n');
end

browse_dir = fullfile(directory, extension_filter); % look for all files with the extension in given subfolder
files = dir(browse_dir);

[parent_folder_path] = fileparts(browse_dir);
[current_folder,~] = fileparts(parent_folder_path);
[~, child_folder] = fileparts(parent_folder_path);

out_dir = strcat(current_folder,'/',child_folder,'_output','/'); % same level as input directory

if exist(directory, 'dir')
   mkdir(out_dir);
else
   warning('%s directory does not exist!\n', directory);
   quit cancel;
end

% map TP like 1=NTP, 2=CTP, 3=DTP as human readable simulation types
TP = ["NTP", "CTP", "DTP"];

for i=1:size(files,1) % iterate through all files in given directory
    
    for j=1:size(TP,2) % go through the simulation types
       
    [~,filename,~] = fileparts(fullfile(files(i,1).folder,files(i,1).name)); % get filename without extension
    
    [PDM, constr, num_r_resources, num_nr_resources, num_modes, num_activities, sim_type] = parser(fullfile(files(i,1).folder,files(i,1).name),j); % parse all files for all simulation types
    
    if sim_type > 0 % if the given simulation type is supported for the dataset
        save(strcat(out_dir,filename,'_',TP(1,j)),'PDM','constr','num_r_resources', 'num_nr_resources', 'num_modes','num_activities','sim_type'); % save each variable "PDM" to the <folder name>/output folder
    else
        % skip the given trade-off for this instance (not supported)
    end
        
    if (j == 1) % save DSM only once per file for debug
        DSM = parser(fullfile(files(i,1).folder,files(i,1).name),0); % parse only DSM
        save(strcat(out_dir,filename,'_DSM'),'DSM');
    end
    
    end % simulation types
end % all files


