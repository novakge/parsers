% batch processing of ProTrack *.p2x files to (parsed) *.mat files as an input for simulation
% input: <folder name> containing files in the given format and extension
% output: parsed *.mat file for each input file stored in ../<folder name>/output folder
% example: save_instance('ProTrack')
function save_instance(directory)

extension_filter = '*.p2x'; % select extension
browse_dir = fullfile(directory, extension_filter); % look for all files with the extension in given subfolder
files = dir(browse_dir);
out_dir = 'output'; % default output subfolder

% map TP like 1=NTP, 2=CTP, 3=DTP as human readable simulation types
TP = ["NTP", "CTP", "DTP"];

if exist(directory, 'dir')
   mkdir(directory, out_dir);
else
   warning('%s directory does not exist!\n', directory);
   quit cancel;
end

for i=1:size(files,1) % iterate through all files in given directory
    
    for j=1:size(TP,2) % go through the simulation types
       
    [~,filename,~] = fileparts(fullfile(files(i,1).folder,files(i,1).name)) % get filename without extension
    
    [PDM, constr] = parse_protrack(fullfile(files(i,1).folder,files(i,1).name),j); % parse all files for all simulation types
    
    save(strcat(fullfile(files(i,1).folder,out_dir,filename),'_',TP(1,j)),'PDM','constr'); % save each variable "PDM" to the <folder name>/output folder
    
    if (j == 1) % save DSM only once per file
    DSM = parse_protrack(fullfile(files(i,1).folder,files(i,1).name),0); % parse only DSM
    save(strcat(fullfile(files(i,1).folder,out_dir,filename),'_DSM'),'DSM');
    end

    
    end % simulation types
end % all files


