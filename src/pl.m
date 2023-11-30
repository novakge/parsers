% calculate progressive and regressive levels for structural indicators
% reference: Elmaghraby (1977)

function L=pl(DSM)

dsm=DSM;
L=zeros(size(DSM,1),2);
stage=0;
M=zeros(size(DSM,1),1);

%% calculate progressive levels (PL)
if numel(dsm)==0
else
    if numel(dsm)==1
        M(diag(DSM)==1)=1;
    else
        dsm=dsm-eye(size(dsm,1)); % keep only precedence relations
        m=zeros(size(dsm,1),1); % allocate vector to store stages
        stage=1; % start with first stage
        while min(m)==0 % check unstaged tasks
            r=sum(dsm)==0; % mark tasks without predecessors (cols)
            m(r&(m==0)')=stage; % stage tasks without predecessors
            dsm(r,:)=0; % zero all marked tasks successors (rows)
            stage=stage+1; % check the next stage
        end
        M(diag(DSM)==1)=m;
    end
end
L(:,1)=M;


%% calculate regressive levels (RL)
DSM=DSM';
stage=stage-1;
M=zeros(size(DSM,1),1);
dsm=DSM(diag(DSM)==1,diag(DSM)==1);

if numel(dsm)==0
else
    if numel(dsm)==1
        M(diag(DSM)==1)=1;
    else
        dsm=dsm-eye(size(dsm,1));
        m=zeros(size(dsm,1),1);
        while stage>=1 % check all assigned stages
            r=sum(dsm)==0;
            m(r&(m==0)')=stage;
            dsm(r,:)=0;
            stage=stage-1;
        end
        M(diag(DSM)==1)=m;
    end
end
L(:,2)=M;
