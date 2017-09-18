function G=gmult_cat(data,elig,elig_c,add_elig)
    feat=size(elig,1);
    G=data>0;
    npat=size(data,1);
    b=categories(elig_c);
    gender=categorical(data(:,1));
    data(:,1)=[];
    for i=1:feat
        G(:,i+1)=data(:,i)>= elig(i,1) & data(:,i)<= elig(i,2);
        if (isempty(find(add_elig(:,1)==i))==0)
            pos=add_elig((find(add_elig(:,1)==i)),:);
            G(:,i+1)=G(:,i+1) | (data(:,i)>= pos(2) & data(:,i)<= pos(3));
        end
    end

siz=size(b,1);
i=1;
d=zeros(npat,1);
while i<=siz
    d= d | gender(:)==b{i};
    i=i+1;
end
G(:,1)=d;

end