druginfo=xptread('../medications_data/RXQ_DRUG.xpt');
drugcats=table2array(druginfo(:,4:33));
drugcats(isnan(drugcats))=999;
bpcats=[358 99 213; 358 99 215; 358 99 216; 358 99 271; 358 99 214; 358 99 314; 358 99 282; 358 99 371; 358 99 458];

drugs=size(drugcats,1);
ind=zeros(drugs,1);
for j=1:drugs
    d=drugcats(j,:);
    d=reshape(d,[3,10]);
    d=d';
    ind(j)=max(ismember(d,bpcats,'rows'));    
end

drinfo=table2cell(druginfo(:,1:2));
drinfo(find(ind==0),:)=[];

%%%%%%%%%%%%%%%%%%%%%%
fils=char('../medications_data/RXQ_RX_E.XPT', '../medications_data/RXQ_RX_F.XPT', '../medications_data/RXQ_RX_G.XPT');
first=1;
last=0;
meddata=zeros(35000,2);

for fn=1:3
    patdata=xptread(fils(fn,:));
    patdata(find(table2array(patdata(:,2))>2),:)=[];
    siz=size(patdata,1);

    ind=zeros(siz,1);

    for i=1:siz
        med=table2cell(patdata(i,4));
        ind(i)=sum(strcmp(med,drinfo(:,1)));
    end

    patdrugs=[table2array(patdata(:,1)) ind];

    patlist=unique(table2array(patdata(:,1)));
    siz=size(patlist,1);
    nomed=zeros(siz,1);
    for i=1:siz
        temp=find(patdrugs(:,1)==patlist(i));
        nomed(i)=sum(patdrugs(temp,2));
    end
    last=last+siz;
    meddata(first:last,:)=[patlist,nomed];
    first=last+1;
end

meddata(first:end,:)=[];
ids=meddata(find(meddata(:,2)>0),1);


dlmwrite('diab_patients_by_medics.txt', ids, 'precision', '%10i', 'delimiter', ' ');