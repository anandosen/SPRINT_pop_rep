fils=char('SMQ_E.XPT', 'SMQ_F.XPT', 'SMQ_G.XPT');
first=1;
last=0;
smok_tab=zeros(35000,2);

for fn=1:3
    smokdata=xptread(fils(fn,:));
    smokdata=table2array(smokdata(:,[1 2 4]));
    smokdata(:,4)=0;
    smokdata(find(smokdata(:,2)==1 & smokdata(:,3)<3),4)=1;
    smokdata(find(isnan(smokdata(:,2))),4)=NaN;
    smokdata(find(smokdata(:,2)>2 | smokdata(:,3)>3),4)=NaN;
    smokdata=smokdata(:,[1 4]);
    
    last=last+size(smokdata,1);

    smok_tab(first:last,:)=smokdata(:,1:2);
    first=last+1;
end

smok_tab(first:end,:)=[];

dlmwrite('smoke_data.txt', smok_tab, 'precision', '%10i', 'delimiter', ' ');
