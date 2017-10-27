demog=dlmread('../demog_data/demo_table.txt');
bp=dlmread('../bp_data/bp_table.txt');
meds=dlmread('../medications_data/nomed_table.txt');

pids=intersect(bp(:,1),meds(:,1));
siz=size(pids,1);

tp1=zeros(siz,7);
tp1(:,1)=pids;

for i=1:siz
    ind1=find(demog(:,1)==pids(i));
    ind2=find(bp(:,1)==pids(i));
    ind3=find(meds(:,1)==pids(i));
    
    tp1(i,2:4)=demog(ind1,2:4);
    tp1(i,5:6)=bp(ind2,2:3);
    tp1(i,7)=meds(ind3,2);
end

% US Adlult population with complete BP and medication records
tp1(find(tp1(:,3)<20),:)=[];
tp1=tp1(find(tp1(:,5)>=130 | tp1(:,7)>0),:);

dlmwrite('target_pop.txt', tp1, 'precision', '%10.1f', 'delimiter', ' ');
% Age greater than 50
tp1(find(tp1(:,3)<50),:)=[];

% SBP Criteria
tp1(find(tp1(:,5)<130),:)=[];
tp1(find(tp1(:,5)>180),:)=[];
tp1(find(tp1(:,7)==2 & tp1(:,5)>170),:)=[];
tp1(find(tp1(:,7)==3 & tp1(:,5)>160),:)=[];
tp1(find(tp1(:,7)==4 & tp1(:,5)>150),:)=[];
tp1(find(tp1(:,7)>4),:)=[];

% High CVD risk criteria

% Clinical CHD
pids=tp1(:,1);
clichd=dlmread('../diagnoses_data/chd_pat.txt');
pats=clichd(find(clichd(:,2)==1),1);

% CKD
ckd=dlmread('../gfr_calc_data/egfr_table.txt');
ckdpats=ckd(find(ckd(:,2)>=20 & ckd(:,2)<60),1);
pats=union(pats,ckdpats);

% High 10 year risk
framrisk=dlmread('../frammingham_calc_data/fram_scores_data.txt');
frampats=framrisk(find(framrisk(:,3)>=15),1);
pats=union(pats,frampats);

% Seniors
seniors=tp1(find(tp1(:,3)>=75),1);
pats=union(pats,seniors);

ind=ismember(tp1(:,1),pats);
tp1(find(ind==0),:)=[];

% Exlusion Criteria

% Diabetes
diab=dlmread('../diabetes_data/diab_patients_overall.txt');
diabpats=diab(find(diab(:,2)==1),1);
ind=ismember(tp1(:,1),diabpats);
tp1(find(ind==1),:)=[];

% Stroke
stroke=dlmread('../diagnoses_data/stroke_pat.txt');
strokepats=stroke(find(stroke(:,2)==1),1);
ind=ismember(tp1(:,1),strokepats);
tp1(find(ind==1),:)=[];

% Proteinuria
protur=dlmread('../proteinuria_data/proturia_pat.txt');
proturpats=protur(find(protur(:,2)==1),1);
ind=ismember(tp1(:,1),proturpats);
tp1(find(ind==1),:)=[];

% Heart Failure
hf=dlmread('../diagnoses_data/hf_pat.txt');
hfpats=hf(find(hf(:,2)==1),1);
ind=ismember(tp1(:,1),hfpats);
tp1(find(ind==1),:)=[];

% Kidney Failure
kfpats=ckd(find(ckd(:,2)<20),1);
ind=ismember(tp1(:,1),kfpats);
dial=dlmread('../dialysis_data/dialysis_pat.txt');
dialpats=dial(find(dial(:,2)==1),1);
ind2=ismember(tp1(:,1),dialpats);
ind=max(ind,ind2);
tp1(find(ind==1),:)=[];


dlmwrite('study_pop.txt', tp1, 'precision', '%10.1f', 'delimiter', ' ');