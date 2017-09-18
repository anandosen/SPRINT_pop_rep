dialdata1=xptread('KIQ_U_E.XPT');
dialdata2=xptread('KIQ_U_F.XPT');
dialdata3=xptread('KIQ_U_G.XPT');

dialdata=[dialdata1(:,[1 3]); dialdata2(:,[1 3]); dialdata3(:,[1 3])];
dialdata=table2array(dialdata);

dlmwrite('dialysis_pat.txt', dialdata, 'precision', '%10i', 'delimiter', ' ');