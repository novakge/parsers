% MMLIB dataset website: http://www.mmlib.eu/index.php
% PSPLIB dataset website: http://www.om-db.wi.tum.de/psplib/data.html
% -> all data: http://www.projectmanagement.ugent.be/sites/default/files/files/datasets/AboutData.zip
% -> summary excel including indicators: http://www.projectmanagement.ugent.be/sites/default/files/files/datasets/Datasets%20with%20Parameters%20and%20BKS.xlsx
% input: file with mmlib or psplib format (e.g. *.mm)
% example: PDM = parse_xlib('test_data/J100108_5.mm', 2) where 1=NTP, 2=CTP, 3=DTP simulation type, 0 = debug (DSM only)
% output: PDM file containing PDM = [DSM,TD,CD,{QD,RD}], format depending on the selected simulation type (trade-off problem)

function [PDM, constr, num_r_resources, num_nr_resources, num_modes, num_activities, sim_type] = parse_xlib(file_name, sim_type)

file_id = fopen(file_name,'r');

% search full text line by line, find/store main reference line numbers to handle flexible formats (MMLIB,PSPLIB)
act_line = fgetl(file_id); % initialize by reading the first line

psplib_flag = 0; % 1 = psplib, 0 = mmlib; store flag for handling format differences
line_project_info = 0; % optional variable, need to declare (depending on MMLIB/PSPLIB type)

i = 1; % count lines (rows)
while ischar(act_line)
    
    % search for line "jobs"
    if( strfind(act_line,'jobs') == true )
        line_jobs = i;
    end
    
    % search for line of each resource types
    if (contains(act_line,'- renewable') == true)
        line_renewable = i;
    elseif (contains(act_line,'- nonrenewable') == true)
        line_nonrenewable = i;  
    elseif (contains(act_line,'- doubly constrained') == true)
        line_dbl_constrained = i;
    end
    
    % search for line with "PROJECT INFORMATION" (only present in PSPLiB)
    
    if(contains(act_line,'PROJECT INFORMATION') == true)
        line_project_info = i;
        psplib_flag = 1;
    end
    
    % search for line with "PRECEDENCE RELATIONS"
    if(strfind(act_line,'PRECEDENCE RELATIONS') == true)
        line_precedences = i;
    end
    
    % search for line with "REQUESTS/DURATIONS"
    if(strfind(act_line,'REQUESTS/DURATIONS') == true)
        line_requests = i;
    end
    
    % search for line with "RESOURCE AVAILABILITIES" or "RESOURCEAVAILABILITIES"
    if(contains(act_line,["RESOURCE AVAILABILITIES","RESOURCEAVAILABILITIES"]) == true) % for PSPLIB format
        line_res_avail = i;
    end
        
    % read next line
    act_line = fgetl(file_id);
    i = i + 1; % next line until eof

end

% determine number of activities from jobs line
delimiter = {'  ','\t',' '};
formatSpec = '%*s%*s%*s%*s%d%*[^\n\r]';
frewind(file_id);
textscan(file_id, '%[^\n\r]', line_jobs-1, 'WhiteSpace', '', 'ReturnOnError', false);
num_activities = textscan(file_id, formatSpec, 1, 'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
num_activities = cell2mat(num_activities) - 2; % remove dummy activities and convert to numeric array for further usage

% determine number of resources for renewable resource types
delimiter = {'  ','\t',' ',':'};
formatSpec = '%*s%*s%d%*[^\n\r]';
frewind(file_id);
textscan(file_id, '%[^\n\r]', line_renewable-1, 'WhiteSpace', '', 'ReturnOnError', false);
num_r_resources = textscan(file_id, formatSpec, 1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
num_r_resources = cell2mat(num_r_resources);

% determine number of resources for non-renewable resource types
delimiter = {'  ','\t',' ',':'};
formatSpec = '%*s%*s%d%*[^\n\r]';
frewind(file_id);
textscan(file_id, '%[^\n\r]', line_nonrenewable-1, 'WhiteSpace', '', 'ReturnOnError', false);
num_nr_resources = textscan(file_id, formatSpec, 1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
num_nr_resources = cell2mat(num_nr_resources);

% determine number of resources for doubly-constrained resource types
delimiter = {'  ','\t',' ',':'};
formatSpec = '%*s%*s%*s%d%*[^\n\r]';
frewind(file_id);
textscan(file_id, '%[^\n\r]', line_dbl_constrained-1, 'WhiteSpace', '', 'ReturnOnError', false);
num_dc_resources = textscan(file_id, formatSpec, 1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
num_dc_resources = cell2mat(num_dc_resources);

% retrieve project information if present
if (line_project_info > 0) % only in PSPLIB format!
    formatSpec = '%d%d%d%d%d%d%*s%*s%*s%*s%*[^\n\r]';
    frewind(file_id);
    textscan(file_id, '%[^\n\r]', line_project_info+1, 'WhiteSpace', '', 'ReturnOnError', false);
    project_info = textscan(file_id, formatSpec, 1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
    project_info = cell2mat(project_info);
end

% read in complete precedence relations matrix (only numbers) format: [startRow startColumn endRow endColumn]
% read column #3 for number of successors (helps to calculate total width of matrix)
num_successors = dlmread(file_name,'',[line_precedences+2   2   line_precedences+1+num_activities   2]);

% read column #2 for number of modes for each task
num_modes = dlmread(file_name,'',[line_precedences+2   1   line_precedences+1+num_activities   1]);

% calculate maximum of successors for matrix column size
max_successors = max(num_successors);
num_columns = max_successors + 3; % including previous 3 columns (jobnr, #modes, #successors)

% finally, read all precedence relations and construct DSM matrix
mmlib_data = dlmread(file_name,'',[line_precedences+2   3   line_precedences+num_activities+1   num_columns-1]);

% pre-allocate n x n design structure matrix as output
DSM = zeros(num_activities,num_activities); 

for i=1:num_activities % iterate through rows
    
    DSM(i,i) = 1; % put "1" on diagonal for each fix activity node
    
    for j=1:size(mmlib_data,2) % iterate through # of columns
        
        if (mmlib_data(i,j) > i) % consider successor activities only (upper triangle) also exclude zeros
            
            if (mmlib_data(i,j) <= num_activities + 1) % exclude end activity
                
                activity_index = mmlib_data(i,j) - 1; % use offset for dummy end node
                DSM(i,activity_index) = 1; % put "1" for each line between two nodes
                
            end
        end
    end
end

% scan durations, resource modes and requirement matrix for all modes
delimiter = {'\t','    ','         '};
frewind(file_id); % need to rewind text read pointer
textscan(file_id, '%[^\n\r]', line_requests+3, 'WhiteSpace', '', 'ReturnOnError', false);
% determine formatspec dynamically based on number of resource columns for all rows determined by #modes x #activities
res_mode_dur_req = textscan(file_id, repmat('%d', 1, num_r_resources+num_nr_resources+num_dc_resources+3), sum(num_modes), 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', 0, 'ReturnOnError', false, 'EndOfLine', '\r\n');
res_mode_dur_req = cell2mat(res_mode_dur_req); % convert to numeric values
% NOTE: in case of new formats, first column need to be considered. When modes >1, the first column (job#) is empty -> must be zero when parsed.


% scan resource availabilities matrix
delimiter = {'  ','\t',' '};
frewind(file_id);
if (psplib_flag == true)
    textscan(file_id, '%[^\n\r]', line_res_avail+1, 'WhiteSpace', '', 'ReturnOnError', false); % format differs by one line for psplib/mmlib
else
    textscan(file_id, '%[^\n\r]', line_res_avail, 'WhiteSpace', '', 'ReturnOnError', false); % format differs by one line for psplib/mmlib
end
res_avail = textscan(file_id, repmat('%d', 1, num_r_resources+num_nr_resources+num_dc_resources), 1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
res_avail = cell2mat(res_avail); % convert to numeric values


% warning: deviation from original data: remove nonrenewable and doubly constrained resource types temporarily: not supported
% to use all supported resource types, use row below and remove comment
num_nr_resources = 0; % TODO
num_dc_resources = 0; % TODO

mode_count = 0;
mode_count_row = 0;
mode_count_col = 0;
TD = zeros(num_activities, num_modes(1,1)); % pre-allocate time demand matrix
RD = zeros(num_activities, (num_r_resources+num_nr_resources+num_dc_resources) * num_modes(1,1)); % preallocate where possible



% create all necessary matrices, start with RD
for i=1:num_activities % loop through rows (activities)
        
    for j=1:num_r_resources+num_nr_resources+num_dc_resources % loop through columns (resources)
        
        for k=1:num_modes(i) % loop through modes (rows for different modes)
            RD(i,mode_count_col+k) = res_mode_dur_req(mode_count_row+k,3+j);
        end
        mode_count_col = mode_count_col + num_modes(i);
        
    end
    
    mode_count_col = 0;
    mode_count_row = mode_count_row + num_modes(i);
        
end

% also create TD
for i=1:num_activities % loop through all rows
    
    temp_row = 0; % start with a blank row, reset for each line

    for j=1:num_modes(i) % loop through modes
        
        temp_row = res_mode_dur_req(mode_count+i+j-1,:); % select actual row according to mode
        
        TD(i,j) = temp_row(1,3); % put durations of each mode in a row, n x w (modes)
    end
    
    % count modes so far as a relative offset
    mode_count = mode_count + num_modes(i) - 1; % there is always at least one mode: the row/line of given activity

end


% create initially an n x 1 CD matrix for cost demands; in case no cost data available, CD = "1" for all activities
CD = zeros(num_activities,num_modes(1,1)); % pre-allocate cost matrix nxw

constr = 0; % initialize constraint matrix constr = [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]

% get resource constraints
Cr = zeros(1,num_r_resources+num_nr_resources+num_dc_resources); % initialize resource constraint with zero (valid) value, later will be a row vector containing renewable resource(s) availability
if (num_r_resources+num_nr_resources+num_dc_resources > 0) % when there are renewable resources at all
    for i=1:num_r_resources+num_nr_resources+num_dc_resources
        Cr(1,i) = res_avail(1,i);
    end
end


% put all relevant matrices together in a PDM depending on simulation type e.g. CTP,DTP,NTP
switch sim_type
    
    case 0 % DSM only
        
        PDM=DSM; % for tests
        
    case 1 % NTP
        
        TD = TD(:,1); % for NTP, only one mode is considered with one duration column
        CD = CD(:,1); % for NTP, only one mode is considered with one cost column
        
        % for NTP, only one mode is considered with the demand of first modes for all resources
        RD = res_mode_dur_req(1:num_modes(1,1):end,4:3+num_r_resources + num_nr_resources + num_dc_resources); % see resource type flag for including/excluding non-renewable and doubly constrained type
        
        PDM = [DSM,TD,CD,RD];
        
        num_modes = 1; % for NTP we have only one mode
        
        constr = [-1,-1,Cr,-1]; % [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]
        
    case 2 % CTP
        
        % resource lower and upper values are from the first and last mode (maximum time, minimum resource)
        CD = [CD(:,1) CD(:,max(num_modes))]; % duplicate a "dummy" CD to have lower/upper range cost as n x 2 matrix, as it is not part of the original dataset/instance
        TD = [TD(:,1) TD(:,max(num_modes))]; % adapt TD to have lower/upper range as n x 2 matrix given by first mode and last mode's value
        
        RD_2 = zeros(num_activities,(num_r_resources+num_nr_resources+num_dc_resources)*2); % pre-allocate for each resources demands, upper/lower range determined by the first and last (wth) mode
        
        I = 1; % always start with 1st resource 1st mode
        % create list of indices for resource demands first and last modes for all resource types except NR and DC
        for i = 1:(num_r_resources+num_nr_resources+num_dc_resources)*num_modes(1,1)
            if (mod(i,num_modes(1,1)) < 2) && (i > 1) % select every first and last mode of each resource, e.g. with 3 resources and w=4 modes, 1,,,,4;5,,,,9,10,,,,14
                I = [I, i];
            end
        end
        
        % put resource demands of specific columns from our previous list of indices
        % RD has lower/upper range as n x nR matrix given by first mode and last mode's value
        RD_2 = RD(:,[I]);
        
        PDM = [DSM,TD,CD,RD_2];

        constr = [-1,-1,Cr,1]; % [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]
        
        if (num_modes(1,1) > 2)
            num_modes = 2; % for CTP, only two modes are considered
        end
        
    case 3 % DTP
        
        CD = zeros(num_activities, max(num_modes)); % need cost demand for all w modes
        
        % we need to remove nonrenewable and doubly constrainded resource types, as they are not supported in our simulation
        %RD = 0;
        
        PDM = [DSM,TD,CD,RD];
        
        constr = [-1,-1,Cr,1]; % [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]
        
    otherwise
        
        fprintf('Not a valid TP: only 1=NTP, 2=CTP, 3=DTP,  simulation types are supported!\n');

end

% TODO use flags to enable/disable nonrenewable and doubly constrained, and put accordingly resources in RD and determine constraints vector also
% TODO determine resource and time constraint based on RD TD and take multiple modes into account
% TODO use duration for PSPLIB only (if line_project_info present, then use as time constraint, otherwise use -1 for DTP,NTP,CTP types

num_modes = num_modes(1,1); % finally, truncate number of modes to a single value for function output

% for debug
num_activities;
num_r_resources;
num_nr_resources;
num_dc_resources;
num_successors;
max_successors;
num_columns;
num_modes;
mmlib_data;
constr;



fclose(file_id);