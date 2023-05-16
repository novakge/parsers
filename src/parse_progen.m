% ProGen(/Max) instance generator website: http://www.om-db.wi.tum.de/psplib/generate.html
% PSPLIB standard dataset website: http://www.om-db.wi.tum.de/psplib/data.html
% MRCPSP/Max format description: https://www.wiwi.tu-clausthal.de/fileadmin/Produktion/Benchmark/MRCPSP/input_format.pdf
% input: file with sch (Progen) format (e.g. *.sch)
% example: PDM = parse_progen('test_data/MMRCPSP463.sch', 3) where 1=NTP, 2=CTP, 3=DTP simulation type, 0 = debug (DSM only)
% output: PDM file containing PDM = [DSM,TD,CD,{QD,RD}], format depending on the selected simulation type (trade-off problem)

function [PDM, constr, num_r_resources, num_nr_resources, num_modes, num_activities, sim_type] = parse_progen(file_name, sim_type)

file_id = fopen(file_name,'r');

% search full text line by line, find/store main reference line numbers to handle flexible formats (MMLIB,PSPLIB)
act_line = fgetl(file_id); % initialize by reading the first line
line_header = 1; % n = number of jobs is always at the first, header line

% determine number of activities from first line
delimiter = {'\t'};
frewind(file_id);
formatSpec = '%d%d%d%d%*[^\n\r]';
header_info = textscan(file_id, formatSpec, line_header, 'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
% sort header values of # of activities, # of resources from the array just read to meaningful variables
num_activities = cell2mat(header_info(1));
num_r_resources = cell2mat(header_info(2));
num_nr_resources = cell2mat(header_info(3));
num_dc_resources = cell2mat(header_info(4));

line_activities = 3; % skip dummy activity on line #2

% retrieve the upper bound (nxn) matrix based on successors --> graph is acyclic, so any activity can only have n-1 successors, and needs to be doubled because of arcs' weights' info --> 2 x (n-1)
delimiter = {'\t'};
frewind(file_id);
formatSpecRep=repmat('%s',1,2*(num_activities-1));
formatSpec = strcat(formatSpecRep, '%*[^\n\r]');
progen_data = textscan(file_id, formatSpec, num_activities, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines', line_activities-1, 'ReturnOnError', false, 'EndOfLine', '\r\n', 'CollectOutput', false);

% copy successors data to a string array
for i=1:num_activities
    for j=1:num_activities % now without weight info
        successor_data(j,i) =  progen_data{i}(j);
    end
end

% extract the number of modes for each activity
num_modes = double(successor_data(:,2));

% extract the number of successors for each activity
num_successors = double(successor_data(:,3));

% trim the activity-relation data for successors only
for i=1:num_activities
    successor_matrix(i, num_successors(i)) = double(successor_data(i, 3+num_successors(i)));
end

% TODO: create matrix for arc weights also based on e.g. [1 2 3 32 4] info stored (Progen-->MAX)

% pre-allocate n x n design structure matrix as output
DSM = zeros(num_activities,num_activities); 

for i=1:num_activities % iterate through rows
    
    DSM(i,i) = 1; % put "1" on diagonal for each fix activity node
    
    for j=1:size(successor_matrix,2) % iterate through # of columns
        
        if (successor_matrix(i,j) > i) % consider successor activities only (upper triangle) also exclude zeros
            
            if (successor_matrix(i,j) <= num_activities + 1) % exclude end activity
                
                activity_index = successor_matrix(i,j) - 1; % use offset for dummy end node
                DSM(i,activity_index) = 1; % put "1" for each line between two nodes
                
            end
        end
    end
end

% we already can calculate the start of activity duration/mode info array:
line_modes_durations = line_header + num_activities + 3; % 1 header line + 2 dummy activites in activities/successors array + 1 dummy at the start of duration/mode array = 3


% scan durations, resource modes and requirement matrix for all modes
delimiter = {'\t','    ','         '};
frewind(file_id); % need to rewind text read pointer
textscan(file_id, '%[^\n\r]', line_modes_durations, 'WhiteSpace', '', 'ReturnOnError', false);
% determine formatspec dynamically based on number of resource columns for all rows determined by #modes x #activities
res_mode_dur_req = textscan(file_id, repmat('%d', 1, num_r_resources+num_nr_resources+num_dc_resources+3), sum(num_modes), 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', 0, 'ReturnOnError', false, 'EndOfLine', '\r\n');
res_mode_dur_req = cell2mat(res_mode_dur_req); % convert to numeric values
% NOTE: in case of new formats, first column need to be considered. When modes >1, the first column (job#) is empty -> must be zero when parsed.

line_res_avail = line_modes_durations + num_activities * num_modes(1,1) + 1; % resource availabilities are at the end

% scan resource availabilities matrix
delimiter = {'  ','\t',' '};
frewind(file_id);
textscan(file_id, '%[^\n\r]', line_res_avail, 'WhiteSpace', '', 'ReturnOnError', false); % format differs by one line for psplib/mmlib
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
num_modes;
constr;



fclose(file_id);
