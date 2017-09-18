albcrdata1=xptread('ALB_CR_E.XPT');
albcrdata1=table2array(albcrdata1);
albcrdata1(:,6)=100*albcrdata1(:,3)./albcrdata1(:,4);
albcrdata1=albcrdata1(:,[1 6]);

albcrdata2=xptread('ALB_CR_F.XPT');
albcrdata2=table2array(albcrdata2);
albcrdata2(:,12)=max(albcrdata2(:,6),albcrdata2(:,11));
albcrdata2=albcrdata2(:,[1 11]);

albcrdata3=xptread('ALB_CR_G.XPT');
albcrdata3=table2array(albcrdata3);
albcrdata3=albcrdata3(:,[1 6]);

albcrdata=[albcrdata1; albcrdata2; albcrdata3];
albcrdata(find(isnan(albcrdata(:,2))),:)=[];
dlmwrite('albcr_data.txt',albcrdata, 'precision', '%10.1f','delimiter',' ');


albcrdata(find(albcrdata(:,2)<600),2)=0;
albcrdata(find(albcrdata(:,2)),2)=1;

dlmwrite('proturia_pat.txt',albcrdata, 'precision', '%10i','delimiter',' ');
