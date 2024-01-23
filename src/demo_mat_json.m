% example conversion from MAT to JSON
clear all

% example .MAT file path to load 
mat_file = load('../test_data/pat1_NTP.mat');

% example .JSON file path to save
json_file = '../test_data/pat1_NTP.json';

% convert and display MAT container to a JSON formatted string
json_string = jsonencode(mat_file,PrettyPrint=true); % preserve a readable format
disp(json_string);

% parse and display the JSON string back to MAT data structure
json_mat = jsondecode(json_string);
disp(json_mat);

% access and display all entries in JSON
field_names = fieldnames(json_mat);

for i=1:numel(field_names)
    field_name = field_names{i};
    field_value = json_mat.(field_name);

    % display field name and value
    disp(['Field Name: ' field_name]);
    disp(['Field Value: ' mat2str(field_value)]);
end

% save the JSON string to a file
fid = fopen(json_file, 'w');
fprintf(fid, '%s', json_string);
fclose(fid);

% Remark: JSON decoding behavior can sometimes lead to row vectors being
% interpreted as column vectors due to how the JSON format represents
% arrays. Post-processing (transpose) is recommended in such case(s).