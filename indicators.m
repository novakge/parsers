function[i1,i2,i3,i4,i5,i6]=indicators(DSM)
DSM=logical(triu(DSM));
DSM(diag(DSM)==0,:)=0;
DSM(:,diag(DSM)==0)=0;
dsm=DSM(diag(DSM)==1,diag(DSM)==1);
i1=size(dsm,1);
n=i1;
A=numel(dsm(dsm==1))-size(dsm,1); %number of arcs
L=pl(dsm);
l=L(:,1);
m=max(l);
i2=(m-1)/(n-1);
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
i4=1;
D=0;
for i=1:m-1
    D=D+W(i)*W(i+1);
end
if ((D>n-W(1)))
    i4=(arclengths(dsm,1)-n+W(1))/(D-n+W(1));
end
i5=1;
if A~=n-W(1)
    NL=0;
    for l=2:m-1
        NL=NL+arclengths(dsm,l)*(m-l-1)/(m-2);
    end
    i5=(NL+arclengths(dsm,1)-n+W(1))/(A-n+W(1));
end
i6=0;
if ((m>1)&&(m<n))
    for i=1:n
        i6=i6+(L(i,2)-L(i,1));
    end
    i6=i6/((m-1)*(n-m));
end