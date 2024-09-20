function p = Ver(p,r,i1)
for k=0:9
for i=1:i1
if r(1,i)==k
p(1,i)=2.^(-k-1);
end
end
end