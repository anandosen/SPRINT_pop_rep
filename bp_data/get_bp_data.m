fils=char('BPX_E.XPT', 'BPX_F.XPT', 'BPX_G.XPT');
first=1;
last=0;
bp_tab=zeros(20000,3);

for fn=1:3
    bp_table=xptread(fils(fn,:));
    bp_table=bp_table(:,[1,16,17,19,20,22,23]);

    for i=2:7
        bp_table(find(isnan(table2array(bp_table(:,i)))),:)=[];
    end
    last=last+size(bp_table,1);

    bp_tab(first:last,1)=table2array(bp_table(:,1));
    bp_tab(first:last,2)=mean(table2array(bp_table(:,[2 4 6])),2);
    bp_tab(first:last,3)=mean(table2array(bp_table(:,[3 5 7])),2);
    first=last+1;
end

bp_tab(first:end,:)=[];

dlmwrite('bp_table.txt',bp_tab, 'precision', '%10.1f','delimiter',' ');