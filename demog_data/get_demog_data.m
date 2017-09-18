fils=char('DEMO_E.XPT', 'DEMO_F.XPT', 'DEMO_G.XPT');
first=1;
last=0;
demog_tab=zeros(35000,4);
cols=[1 5 6 9; 1 5 6 9; 1 4 5 7];

for fn=1:3
    demog_table=xptread(fils(fn,:));
    demog_table=demog_table(:,cols(fn,:));

    for i=2:4
        demog_table(find(isnan(table2array(demog_table(:,i)))),:)=[];
    end
    last=last+size(demog_table,1);

    demog_tab(first:last,:)=table2array(demog_table(:,1:4));
    first=last+1;
end

demog_tab(first:end,:)=[];

dlmwrite('demo_table.txt',demog_tab, 'precision', '%10i','delimiter',' ');