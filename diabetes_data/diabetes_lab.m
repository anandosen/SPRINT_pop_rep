ids=[];
fils=['GHB_E.XPT'; 'GHB_F.XPT'; 'GHB_G.XPT'];

for fn=1:3
    hba1cdata=xptread(fils(fn,:));
    hba1cdata=table2array(hba1cdata);
    ids=union(hba1cdata(find(hba1cdata(:,2)>=6.5),1),ids);
end

fils=['GLU_E.XPT'; 'GLU_F.XPT'; 'GLU_G.XPT'];

for fn=1:3
    fgludata=xptread(fils(fn,:));
    fgludata=table2array(fgludata);
    ids=union(fgludata(find(fgludata(:,3)>=126),1),ids);
end

fils=['OGTT_E.XPT'; 'OGTT_F.XPT'; 'OGTT_G.XPT'];

for fn=1:3
    ogludata=xptread(fils(fn,:));
    ogludata=table2array(ogludata);
    ids=union(ogludata(find(ogludata(:,11)>=200),1),ids);
end

fils=['../gfr_calc_data/BIOPRO_E.XPT'; '../gfr_calc_data/BIOPRO_F.XPT'; '../gfr_calc_data/BIOPRO_G.XPT'];
cols=[17 17 18];
for fn=1:3
    rgludata=xptread(fils(fn,:));
    rgludata=table2array(rgludata);
    ids=union(rgludata(find(rgludata(:,cols(fn))>=200),1),ids);
end

dlmwrite('diab_patients_by_lab.txt', ids, 'precision', '%10i', 'delimiter', ' ');