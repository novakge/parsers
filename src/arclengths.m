% calculate length of arcs for structural indicators
function nl=arclengths(DSM,l,L)
W=L(:,1);

% % original version with nested loops
% n=size(dsm,1);
% for i=1:n-1 % check values in rows of upper triangle
%     for j=i+1:n % ...
%         if any(dsm(i,j)) % if there is any precedence relation
%             if abs(W(i)-W(j))==l % that is connected with the progressive level
%                 nl=nl+1; % increment length
%             end
%         end
%     end
% end

% improved version with vectorization
idx = find(DSM & (abs(W(:) - W(:)')==l)); % store indices of relations with the progressive level
nl = numel(idx); % count number of indices
