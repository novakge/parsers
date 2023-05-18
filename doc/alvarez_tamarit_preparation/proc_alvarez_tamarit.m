problem_sets = ["prob27.html","prob51.html","prob103.html"];

for x=1:numel(problem_sets)

file_id = fopen(problem_sets(x),'r'); % open next file

frewind(file_id); % start at the beginning
act_line = fgetl(file_id); % initialize by reading the first line

start_offsets = [];
end_offsets = [];
problems_count = 1;

i = 1; % count lines (rows)
while ischar(act_line)
    
    % search for line containing problem instance ID -> "ST*"
    if(strfind(act_line,'ST') == true )
        start_offsets(problems_count,1) = i;
        problems_count = problems_count + 1; % increase total problem count
    end
    
    % read next line
    act_line = fgetl(file_id);
    i = i + 1; % next line until eof

end


end_offsets = start_offsets(2:end) - 2; % calculate end of each instance except the last, and ignore next instance name header
end_offsets(problems_count-1) = i - 2; % store the end of last instance

for i = 1:numel(start_offsets)

    frewind(file_id); % start at the beginning

    for j = 1:start_offsets(i)
        problem_id = fgetl(file_id);
    end

    % create a new file for the slice
    problem_id = strrep(problem_id,' ',''); % remove blank space from filename
    slice_name = sprintf('%s.at',problem_id);
    slice_id = fopen(slice_name, 'w');



    % copy the lines from the start to the end into the slice file
    for j = start_offsets(i):end_offsets(i)
        line = fgetl(file_id);
        fprintf(slice_id, '%s\n', line);
    end

    fclose(slice_id);

end

fclose(file_id);

end
