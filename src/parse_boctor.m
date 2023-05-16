% Boctor standard dataset website: http://www.om-db.wi.tum.de/psplib/dataob.html
% input: file with prb (Boctor) format (e.g. *.prb)
% example: PDM = parse_boctor('test_data/boct228.prb', 3) where 1=NTP, 2=CTP, 3=DTP simulation type, 0 = debug (DSM only)
% output: PDM file containing PDM = [DSM,TD,CD,{QD,RD}], format depending on the selected simulation type (trade-off problem)

function [PDM, constr, num_r_resources, num_nr_resources, num_modes, num_activities, sim_type] = parse_boctor(file_name, sim_type)

file_id = fopen(file_name,'r');

% search full text line by line, find/store main reference line numbers to handle flexible formats
act_line = fgetl(file_id); % initialize by reading the first line
line_header = 1; % n = number of jobs is always at the first, header line

% determine number of activities from first line
delimiter = {'\t'};
frewind(file_id);
formatSpec = '%d%d%d%d%*[^\n\r]';
header_info = textscan(file_id, formatSpec, line_header, 'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
% sort header values of # of activities, # of resources from the array just read to meaningful variables
num_activities = cell2mat(header_info(1));
num_r_resources = cell2mat(header_info(2)); % only renewable resources in this dataset
num_nr_resources = 0; % not supported in this dataset
num_dc_resources = 0; % not supported in this dataset

line_activities = 3; % skip empty line #2
modes_upperbound = 4; % define the maximum 4 modes (Boctor)
% retrieve the upper bound (nxn) matrix based on predecessors --> graph is acyclic, so any activity can only have n-1 predecessors
delimiter = {'\t'};
frewind(file_id);
formatSpecRep=repmat('%s',1,1+num_activities-1+1+modes_upperbound+(modes_upperbound*num_r_resources)); % number of modes and predecessors are fixed columns = 2 + n-1 (possible relations) + duration*modes + resources*modes
formatSpec = strcat(formatSpecRep, '%*[^\n\r]');
boctor_data = textscan(file_id, formatSpec, num_activities, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines', line_activities-1, 'ReturnOnError', false, 'EndOfLine', '\r\n', 'CollectOutput', false);

% retrieve resource availabilities (constraints)
line_res_avail = num_activities + 1; % resource availabilities are at the end of the dataset
% scan resource availabilities matrix
delimiter = {'  ','\t',' '};
frewind(file_id);
textscan(file_id, '%[^\n\r]', line_res_avail, 'WhiteSpace', '', 'ReturnOnError', false);
res_avail = textscan(file_id, repmat('%d', 1, num_r_resources+num_nr_resources+num_dc_resources), 1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
res_avail = cell2mat(res_avail); % convert to numeric values 

% copy the main data (without header+footer) to a string array
for i=1:1+num_activities-1+1+(modes_upperbound*num_r_resources)+modes_upperbound  % as we also need the modes (2 fix columns + n-1 relations = n+1)
    for j=1:num_activities
        main_data(j,i) =  boctor_data{i}(j); % do not convert yet to double, to keep empty cells
    end
end

% extract the number of successors for each activity
num_ancestors = double(main_data(:,1)); % always in the first column

% extract the number of modes for each activity
for i=1:num_activities
    num_modes(i,1) = double(main_data(i,2+num_ancestors(i,1))); % when no predecessors: start already at column #2, otherwise with the number of predecessors as an offset
end

% determine maximum number of successors
max_ancestors = max(num_ancestors);

% determine maximum number of modes
max_modes = max(num_modes);

% trim the activity-relation data for predecessors only
for i=1:num_activities % n-1 predecessor
    if num_ancestors(i,1) > 0 % only activities with predecessor
        ancestor_matrix(i,1:num_ancestors(i,1)) = double(main_data(i,2:1+num_ancestors(i,1)));
    end
end


% DSM part
% pre-allocate n x n design structure matrix as output
DSM = zeros(num_activities,num_activities); 

for i=num_activities:-1:1 % iterate through rows, backward pass due to predecessor info
    
    DSM(i,i) = 1; % put "1" on diagonal for each fix activity node
    
    for j=1:max_ancestors
        
        if (ancestor_matrix(i,j) > 0) % if two nodes are connected
            
            activity_index = ancestor_matrix(i,j);
            DSM(activity_index,i) = 1; % put "1" for each line between two nodes
        end
        
    end
end

% TD, RD part
TD = zeros(num_activities, max_modes); % pre-allocate time demand matrix
RD = zeros(num_activities, (num_r_resources+num_nr_resources+num_dc_resources) * max_modes); % pre-allocate resource demand matrix
TD_RD = zeros(num_activities, (num_r_resources+num_nr_resources+num_dc_resources) * max_modes + max_modes); % pre-allocate time + resource demand container matrix

% define some static offsets for better readability
fix_mode_offset = 1;
fix_ancestor_offset = 1;
fix_td_rd_offset = fix_ancestor_offset + fix_mode_offset;

% extract all necessary matrices from main content to a combined TD+RD matrix
for i=1:num_activities % loop through all rows
    for j=fix_td_rd_offset+num_ancestors(i)+1:fix_td_rd_offset+num_ancestors(i)+num_modes(i)*(num_r_resources+num_nr_resources+num_dc_resources)+num_modes(i) % w x TD, w x #RD
        TD_RD(i,j-fix_td_rd_offset-num_ancestors(i)) = double(main_data(i,j)); % select the i-th row of original data and put it to a new row vector to be sorted
    end
end


% extract TD
TD = TD_RD(:,1:num_r_resources+num_nr_resources+num_dc_resources+1:end); % extract TD part only, skip the first and every (1+#resources)th column

% extract RD by deleting TD
RD = TD_RD; % prepare to delete from the combined matrix
RD(:,1:num_r_resources+num_nr_resources+num_dc_resources+1:end) = []; % for RD, delete TD part, skip the first and every (1+#resources)th column

% reorder RD for our simulation format, order resource(s) by mode(s) (instead of original format mode(s) by resource(s))
indices = [];
for i=1:num_r_resources
    for j=i:num_r_resources:max_modes*num_r_resources
        indices = [indices j];
    end
end
% finally, extract the pre-selected indices thus rearrange RD to new matrix
RD_sorted = RD(:,indices);

% create initially an n x 1 CD matrix for cost demands; in case no cost data available, CD = "1" for all activities
CD = zeros(num_activities, max_modes); % pre-allocate cost matrix nxw

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
        
        % for NTP, only one mode is considered with the demand of first modes for all resource types
        RD = RD(:,1:num_r_resources+num_nr_resources+num_dc_resources); % see resource type flag for including/excluding non-renewable and doubly constrained type
        
        PDM = [DSM,TD,CD,RD];
        
        num_modes = 1; % for NTP we have only one mode
        
        constr = [-1,-1,Cr,-1]; % [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]

    case 2 % CTP
        
        % resource lower and upper values are from the first and last mode (maximum time, minimum resource)
        CD = [CD(:,1) CD(:,num_modes)]; % duplicate a "dummy" CD to have lower/upper range cost as n x 2 matrix, as it is not part of the original dataset/instance
        % Note: there might fewer modes (even single), so use max() instead, first mode is always the shortest in Boctor1993
        TD = [TD(:,1) max(TD,[],2)]; % adapt TD to have lower/upper range as n x 2 matrix given by first mode and last mode's value
        
        RD2 = zeros(num_activities,(num_r_resources+num_nr_resources+num_dc_resources)*2); % pre-allocate for each resources demands, upper/lower range determined by the first and last (wth) mode
        
        write_col = 0; % init store index
        read_col = 0; % init read index
        
        
        for i=1:num_activities % iterate on activities
            
            write_col = 1; % for every activity, store first mode in the first column
            read_col = 1; % note the current mode and resource status
            
            for j=1:num_r_resources % iterate on resource(s)
                
                for k=1:num_modes(i) % iterate on variable mode(s)
                    
                    if k == 1 % always store the first mode
                        RD2(i, write_col) = RD_sorted(i,read_col); % store the actual resource demand for the first mode of the activity
                        % DEBUG: fprintf('a.) RD_sorted(%d,%d) written to RD2(%d,%d)-be\n', i, read_col, i, write_col);
                        read_col = read_col + num_modes(i) - 1; % take care of additional modes index, variable modes format
                        write_col = write_col + 1; % jump to the next column in output
                    end
                    
                    if mod(k,num_modes(i)) == 0 % store the last mode of the same resource, if only 1 mode, then store it twice
                        RD2(i,write_col) = RD_sorted(i,read_col);
                        % DEBUG: fprintf('b.) RD_sorted(%d,%d) written to RD2(%d,%d) \n', i, read_col, i, write_col);
                        write_col = write_col + 1; % only formally update, as we store only two modes for CTP
                        read_col = j*max_modes + 1; % jump to the next block (fixed mode format)
                    end
                    
                end
            end
        end

        PDM = [DSM,TD,CD,RD2];

        constr = [-1,-1,Cr,1]; % [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]
        
        num_modes = 2; % for CTP, two modes are considered
        
    case 3 % DTP
        
        CD = zeros(num_activities, max_modes); % need cost demand for all w modes
        
        % nonrenewable and doubly constrainted resource types are not supported in Boctor dataset / our simulation
        % RD = 0;
               
        PDM = [DSM,TD,CD,RD_sorted];
        
        constr = [-1,-1,Cr,1]; % [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]
        
        % number of modes is varied in this dataset, so the average number of modes also makes sense
        num_modes = max_modes; % finally, give the maximal number of modes (varied) as a single value for function output
        num_avg_modes = mean(num_modes);
        
    otherwise
        
        fprintf('Not a valid TP: only 1=NTP, 2=CTP, 3=DTP,  simulation types are supported!\n');

end

% for debug
num_activities;
num_r_resources;
num_nr_resources;
num_dc_resources;
num_ancestors;
num_modes;
constr;



fclose(file_id);
