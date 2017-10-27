tp=dlmread('target_pop.txt');
clichd=dlmread('../diagnoses_data/chd_pat.txt');
egfr=dlmread('../gfr_calc_data/egfr_table.txt');
framrisk=dlmread('../frammingham_calc_data/fram_scores_data.txt');
diab=dlmread('../diabetes_data/diab_patients_overall.txt');
stroke=dlmread('../diagnoses_data/stroke_pat.txt');
protur=dlmread('../proteinuria_data/proturia_pat.txt');
hf=dlmread('../diagnoses_data/hf_pat.txt');
dial=dlmread('../dialysis_data/dialysis_pat.txt');

clichdpats=clichd(find(clichd(:,2)==1),1);
ckdpats=egfr(find(egfr(:,2)>=20 & egfr(:,2)<60),1);
frampats=framrisk(find(framrisk(:,3)>=15),1);
seniorpats=tp(find(tp(:,3)>=75),1);

diabpats=diab(find(diab(:,2)==1),1);
strokepats=stroke(find(stroke(:,2)==1),1);
proturpats=protur(find(protur(:,2)==1),1);
hfpats=hf(find(hf(:,2)==1),1);
dialpats=dial(find(dial(:,2)==1),1);
kfpats=egfr(find(egfr(:,2)<20),1);
kfpats=union(kfpats,dialpats);

siz=size(tp,1);

[~,loc]=ismember(tp(:,1),clichdpats);
tp(find(loc),8)=1;

[~, loc]=ismember(tp(:,1),ckdpats);
tp(find(loc),9)=1;

[~, loc]=ismember(tp(:,1),frampats);
tp(find(loc),10)=1;

[~, loc]=ismember(tp(:,1),seniorpats);
tp(find(loc),11)=1;

[~, loc]=ismember(tp(:,1),diabpats);
tp(find(loc),12)=1;

[~, loc]=ismember(tp(:,1),strokepats);
tp(find(loc),13)=1;

[~, loc]=ismember(tp(:,1),proturpats);
tp(find(loc),14)=1;

[~, loc]=ismember(tp(:,1),hfpats);
tp(find(loc),15)=1;

[~, loc]=ismember(tp(:,1),kfpats);
tp(find(loc),16)=1;

sbpind=ones(siz,1);
sbpind(find(tp(:,5)<130),:)=0;
sbpind(find(tp(:,5)>180),:)=0;
sbpind(find(tp(:,7)==2 & tp(:,5)>170),:)=0;
sbpind(find(tp(:,7)==3 & tp(:,5)>160),:)=0;
sbpind(find(tp(:,7)==4 & tp(:,5)>150),:)=0;
sbpind(find(tp(:,7)>4),:)=0;

cvrisk=max(tp(:,8:11),[],2);
ageelig=tp(:,3)>=50;
tp1=tp;
tp1(:,8)=cvrisk;
tp1(:,[1 2 4 6 9:11])=[];
tp1=tp1(:,[4:9 2:3 1]);

%tp1(:,7)=sbpind;
%tp1(:,8)=sbpind;

sp=dlmread('study_pop.txt');
tp_sp_ind=ismember(tp(:,1),sp(:,1));

dlmwrite('target_pop1_input.txt',tp1, 'precision', '%10.1f', 'delimiter', ' ');
dlmwrite('overall_elig.txt',tp_sp_ind);

elig_ind=[cvrisk, ~tp1(:,2:6), sbpind, sbpind, ageelig];
dlmwrite('elig_traits_tp1.txt',elig_ind, 'precision', '%10i', 'delimiter', ' ');

egfrind=ismember(tp(:,1),egfr(:,1));
framind=ismember(tp(:,1),framrisk(:,1));
full=intersect(find(egfrind),find(framind));

tp=tp(full,:);
sbpind=sbpind(full);
tp_sp_ind=ismember(tp(:,1),sp(:,1));
ageelig=ageelig(full);


siz=size(tp,1);

[~, loc]=ismember(tp(:,1),egfr(:,1));
tp(:,9)=egfr(loc,2);

egfrind=tp(:,9)>=20 & tp(:,9)<60;

[~, loc]=ismember(tp(:,1),framrisk(:,1));
tp(:,10)=framrisk(loc,3);

framind=(tp(:,2)==1 & tp(:,10)>12) | (tp(:,2)==2 & tp(:,10)>15);
tp2=tp;
tp2(:,[1 2 4 6])=[];

seniorind=tp2(:,7);
tp2(:,7)=tp2(:,1);

tp2=tp2(:,[8:12,4:7,2:3,1]);

elig_ind=[~tp2(:,1:5), tp2(:,6), egfrind, framind, seniorind, sbpind, sbpind, ageelig];

dlmwrite('target_pop2_input.txt',tp2, 'precision', '%10.1f', 'delimiter', ' ');
dlmwrite('overall_elig2.txt',tp_sp_ind);
dlmwrite('elig_traits_tp2.txt',elig_ind, 'precision', '%10i', 'delimiter', ' ');
