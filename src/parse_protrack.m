% Matlab parser supporting ProTrack format (*.p2x) for real life project database files
% Project data: http://www.projectmanagement.ugent.be/?q=research/data/realdata
% Useful tool for reading xml files: https://www.samltool.com/prettyprint.php
% Input: file with ProTrack format (*.p2x)
% Example: >> PDM = parse_protrack('data/protrack/C2011-09 Commercial IT Project.p2x',1)
% output: PDM file containing PDM = [DSM,TD,CD,{QD,RD}], format depending on the selected simulation type (trade-off problem)
% Hint: to easily prepare e.g. test files, Excel<->ProTrack converter can be found at http://ghbonne.github.io/PMConverter
function [PDM, constr, num_r_resources, num_nr_resources, num_modes, num_activities, sim_type] = parse_protrack(file_name, sim_type)

% read xml as object from file
xml = xmlread(file_name);

%%% prepare global variables
% get node used for accessing the activity properties
act = xml.getElementsByTagName('Activity');

% get number of total activities = n
act_tree = xml.getElementsByTagName('Activities'); % "Activity" nodes are not unique throughout the xml, need to check childs of "Activities" instead
act_nodes = act_tree.item(1).getChildNodes; % get the second one and its child nodes
num_activities = act_nodes.getLength;

% get number of resources = r
res = xml.getElementsByTagName('Resource');
num_r_resources = res.getLength;
num_nr_resources = 0; % no non-renewable resources present in this dataset

% get number of resource assignments
res_assign = xml.getElementsByTagName('ResourceAssignment');
num_res_assignment = res_assign.getLength;

% get number of relationships
relations = xml.getElementsByTagName('Relations');
num_relations = relations.item(1).getLength; % there are more relations than tasks, so recalculate size, there is another relations field before the one we need -> skip

%%% pre-allocate data matrices
project_data = zeros(num_activities,6); % pre-allocate n x 6 matrix for all related project data
offset_data = zeros(num_activities,2); % pre-allocate n x 2 matrix for ids and their offsets
unit_cost_data = zeros(num_r_resources,2); % pre-allocate r x 2 matrix for total resource costs per task in a separate matrix
resource_data = zeros(num_activities,1+num_r_resources); % store resources and their data in a separate matrix

%%% parse and calculate data
% get xml -> activities -> activity #i -> ID, start time, duration, fixedcost
for i=0:num_activities - 1 % java style indexing, starting from zero
    
    project_data(i+1,1) = i+1; % robustness improvement, initialize artificial IDs in the first column upfront ignoring missing tasks and only storing offset for them (workaround for continuity error in original project plan)
    
    node = act.item(i).getElementsByTagName('UniqueID');
    unique_id_node = str2num(node.item(1).getTextContent); % there is another UniqueID before the one we need, skip it
    
    offset_data(i+1,1) = i+1; % put orders redundantly in column 1 just to show for debug
    offset_data(unique_id_node,2) = i+1; % robustness improvement, save all id-offset pair to repair issues later with original project data (continuity, jumps, offsets)
    
    node = act.item(i).getElementsByTagName('BaseLineStart');
    project_data(i+1,2) = convert_protrack_time(char(node.item(0).getTextContent)); % convert activity start dates to numeric values and store absolute start dates

    node = act.item(i).getElementsByTagName('BaseLineDuration');
    project_data(i+1,3) = str2num(node.item(0).getTextContent); % get activity durations
    
    node = act.item(i).getElementsByTagName('FixedBaselineCost');
    project_data(i+1,4) = str2num(node.item(0).getTextContent);
    
    node = act.item(i).getElementsByTagName('BaselineCostByUnit');
    project_data(i+1,5) = str2num(node.item(0).getTextContent);
    
    
end

% repair offset data first column when there was any missing activities for better overview
for i=1:size(offset_data,1)
    offset_data(i) = i; % put ID for all missing activities afterwards we have all the valid IDs stored
end

% get each resources' availability
for i=0:num_r_resources - 1 % java style indexing, starting from zero
    res_avail_node = res.item(i).getElementsByTagName('FIELD780'); % FIELD780 = resource availability e.g. programmers = 3 person

    res_avail(1,i+1) = str2num(res_avail_node.item(0).getTextContent);
end

% get unit cost of each resource to calculate with
for i=0:num_r_resources - 1 % java style indexing, starting from zero
    res_id_node = res.item(i).getElementsByTagName('FIELD0'); % FIELD0 = resource ID e.g. 1 = programmers
   
    unit_cost_node = res.item(i).getElementsByTagName('FIELD771'); % FIELD771 = resource unit cost
    
    unit_cost_data(i+1,1) = i+1; % put all IDs in original order in first column
    unit_cost_data(i+1,1) = str2num(res_id_node.item(0).getTextContent); % overwrite with resource IDs in first column
    unit_cost_data(i+1,2) = str2num(unit_cost_node.item(0).getTextContent); % put resources unit costs in second column
end

% parse all resources and their costs
for i=0:num_res_assignment - 1 % java style indexing, starting from zero
    task_id_node = res_assign.item(i).getElementsByTagName('FIELD1024'); % FIELD1024 = assigned task ID
    res_id_node = res_assign.item(i).getElementsByTagName('FIELD1025'); % FIELD1025 = resource ID e.g. 1 = programmer
    res_demand_node = res_assign.item(i).getElementsByTagName('FIELD1026'); % FIELD1026 = resource demand e.g. 0.5 programmer
    
    if i+1 <= num_activities % there are more resource assignments than activities
        resource_data(i+1,1) = i+1; % put all IDs in original order in first column
    end
   
    % task id, resource id, resource demand node should be a positive number
    if ( (str2num(task_id_node.item(0).getTextContent) > 0) && (str2num(res_id_node.item(0).getTextContent) > 0) && (str2num(res_demand_node.item(0).getTextContent) > 0) )
        
        resource_data(offset_data(str2num(task_id_node.item(0).getTextContent),2), 1 + str2num(res_id_node.item(0).getTextContent)) = str2num(res_demand_node.item(0).getTextContent); % put resource's demands in their respective ID's column e.g. task#3 in row 3 has resource#5 in column 6 (because of first column with order) with demand of 0.5 
    else
        % should never happen, but handle exception and skip invalid assignments (e.g. C2012-01 Manufacturing Tool Cost Module.p2x)
        fprintf('WARNING: invalid resource assignment present for task: #%d ! \n',str2num(task_id_node.item(0).getTextContent)) % send a warning on invalid assignment info
    end
end

% calculate total cost for each task and resource
for i=1:num_activities
    total_res_cost = 0;
    for j=1:num_r_resources
        total_res_cost = total_res_cost + resource_data(i,j+1) * unit_cost_data(j,2);
    end
        
    project_data(i,6) = project_data(i,3) * total_res_cost; % resource cost = duration * sum of resource costs
    project_data(i,7) = project_data(i,3) * project_data(i,5);  % variable cost = duration * baseline cost (cost/hour)
    project_data(i,8) = project_data(i,4) + project_data(i,6) + project_data(i,7); % total costs = fixed costs + resource costs + variable costs
end

% get the absolute start time of the first non-dummy/real task (with minimum start time).
% e.g. task10's start date is = 76429.25, task1 start date is 76421.15 --> task10's offset compensated (relative to first task) start date will be 8.1
start_date_offset = max(project_data(1:end,2)); % start searching from the highest possible task start time (could be Inf. also)
for i=1:num_activities
    if ((project_data(i,2) < start_date_offset) && (project_data(i,2) > 0)) % find minimum start time of non-dummy activities (as dummy = zero)
        start_date_offset = project_data(i,2); % new minimum found
    end
end
% calculate relative (offset compensated) start times
for i=1:num_activities
    if (project_data(i,2) > 0)
        project_data(i,2) = project_data(i,2) - start_date_offset; % convert start dates to relative, using previously calculated offset (first task = 0th time period)
    end
end

% sort topologically: put IDs by ascending start times and store the ID-offset pairs to be able to build-up DSM properly
project_data = [project_data resource_data(:,2:end)]; % merge the two before sorting topologically
project_data_sorted = sortrows(project_data,[2 1]); % sort by start time and ID of each task

id_offset = zeros(num_activities,2); % pre-allocate for speed
for i=1:num_activities
    for j=1:num_activities
        if(project_data(i,1) == project_data_sorted(j,1))
            id_offset(i,1) = i; % for debug only
            id_offset(i,2) = j;
        end
    end
end

% build up DSM based on relationship fields, get xml -> relations -> relation -> from_task -> to_task and put it in logical DSM
DSM = eye(num_activities); % pre-allocate n(+dummies) x n(+dummies) design structure matrix for relations, including all missing tasks corrected with dummy activities where necessary. put "1" on diagonal for each fix activity node (identity matrix)
for i=0:num_relations - 1 % java style, start from zero
    
    task_from = str2num(relations.item(1).getElementsByTagName('Relation').item(i).getElementsByTagName('FromTask').item(0).getTextContent);
    task_from = offset_data(task_from,2); % translate / map ID for our representation
    
    task_to = str2num(relations.item(1).getElementsByTagName('Relation').item(i).getElementsByTagName('ToTask').item(0).getTextContent);
    task_to = offset_data(task_to,2); % translate / map ID for our representation
    
    % should never happen, but lets add some exception handling and warning, just in case
    if(task_to == 0) % relation to an invalid/missing activity present
        fprintf('WARNING: invalid relation present from task #%d! \n',task_from) % send a warning with invalid relation info
        task_to = task_from; % skip relation (could have use the next valid also)
    end
    
    if(id_offset(task_from,2) < id_offset(task_to,2)) % consider only upper triangle after data is considered topologically
        DSM(id_offset(task_from,2), id_offset(task_to,2)) = 1; % put each relation as "1" in DSM
    end
end

% TODO match formatting expected by simulation engine, choose columns and their format dinamically based on parameter = selected type of simulation
% TODO cleanup, separate code to more functions

% TODO cost can be 0 for dummy activities / is that accepted by simulation?
TD = project_data_sorted(:,3); % store column vector with task durations
CD = project_data_sorted(:,8); % store column vector with total costs n x 1 where cost is in range [0;1]
RD = project_data_sorted(:,9:end); % store column vector with resource demands n x r

% initialize default constraint row vector
constr = 0;

% in real-life, there is only single mode
num_modes = 1;

% get resource constraints, Cr is the row vector of resource constraints
Cr = 0; % initialize resource constraint with zero (valid) value, later will be a row vector containing renewable resource(s) availability
if (num_r_resources > 0) % when there are renewable resources at all
    for i=1:num_r_resources
        Cr(1,i) = res_avail(1,i);
    end
end


% put all relevant matrices together in a PDM depending on simulation type e.g. CTP,DTP,NTP
switch sim_type
    
    case 0 % debug, DSM only

        PDM=DSM; % for tests

    case 1 % NTP
        
        PDM = [DSM,TD,CD,RD]; % QD is not available in original data
        constr = [-1,-1,Cr,1]; % there is no real constraint here, maybe some theoretical one [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]
        
    case 2 % CTP
        
        % number of modes is always one in this dataset, anyway, prepare a valid format
        TD = [TD, TD]; % duplicate TD to have lower/upper range as n x 2 matrix
        CD = [CD, CD]; % duplicate CD to have lower/upper range as n x 2 matrix
        RD = repelem(RD,1,2); % duplicate each column / resource demand to have lower/upper range as n x 2r matrix
        
        PDM = [DSM,TD,CD,RD];
        constr = [-1,-1,Cr,1]; % there is no real constraint, maybe some theoretical one goes here [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]
        
        sim_type = -1; % skip this trade-off problem
        
    case 3 % DTP
        
        PDM = [DSM,TD,CD,RD]; % number of modes is always "1" in this dataset, so leave it as it is
        constr = [-1,-1,Cr,1]; % there is no real constraint, maybe some theoretical one goes here [Ct=1,Cc=1,{Cq=1},{Cr=r},Cs=1]
        
        sim_type = -1; % skip this trade-off problem
        
    otherwise
        fprintf('Not a valid TP: only 1=NTP, 2=CTP, 3=DTP,  simulation types are supported!\n');
        PDM=DSM; % for tests
end

% for debugging
% resource_data;
% num_modes;
% project_data;
% project_data_sorted;
% DSM;
% PDM;
% TD
% RD
% sim_type
% constr

end
