diab1=dlmread('diab_patients_by_lab.txt');
diab2=dlmread('diab_patients_by_diag.txt');
diab3=dlmread('diab_patients_by_medics.txt');

diab=union(diab1,intersect(diab2,diab3));

patdata=dlmread('../demog_data/demo_table.txt');
diabdata=patdata(:,1);
diabdata(:,2)=ismember(diabdata(:,1),diab);
dlmwrite('diab_patients_overall.txt', diabdata, 'precision', '%10i', 'delimiter', ' ');