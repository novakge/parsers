% patterson format description and examples: http://www.p2engine.com/p2reader/patterson_format
% already available results for comparison:
% -> all data: http://www.projectmanagement.ugent.be/sites/default/files/files/datasets/AboutData.zip
% -> summary excel including indicators: http://www.projectmanagement.ugent.be/sites/default/files/files/datasets/Datasets%20with%20Parameters%20and%20BKS.xlsx
% input: file with patterson format (e.g. *.rcp, *.prb)
% example: PDM = parse_rangen('test_data/pat80.rcp', 2) where 1=NTP, 2=CTP, 3=DTP simulation type
% output: PDM file containing PDM = [DSM,TD,CD,{QD,RD}], format depending on the selected simulation type (trade-off problem)

function [PDM, constr, num_r_resources, num_modes, num_activities, sim_type] = parse_rangen(file_name, sim_type)

% define constants
num_dummy_nodes = 2;
dummy_node_offset = 1;
duration_offset = 1;
successors_offset = 1;

% read raw input data in matrix
rangen_data = dlmread(file_name);

num_activities = rangen_data(1) - num_dummy_nodes; % store number of activities and exclude dummy activities (start/end node)
num_r_resources = rangen_data(1,2); % store number of renewable resources
res_avail = rangen_data(2,1:num_r_resources); % store resources' availabilities

rangen_data = rangen_data(4:end - dummy_node_offset,:); % remove header lines and dummy activities (start/end node) for better indices

% create TD matrix for durations
TD = rangen_data(:,1); % store column vector with task durations

% create RD matrix for resource requirements
RD = rangen_data(:,1+duration_offset : num_r_resources + duration_offset);

% create CD matrix for cost demands; in this case CD = 1 for all
CD = zeros(num_activities,1);

rangen_data = rangen_data(:,duration_offset + num_r_resources + successors_offset + 1:end); % remove activity durations and resource requirements (columns 1 to n where n is number of resources)

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