% Patterson original description and examples: http://www.p2engine.com/p2reader/patterson_format
% RCMP (Patterson based multiproject format) description and examples: https://www.projectmanagement.ugent.be/sites/default/files/datasets/RCMPSP/Blueprint%20RCMP.txt
%  and https://www.projectmanagement.ugent.be/sites/default/files/datasets/RCMPSP/RCMPSP_DataFormat.pdf
% Summary excel for each of the below datasets containing indicators can be found in the following zip files:
%  MPSPLIB: https://www.projectmanagement.ugent.be/sites/default/files/datasets/RCMPSP/MPSPLIB.zip
%  RCMPSPLIB: https://www.projectmanagement.ugent.be/sites/default/files/datasets/RCMPSP/RCMPSPLIB.zip
%  BY: https://www.projectmanagement.ugent.be/sites/default/files/datasets/RCMPSP/BY.zip
%
% input: file with rcmp format (e.g. *.rcmp)
% example_1: PDM = parse_rcmp('test_data/HHH0.rcmp', 0) where 1=NTP, 2=CTP, 3=DTP simulation type
% example_2: PDM = parse_rcmp('test_data/MP-MD3.rcmp', 1) where 1=NTP, 2=CTP, 3=DTP simulation type
% example_3: PDM = parse_rcmp('test_data/mp_j120_a20_nr2.rcmp', 2) where 1=NTP, 2=CTP, 3=DTP simulation type
% example_4: PDM = parse_rcmp('test_data/BY_10_3_32.rcmp', 3) where 1=NTP, 2=CTP, 3=DTP simulation type
% output: cell containing PDM = [DSM,TD,CD,{QD,RD}] for each project, format depends on the selected simulation type (trade-off problem)

function [PDM, constr, num_r_resources, num_nr_resources, num_modes, num_activities, num_projects, sim_type] = parse_rcmp(file_name, sim_type)

opts = delimitedTextImportOptions;
opts.Delimiter = [" ", ":"];
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% read in data from file
rcmp_data = readmatrix(file_name, opts);
rcmp_data = str2double(rcmp_data);

% preprocessing, remove empty lines and columns
rcmp_data(all(isnan(rcmp_data),2),:) = [];
rcmp_data(:,all(isnan(rcmp_data),2)) = [];

% read number of projects from 1st row
num_projects = rcmp_data(1,1);

% read number of renewable resources from 2nd row
num_r_resources = rcmp_data(2,1);
num_nr_resources = 0; % no non-renewable resource in this dataset
num_dc_resources = 0; % no doubly-constrained resource in this dataset

% read renewable resources availability
for i=1:num_r_resources
    res_avail(1,i) = rcmp_data(3,i);
end

header_offset = 4;
dummy_node_offset = 1;
num_dummy_nodes = 2;

% get number of activities and release dates for each project
num_activities(1,1) = rcmp_data(header_offset,1); % first project is always at row 4 col 1
n(1,1) = num_activities(1,1) - num_dummy_nodes;
release_dates(1,1) = rcmp_data(header_offset,2); % first project is always at row 4 col 2
for i=2:num_projects
    % (i-1) excludes rows with the resource assignment for the actual project
    % (2*i-2) excludes row of actual num_activities
    num_activities(1,i) = rcmp_data(header_offset + (i-1) * num_activities(1,(i-1)) + (2*i-2),1);
    n(1,i) = num_activities(1,i) - num_dummy_nodes;
    release_dates(1,i) = rcmp_data(header_offset + (i-1) * num_activities(1,(i-1)) + (2*i-2),2);
end

% get resource selection for each projects
for i=1:num_projects
    % (i-1) excludes rows with the resource assignment for the actual project
    % (2*i-1) excludes row of actual num_activities
    res_selection(i,1:num_r_resources) = rcmp_data(header_offset + (i-1) * num_activities(1,i) + (2*i-1),1:num_r_resources);
end

% store matrices (could be of a different size) in a cell array
td_data = cell(num_projects,1);
rd_data = cell(num_projects,1);
num_successors_data = cell(num_projects,1);
duration_offset = 1;
successor_offset = 1;

for i=1:num_projects
    % extract durations for each task and project
    td_data{i,1} = rcmp_data(header_offset + 2 * dummy_node_offset + (i-1) * num_activities(1,i) + (2*i-1) : header_offset + 2 * dummy_node_offset + (i-1) * num_activities(1,i) + (2*i-4) + num_activities(1,i),1);
    
    % extract resource demands for each task and project
    rd_data{i,1} = rcmp_data(header_offset + 2 * dummy_node_offset + (i-1) * num_activities(1,i) + (2*i-1) : header_offset + 2 * dummy_node_offset + (i-1) * num_activities(1,i) + (2*i-4) + num_activities(1,i),duration_offset+1:duration_offset+num_r_resources);
    
    % extract number of successors for each task and project
    num_successors_data{i,1} = rcmp_data(header_offset + 2 * dummy_node_offset + (i-1) * num_activities(1,i) + (2*i-1) : header_offset + 2 * dummy_node_offset + (i-1) * num_activities(1,i) + (2*i-4) + num_activities(1,i),duration_offset + num_r_resources + successor_offset);
end

% extract relations for further processing of successors
relations_data = cell(num_projects,1);
inter_relations = cell(num_projects,1);
for i=1:num_projects
    temp_relations = rcmp_data(header_offset + 2 * dummy_node_offset + (i-1) * num_activities(1,i) + (2*i-1) : header_offset + 2 * dummy_node_offset + (i-1) * num_activities(1,i) + (2*i-4) + num_activities(1,i),duration_offset + num_r_resources + successor_offset + 1 : end);
    inter_relations{i,1} = temp_relations(:,1:2:end); % store inter-project relations
    relations_data{i,1} = temp_relations(:,2:2:end); % store task dependencies
end

% construct DSM for each project
dsm_data = cell(num_projects,1);
for k=1:num_projects
    
    temp_relations = relations_data{k,1}; % load actual project into a temp array
    temp_dsm = 0; % reset temp array
    
    for i=1:n(1,k) % iterate through rows
        
        temp_dsm(i,i) = 1; % put "1" on diagonal for each fix activity node
        
        for j=1:size(temp_relations,2) % iterate through # of columns
            
            if (temp_relations(i,j) > i) % consider successor activities only (upper triangle) also exclude zeros
                
                if (temp_relations(i,j) <= n(1,k) + dummy_node_offset) % exclude end activity
                    
                    activity_index = temp_relations(i,j) - dummy_node_offset; % use offset for dummy end node
                    temp_dsm(i,activity_index) = 1; % put "1" for each line between two nodes
                    
                end
            end
        end
    end    
    dsm_data{k,1} = temp_dsm;
end


% make a check and give warning if there is an actual dependency between projects as it is not yet supported
for i=1:num_projects
    idx = find(inter_relations{i,1}(:,:) ~= i & ~isnan(inter_relations{i,1}(:,:)));
    if size(idx)
        warning('at least one task have inter-project dependency (linear index %d), not yet supported by the parser!\n', idx(1));
    end
end
% TODO consider inter-project relations of tasks (currently not present in any of the databases, but the possibility is there)

% initialize default constraint row vector
constr = 0; % initialize constraint matrix, constr = [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]
num_modes = 1; % no multi-mode multi-project dataset existing in this format

% get resource constraints, Cr is the row vector of resource constraints
Cr = 0; % initialize resource constraint with zero (valid) value, later will be a row vector containing renewable resource(s) availability
if (num_r_resources > 0) % when there are renewable resources only
    for i=1:num_r_resources
        Cr(1,i) = res_avail(1,i);
    end
end

% prepare multiproject versions (cell arrays) of PDM,DSM,CD,TD,RD
cd_data = cell(num_projects,1); % pre-allocate
for i=1:num_projects
    cd_data{i,1} = zeros(n(1,i),1);
end

% return with number of activities excluding dummies
num_activities = n;

% put all relevant matrices together in a PDM depending on simulation type e.g. CTP,DTP,NTP
switch sim_type
    
    case 0 % debug, DSM only
        
        PDM = dsm_data; % for tests
        
    case 1 % NTP
        
        % merge DSM,TD,CD,RD into PDM for each projects
        for i=1:num_projects
            PDM{i,1} = [dsm_data{i,1} td_data{i,1} cd_data{i,1} rd_data{i,1}];
            PDM{i,1} = cat(2,PDM{i,:});
        end
        
        constr = [-1,-1,Cr,1]; % [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]

    case 2 % CTP

        % number of modes is always one in this dataset, anyway, prepare a valid format
        
        for i=1:num_projects
            td_ctp{i,1} = cat(2,td_data{i,:},td_data{i,:}); % duplicate TD to have lower/upper range as n x 2 matrix
            cd_ctp{i,1} = cat(2,cd_data{i,:},cd_data{i,:}); % duplicate CD to have lower/upper range as n x 2 matrix
            rd_ctp{i,1} = repelem(rd_data{i,1},1,2); % duplicate each column / resource demand to have lower/upper range as n x 2r matrix
            PDM{i,1} = [dsm_data{i,1} td_ctp{i,1} cd_data{i,1} rd_data{i,1}];
            PDM{i,1} = cat(2,PDM{i,:});
        end
        
        constr =  [-1,-1,Cr,1]; % [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]

        sim_type = -1; % indicate that this type is not supported for rcmp datasets

    case 3 % DTP
        
        % number of modes is always one in this dataset, anyway, prepare a valid format
        % merge DSM,TD,CD,RD into PDM for each projects
        for i=1:num_projects
            PDM{i,1} = [dsm_data{i,1} td_data{i,1} cd_data{i,1} rd_data{i,1}];
            PDM{i,1} = cat(2,PDM{i,:});
        end
        
        constr = [-1,-1,Cr,1]; % [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]
        
        sim_type = -1; % indicate that this type is not supported for rcmp datasets
        
    otherwise
        fprintf('Not a valid TP: only 1=NTP, 2=CTP, 3=DTP,  simulation types are supported!\n');
end

end