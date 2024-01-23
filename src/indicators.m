% calculate various structure related indicators:
% - I1 (num_activities)
% - I2 (SP)
% - I3 (AD)
% - I4 (SA)
% - I5 (LA)
% - I6 (TF)

% prerequisites:
% - arclengths.m -> to calculate arc lengths
% - pl.m -> to calculate progressive/regressive levels

% example input: >> load('../test_data/pat1_DSM.mat', 'DSM')
% example usage: >> [I1,I2,I3,I4,I5,I6] = indicators(DSM)
% example output: >> I1 = 12 ,..., I6 = 0.25

function [i1,i2,i3,i4,i5,i6] = indicators(DSM)

DSM=logical(triu(DSM)); % convert upper triangle (no cycles allowed) to logical
DSM(diag(DSM)==0,:)=0; % remove all successors of empty tasks
DSM(:,diag(DSM)==0)=0; % remove all predecessors of empty tasks
dsm=DSM(diag(DSM)==1,diag(DSM)==1); % remove empty tasks and their dependencies

if isempty(dsm) % error if no tasks left
    error('DSM is empty.')
end

%% I1: also known as number of activities indicator.
% reference: Tavares et al. (1999)
i1=size(dsm,1); % number of tasks is the size of rows in DSM (nxn, logic domain, nxn)
n=i1; % store as n
A=numel(dsm(dsm==1))-n; % number of arcs
L=pl(dsm); % calculate progressive levels
l=L(:,1);
m=max(l);

%% I2: also known as SP: Serial/Parallel indicator.
% reference: Tavares et al. (1999)
i2=(m-1)/(n-1);
if n==1
    i2=1; % by definition
end

%% I3: also known as AD: Activity Distribution indicator.
% reference: Tavares et al. (1999) (original)
% reference: Vanhoucke et al. (2008) (improved)
i3=0;
W=tabulate(l);
W=W(:,2);
w=mean(W);
if ((m>1)&&(m<n))
   lambdaw=0;
   for i=1:m
       lambdaw=lambdaw+abs(W(i)-w);
   end
   lambdamax=2*(m-1)*(w-1);
   i3=lambdaw/lambdamax;
end

%% I4: also known as SA: Short Arcs indicator.
% reference: Tavares et al. (1999)
i4=1;
D=0;
for i=1:m-1
    D=D+W(i)*W(i+1);
end
if ((D>n-W(1)))
    i4=(arclengths(dsm,1,L)-n+W(1))/(D-n+W(1));
end

%% I5: also known as LA: Length of Long Arcs indicator.
% reference: Tavares et al. (1999) (original)
% reference: Vanhoucke et al. (2008) (improved)
i5=1;
if A~=n-W(1)
    NL=0;
    for l=2:m-1
        NL=NL+arclengths(dsm,l,L)*(m-l-1)/(m-2);
    end
    i5=(NL+arclengths(dsm,1,L)-n+W(1))/(A-n+W(1));
end

%% I6: also known as TF: Topological Float indicator.
% reference: Vanhoucke et al. (2008).
i6=0;
if ((m>1)&&(m<n))
    for i=1:n
        i6=i6+(L(i,2)-L(i,1));
    end
    i6=i6/((m-1)*(n-m));
end
