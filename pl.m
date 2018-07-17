function L=pl(DSM)
DSM=logical(triu(DSM));
DSM(diag(DSM)==0,:)=0;
DSM(:,diag(DSM)==0)=0;
L=zeros(size(DSM,1),2);

M=zeros(size(DSM,1),1);
dsm=DSM(diag(DSM)==1,diag(DSM)==1);

if numel(dsm)==0
else
    if numel(dsm)==1
        M(diag(DSM)==1)=1;
    else
        dsm=dsm-eye(size(dsm,1));
        m=zeros(size(dsm,1),1);
        stage=1;
        while min(m)==0
            r=max(dsm)==0;
            m(r&(m==0)')=stage;
            dsm(r,:)=0;
            stage=stage+1;
        end
        M(diag(DSM)==1)=m;
    end
end
L(:,1)=M;

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
        while stage>=1
            r=max(dsm)==0;
            m(r&(m==0)')=stage;
            dsm(r,:)=0;
            stage=stage-1;
        end
        M(diag(DSM)==1)=m;
    end
end
L(:,2)=M;

