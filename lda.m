m=[];d=[];s=[];sb=[];n=125;

%Mean of each class
for i=1:n
    x=X(:,(i-1)*10+1:(i-1)*10+1+9);
m(:,i)= mean(x,2);
end
% Average of the mean of all classes
mu=(sum(m,2))/n;

for i=1:n
    x=X(:,(i-1)*10+1:(i-1)*10+1+9);
d(:,i)=mean(x(:)-repmat(m(:,1),10,1));
end
% Center the data (data-mean)

% Calculate the within class variance (SW)
for i=1:n
s(:,i)=d(:,i)'*d(:,i);
end

sw=sum(s,2);
invsw=inv(sw);

% in case of two classes only use v
% v=invsw*(mu1-mu2)'

% if more than 2 classes calculate between class variance (SB)
for i=1:n
sb(:,i)=10*((m(:,i)-mu)'*(m(:,i)-mu));
end

SB=sum(sb,2);
v=invsw*SB;

% find eigne values and eigen vectors of the (v)
[evec,eval]=eig(v);

% Sort eigen vectors according to eigen values (descending order) and
% neglect eigen vectors according to small eigen values
% v=evec(greater eigen value)
% or use all the eigen vectors

% project the data of the first and second class respectively
for i=1:n
    x=X(:,(i-1)*10+1:(i-1)*10+1+9);
y(:,(i-1)*10+1:(i-1)*10+1+9)=x*v;
end
