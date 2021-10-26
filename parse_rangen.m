% patterson format description and examples: http://www.p2engine.com/p2reader/patterson_format
% already available results for comparison:
% -> all data: http://www.projectmanagement.ugent.be/sites/default/files/files/datasets/AboutData.zip
% -> summary excel including indicators: http://www.projectmanagement.ugent.be/sites/default/files/files/datasets/Datasets%20with%20Parameters%20and%20BKS.xlsx
% input: file with patterson format (e.g. *.rcp, *.prb)
% example: PDM = parse_rangen('test_data/pat80.rcp', 2) where 1=NTP, 2=CTP, 3=DTP simulation type
% output: PDM file containing PDM = [DSM,TD,CD,{QD,RD}], format depending on the selected simulation type (trade-off problem)

function [PDM, constr, num_r_resources, num_nr_resources, num_modes, num_activities, sim_type] = parse_rangen(file_name, sim_type)

% define constants
num_dummy_nodes = 2;
dummy_node_offset = 1;
duration_offset = 1;
successors_offset = 1;

% read raw input data in matrix
rangen_data = dlmread(file_name);

% get info from header
num_activities = rangen_data(1) - num_dummy_nodes; % store number of activities and exclude dummy activities (start/end node)
num_r_resources = rangen_data(1,2); % store number of renewable resources
num_nr_resources = 0; % no non-renewable resources present in this dataset
res_avail = rangen_data(2,1:num_r_resources); % store resources' availabilities

% rg300 related offsets
unwrapped_successors = 20; % maximal number of successors listed at a line
successors_offset = duration_offset + num_r_resources + successors_offset;
wrap_flag = 1;

% handle exceptions where 20+ successors present, but are not wrapped in newline
if size(rangen_data,2) > (successors_offset + unwrapped_successors)
    wrap_flag = 0; % successors are not wrapped into newline(s), e.g. patterson #141
end
        
row_orig = 1; % index used for input data
row_new = 1; % index used for output data
pos_col = unwrapped_successors + successors_offset; % merging position of successors

if (wrap_flag == 1) % wrap limit not reached or wrapped lines present
    
    rangen_data = rangen_data(3:end - dummy_node_offset,:); % remove header lines and dummy activities (start/end node)
    
    % conversion needed due to newline characters that are wrapping long lines in RG300 data
    while row_orig <= size(rangen_data,1) % go through rows of original data
        num_successors = rangen_data(row_orig,successors_offset); % check the number of successors for the given activity
        temp_data(row_new,1:size(rangen_data,2)) = rangen_data(row_orig,:); % copy the the first actual row for the given activity
        num_lines = ceil(num_successors/(unwrapped_successors)) - 1; % check if and how many newlines we need to consider for successors e.g. 72/20=3.6 -> 4-1 extra lines, 40/20=2 -> 2-1 extra line
        
        for i=1:num_lines % merge extra lines to the end of the activity's current line
            temp_data(row_new,pos_col+1:pos_col+unwrapped_successors) = rangen_data(row_orig+i,1:unwrapped_successors); % merge to the end of current activity's (row) successor list
            pos_col = pos_col + unwrapped_successors; % prepare position for the next line
        end
        
        row_new = row_new + 1; % increment row index of output
        pos_col = unwrapped_successors + successors_offset; % reset position back to the end of next activity's row
        row_orig = row_orig+num_lines + 1; % next row
    end
    
    rangen_data = temp_data(2:end,:); % replace original data with the one already processed, skipping first dummy activity, different for RG300

else % no wrapped lines
    rangen_data = rangen_data(4:end - dummy_node_offset,:); % remove header lines and dummy activities (start/end node)
end

% create TD matrix for durations
TD = rangen_data(:,1); % store column vector with task durations

% create RD matrix for resource requirements
RD = rangen_data(:,1+duration_offset : num_r_resources + duration_offset);

% create CD matrix for cost demands; in this case CD = 1 for all
CD = zeros(num_activities,1);

rangen_data = rangen_data(:,successors_offset + 1:end); % remove activity durations and resource requirements (columns 1 to n where n is number of resources)

DSM = zeros(num_activities,num_activities); % pre-allocate n x n design structure matrix as output

for i=1:num_activities % iterate through rows
    
    DSM(i,i) = 1; % put "1" on diagonal for each fix activity node
    
    for j=1:size(rangen_data,2) % iterate through # of columns
        
        if (rangen_data(i,j) > i) % consider successor activities only (upper triangle) also exclude zeros
            
            if (rangen_data(i,j) <= num_activities + dummy_node_offset) % exclude end activity
                
                activity_index = rangen_data(i,j) - dummy_node_offset; % use offset for dummy end node
                DSM(i,activity_index) = 1; % put "1" for each line between two nodes
                
            end
        end
    end
end

% initialize default constraint row vector
constr = 0; % initialize constraint matrix, constr = [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]
num_modes = 1; % RanGen is a single mode dataset

% get resource constraints, Cr is the row vector of resource constraints
Cr = 0; % initialize resource constraint with zero (valid) value, later will be a row vector containing renewable resource(s) availability
if (num_r_resources > 0) % when there are renewable resources at all
    for i=1:num_r_resources
        Cr(1,i) = res_avail(1,i);
    end
end

% pre-allocate PDM for NTP
PDM = zeros(num_activities,num_activities+duration_offset+num_r_resources);

% put all relevant matrices together in a PDM depending on simulation type e.g. CTP,DTP,NTP
switch sim_type
    
    case 0 % debug, DSM only
        
        PDM=DSM; % for tests
        
    case 1 % NTP
        
        PDM = [DSM,TD,CD,RD];
        constr = [-1,-1,Cr,1]; % [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]

        
    case 2 % CTP
        
          % number of modes is always one in this dataset, anyway, prepare a valid format
          TD = [TD, TD]; % duplicate TD to have lower/upper range as n x 2 matrix
          CD = [CD, CD]; % duplicate CD to have lower/upper range as n x 2 matrix
          RD = repelem(RD,1,2); % duplicate each column / resource demand to have lower/upper range as n x 2r matrix
          PDM = [DSM,TD,CD,RD];
          constr =  [-1,-1,Cr,1]; % [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]

          sim_type = -1; % indicate that this type is not supported for rangen
        
    case 3 % DTP
        
        % number of modes is always one in this dataset, anyway, prepare a valid format
        PDM = [DSM,TD,CD,RD]; % number of modes is always one in this dataset, so leave it as it is
        
        constr = [-1,-1,Cr,1]; % [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]
        
        sim_type = -1; % indicate that this type is not supported for rangen
        
    otherwise
        fprintf('Not a valid TP: only 1=NTP, 2=CTP, 3=DTP,  simulation types are supported!\n');
end

% print all variables for debugging
% rangen_data
% num_activities
% num_r_resources
% num_modes
% res_avail 
% DSM
% TD
% CD
% RD
% PDM


end