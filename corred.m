function R=corred(V1,V2)
R=zeros(1,length(V1)-1);
i=1;
while i<length(V1)
R(i)=corr(V1(1:i+1),V2(1:i+1),'type','Pearson');
i=i+1;
end
R=R';
end
