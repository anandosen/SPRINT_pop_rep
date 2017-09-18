demdata=dlmread('../demog_data/demo_table.txt');
hdldata=dlmread('hdl_data.txt');
choldata=dlmread('chol_data.txt');
medsdata=dlmread('../medications_data/nomed_table.txt');
bpdata=dlmread('../bp_data/bp_table.txt');
smokdata=dlmread('smoke_data.txt');
diabdata=dlmread('../diabetes_data/diab_patients_overall.txt');

demdata(:,4)=[];
bpdata(:,3)=[];

demdata(find(demdata(:,3)<20),:)=[];

siz=size(demdata,1);

pattable=zeros(siz,9);
pattable(:,1:3)=demdata(:,:);
pattable(:,4:9)=NaN;

for i=1:siz
    ind=find(hdldata(:,1)==pattable(i,1));
    if (isempty(ind)==0)
        pattable(i,4)=hdldata(ind,2);
    end
    
    ind=find(choldata(:,1)==pattable(i,1));
    if (isempty(ind)==0)
        pattable(i,5)=choldata(ind,2);
    end
    
    ind=find(medsdata(:,1)==pattable(i,1));
    if (isempty(ind)==0)
        pattable(i,6)=medsdata(ind,2);
    end
    
    ind=find(bpdata(:,1)==pattable(i,1));
    if (isempty(ind)==0)
        pattable(i,7)=bpdata(ind,2);
    end
    
    ind=find(smokdata(:,1)==pattable(i,1));
    if (isempty(ind)==0)
        pattable(i,8)=smokdata(ind,2);
    end
    
    ind=find(diabdata(:,1)==pattable(i,1));
    if (isempty(ind)==0)
        pattable(i,9)=diabdata(ind,2);
    end
end

miss=sum(isnan(pattable),2);
pattable(find(miss>0),:)=[];
dlmwrite('pat_full_data.txt', pattable, 'precision', '%10.1f', 'delimiter', ' ');