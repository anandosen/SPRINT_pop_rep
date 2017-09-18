diagdata1=xptread('DIQ_E.XPT');
diagdata2=xptread('DIQ_F.XPT');
diagdata3=xptread('DIQ_G.XPT');

diagdata=[diagdata1(:,1:2); diagdata2(:,1:2); diagdata3(:,1:2)];
diagdata=table2array(diagdata);

ids=diagdata(find(diagdata(:,2)==1),1);

dlmwrite('diab_patients_by_diag.txt', ids, 'precision', '%10i', 'delimiter', ' ');