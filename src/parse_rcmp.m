% Patterson original description and examples: http://www.p2engine.com/p2reader/patterson_format
% RCMP (Patterson based multiproject format) description and examples: https://www.projectmanagement.ugent.be/sites/default/files/datasets/RCMPSP/Blueprint%20RCMP.txt
%  and https://www.projectmanagement.ugent.be/sites/default/files/datasets/RCMPSP/RCMPSP_DataFormat.pdf
% Summary excel for each of the below datasets containing indicators can be found in the following zip files:
%  MPSPLIB: https://www.projectmanagement.ugent.be/sites/default/files/datasets/RCMPSP/MPSPLIB.zip
%  RCMPSPLIB: https://www.projectmanagement.ugent.be/sites/default/files/datasets/RCMPSP/RCMPSPLIB.zip
%  BY: https://www.projectmanagement.ugent.be/sites/default/files/datasets/RCMPSP/BY.zip
%
% input: file with rcmp format (e.g. *.rcmp)
% example #1: PDM = parse_rcmp('test_data/mp_j120_a20_nr2.rcmp', 2) where 1=NTP, 2=CTP, 3=DTP simulation type
% example #2: PDM = parse_rcmp('test_data/BY_10_3_32.rcmp', 3) where 1=NTP, 2=CTP, 3=DTP simulation type
% output: PDM = [DSM,TD,CD,{QD,RD}] superset for each project, format depends on the selected simulation type (trade-off problem)

function [PDM, constr, num_r_resources, num_nr_resources, num_modes, num_activities, sim_type, release_dates] = parse_rcmp(file_name, sim_type)

opts = delimitedTextImportOptions;
opts.Delimiter = [" ", ":"];
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% read the data from file
rcmp_data = readmatrix(file_name, opts);
rcmp_data = str2double(rcmp_data);

% preprocessing, remove empty lines and columns
rcmp_data(all(isnan(rcmp_data),2),:) = [];
rcmp_data(:,all(isnan(rcmp_data),2)) = [];

% read number of projects from the 1st row
num_projects = rcmp_data(1,1);

% read number of renewable resources from the 2nd row
num_r_resources = rcmp_data(2,1); % all projects have the same number of resources
num_nr_resources = 0; % no non-renewable resource in this dataset
num_dc_resources = 0; % no doubly-constrained resource in this dataset

% read each renewable resources availability
for i=1:num_r_resources
    res_avail(1,i) = rcmp_data(3,i);
end

header_offset = 4;
dummy_node_offset = 1;
num_dummy_nodes = 2;

% end of static data

% get number of activities and release dates for each project
num_activities(1,1) = rcmp_data(header_offset,1); % first project is always at row 4 col 1
n(1,1) = num_activities(1,1) - num_dummy_nodes; % n is the number of activities for the given project without dummy nodes
release_dates(1,1) = rcmp_data(header_offset,2); % first project is always at row 4 col 2
for i=2:num_projects
    % excluding rows for resource assignment of the actual project
    % (2*i-2) excludes the row with actual number of activities
    num_activities(1,i) = rcmp_data(header_offset + sum(num_activities(1,1:(i-1))) + (2*i-2),1); % with dummies
    n(1,i) = num_activities(1,i) - num_dummy_nodes; % without dummies
    release_dates(1,i) = rcmp_data(header_offset + sum(num_activities(1,1:(i-1))) + (2*i-2),2);
end

% get resource selection for each projects
res_selection = zeros(num_projects, num_r_resources); % pre-allocate for speed
for i=1:num_projects
    % (2*i-1) excludes the row with actual number of activities
    res_selection(i,1:num_r_resources) = rcmp_data(header_offset + sum(num_activities(1,1:i-1)) + (2*i-1),1:num_r_resources);
end

% store matrices (sizes might be different) in a cell array
td_data = cell(num_projects,1);
rd_data = cell(num_projects,1);
num_successors_data = cell(num_projects,1);
duration_offset = 1;
successor_offset = 1;

for i=1:num_projects
    % extract durations for each task and project
    td_data{i,1} = rcmp_data(header_offset + 2 * dummy_node_offset + sum(num_activities(1,1:i-1)) + (2*i-1) : header_offset + 2 * dummy_node_offset + sum(num_activities(1,1:i)) + (2*i-4), 1);
    
    % extract resource demands for each task and project
    rd_data{i,1} = rcmp_data(header_offset + 2 * dummy_node_offset + sum(num_activities(1,1:i-1)) + (2*i-1) : header_offset + 2 * dummy_node_offset + sum(num_activities(1,1:i)) + (2*i-4), duration_offset+1 : duration_offset+num_r_resources);
    
    % extract number of successors for each task and project
    num_successors_data{i,1} = rcmp_data(header_offset + 2 * dummy_node_offset + sum(num_activities(1,1:i-1)) + (2*i-1) : header_offset + 2 * dummy_node_offset + sum(num_activities(1,1:i)) + (2*i-4), duration_offset + num_r_resources + successor_offset);
end

% extract relations for further processing of successors
local_relations = cell(num_projects,1);
inter_relations = cell(num_projects,1);
for i=1:num_projects
    temp_all_relations = rcmp_data(header_offset + 1 + sum(num_activities(1,1:i-1)) + (2*i-1) : header_offset + 3 + sum(num_activities(1,1:i)) + (2*i-4) , duration_offset + num_r_resources + successor_offset + 1 : end); % extract all (both local+inter-project) dependencies for the given project
    local_relations{i,1} = temp_all_relations(:,2:2:end); % store task dependencies, including dummy nodes
    inter_relations{i,1} = temp_all_relations(:,1:2:end); % store inter-project dependencies, including dummy nodes
end

% create binary adjacency matrix of projects based on any inter-project relationships (e.g. due to relation of dummy nodes. or any task relation between projects)
adj_matrix = zeros(num_projects);
for k=1:num_projects
    temp_inter_relations = inter_relations{k,1}; % load inter project dependencies for the current project to a temp array
    for i=1:num_activities(1,k) % iterate through rows of actual project
       for j=1:size(temp_inter_relations,2) % iterate through columns of actual project
            if (~isnan(temp_inter_relations(i,j)) && temp_inter_relations(i,j) > 0) % if it is a valid relationship
                if (temp_inter_relations(i,j) ~= k) % if the relationship is with another project
                    adj_matrix(k,temp_inter_relations(i,j)) = 1; % add any inter-project dependency
                end
            end
       end
    end
end

% sort binary adjacency matrix topologically to get the topological order of projects
[topo_order,MPDM] = toposort(digraph(adj_matrix),'Order','stable'); % keep order if possible (e.g. MPSPLIB)
MPDM = full(adjacency(MPDM)); % MPDM is the adjacency matrix of all projects topologicaly ordered
MPDM = MPDM + eye(num_projects); % where diagonal is filled with ones (flexible projects will be deleted afterwards if needed)

% re-order all data with the newly calculated topological order
local_relations = local_relations(topo_order);
inter_relations = inter_relations(topo_order);
rd_data = rd_data(topo_order);
td_data = td_data(topo_order);
release_dates = release_dates(topo_order);
res_selection = res_selection(topo_order,:);
num_successors_data = num_successors_data(topo_order); % not used
num_activities = num_activities(topo_order); % sort n to get sum of indices easier, when number of tasks is different b/w projects
n = n(topo_order);

% pre-allocate the DSM superset with ones in the diagonal
dsm_set = eye(sum(num_activities)); 

% calculate some offset constants to help filling the DSM superset
prj_offsets = cumsum([0,num_activities]); % add offsets based on number of activities (including dummies) starting with 0 for the first project
prj_offsets(end) = []; % delete unused offset at the end, to keep a valid size of vector

% go through DSM superset and set both task and inter-project dependencies including dummies
for k=1:num_projects
    
    temp_inter_relations = inter_relations{k,1}; % load inter project dependencies for the current project to a temp array
    temp_local_relations = local_relations{k,1}; % do not remove start-end dummies
    
    for i=1:num_activities(k) % iterate through rows of all projects
        for j=1:size(temp_inter_relations,2) % iterate through columns of actual project, using the fact that inter-project relations has the same size as project relations
            
            if (~isnan(temp_inter_relations(i,j)) && temp_inter_relations(i,j) > 0) % check if it is a valid relationship between projects
                
                prj = find(topo_order == temp_inter_relations(i,j)); % find new index of project in the topological order
                
                if prj == k % consider task dependencies
                    if (temp_local_relations(i,j) <= num_activities(k)) % check for out of bound task relations
                        dsm_set(prj_offsets(k)+i, prj_offsets(k)+temp_local_relations(i,j)) = 1; % add any project dependency
                    end
                end
                
                if prj > k % consider inter-project dependencies (only successors, already topologically sorted)
                    if (temp_local_relations(i,j) <= num_activities(prj)) % check for out of bound project relations
                        dsm_set(prj_offsets(k)+i, prj_offsets(prj)+temp_local_relations(i,j)) = 1; % add any inter-project dependency
                    end
                end
                
            end
        end
    end
end


% extract individual DSMs from superset
dsm_data = cell(num_projects,1);
row = 1;
for i=1:num_projects
    dsm_data{i,1} = dsm_set(row+dummy_node_offset:sum(num_activities(1,1:i))-dummy_node_offset, row+dummy_node_offset:sum(num_activities(1,1:i))-dummy_node_offset); % removing dummies from standalone DSM-s
    row = sum(num_activities(1:i)) + 1; % TODO optimize later with a lookup table for sum rather than calculating it all the time
end

% list all dummy nodes that needs to be removed (num_projects x 2)
% tasks are removed in reverse to avoid decreasing indices when deleting
tasks_to_remove = sum(num_activities); % always remove the last element
for i=numel(num_activities)-1:-1:1
    tasks_to_remove = [tasks_to_remove sum(num_activities(1,1:i))+1, sum(num_activities(1,1:i))];
end
tasks_to_remove(end+1) = 1; % also remove the first element


% step 1: find all incoming edges of dummy tasks and connect them to their successors
for i=1:numel(tasks_to_remove)
    dsm_set(tasks_to_remove(i),tasks_to_remove(i)) = 0; % put zero for the tasks to be removed
    idx = find(dsm_set(tasks_to_remove(i),:)==1); % get all successors indices (values in the same row and columns to the right)
    dsm_set(:,idx) = or(dsm_set(:,idx),dsm_set(:,tasks_to_remove(i))); % if already connected, leave it as it is, otherwise set the relationship
end
 
% step 2: remove all dummies
dsm_set(tasks_to_remove,:) = []; % mark all unnecessary incoming edges
dsm_set(:,tasks_to_remove) = []; % mark all unnecessary edges

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
        
        PDM = dsm_set; % for tests
        
    case 1 % NTP
        
        % merge DSM,TD,CD,RD into a superset PDM containing all projects
        for i=1:num_projects
            XD{i,1} = [td_data{i,1} cd_data{i,1} rd_data{i,1}];
            XD{i,1} = cat(2,XD{i,:});
        end
        
        PDM = [dsm_set, cat(1,XD{:})]; % return PDM as a merged DSM superset + TD/CD/RD/...
        
        % individual PDMs are created in a cell array (e.g. for analyzing indicators separately), ignoring inter-project relationships
        for i=1:num_projects
            pdm_data{i,1} = [dsm_data{i,1} td_data{i,1} cd_data{i,1} rd_data{i,1}];
            pdm_data{i,1} = cat(2,pdm_data{i,:});
        end
        
        constr = [-1,-1,Cr,1]; % [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]
        
        num_modes = 1; % for NTP we have only one mode

    case 2 % CTP

        % number of modes is always one in this dataset, anyway, prepare a valid format
        
        % prepare individual project data
        for i=1:num_projects
            td_ctp{i,1} = cat(2,td_data{i,:},td_data{i,:}); % duplicate TD to have lower/upper range as n x 2 matrix
            cd_ctp{i,1} = cat(2,cd_data{i,:},cd_data{i,:}); % duplicate CD to have lower/upper range as n x 2 matrix
            rd_ctp{i,1} = repelem(rd_data{i,1},1,2); % duplicate each column / resource demand to have lower/upper range as n x 2r matrix
            pdm_data{i,1} = [dsm_data{i,1} td_ctp{i,1} cd_data{i,1} rd_data{i,1}];
            pdm_data{i,1} = cat(2,pdm_data{i,:});
        end
        
        % merge DSM,TD,CD,RD into a superset PDM containing all projects
        for i=1:num_projects
            XD{i,1} = [td_ctp{i,1} cd_ctp{i,1} rd_ctp{i,1}];
            XD{i,1} = cat(2,XD{i,:});
        end
        
        PDM = [dsm_set, cat(1,XD{:})]; % return PDM as a merged DSM superset + TD/CD/RD/...

        constr = [-1,-1,Cr,1]; % [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]

        num_modes = 2; % for CTP, two modes are considered

    case 3 % DTP
        
        % number of modes is always one in this dataset, anyway, prepare a valid format
        % merge DSM,TD,CD,RD into a superset PDM containing all projects
        for i=1:num_projects
            XD{i,1} = [td_data{i,1} cd_data{i,1} rd_data{i,1}];
            XD{i,1} = cat(2,XD{i,:});
        end
        
        PDM = [dsm_set, cat(1,XD{:})]; % return PDM as a merged DSM superset + TD/CD/RD/...
        
        % individual PDMs are created in a cell array (e.g. for analyzing indicators separately), ignoring inter-project relationships
        for i=1:num_projects
            pdm_data{i,1} = [dsm_data{i,1} td_data{i,1} cd_data{i,1} rd_data{i,1}];
            pdm_data{i,1} = cat(2,pdm_data{i,:});
        end
        
        constr = [-1,-1,Cr,1]; % [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]
        
        num_modes = 1; % for DTP we also have only one mode in this dataset
        
    otherwise
        fprintf('Not a valid TP: only 1=NTP, 2=CTP, 3=DTP simulation types are supported!\n');
end

end
