fils=char('HDL_E.XPT', 'HDL_F.XPT', 'HDL_G.XPT');
first=1;
last=0;
hdl_tab=zeros(35000,2);

for fn=1:3
    hdldata=xptread(fils(fn,:));
    hdldata=table2array(hdldata(:,[1 2]));
    
    hdldata(find(isnan(hdldata(:,2))),:)=[];
        
    last=last+size(hdldata,1);

    hdl_tab(first:last,:)=hdldata(:,1:2);
    first=last+1;
end

hdl_tab(first:end,:)=[];

dlmwrite('hdl_data.txt', hdl_tab, 'precision', '%10i', 'delimiter', ' ');

fils=char('TCHOL_E.XPT', 'TCHOL_F.XPT', 'TCHOL_G.XPT');
first=1;
last=0;
chol_tab=zeros(35000,2);

for fn=1:3
    choldata=xptread(fils(fn,:));
    choldata=table2array(choldata(:,[1 2]));
    
    choldata(find(isnan(choldata(:,2))),:)=[];
        
    last=last+size(choldata,1);

    chol_tab(first:last,:)=choldata(:,1:2);
    first=last+1;
end

chol_tab(first:end,:)=[];

dlmwrite('chol_data.txt', chol_tab, 'precision', '%10i', 'delimiter', ' ');