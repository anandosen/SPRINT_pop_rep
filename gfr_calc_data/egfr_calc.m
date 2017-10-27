fils=char('BIOPRO_E.XPT', 'BIOPRO_F.XPT', 'BIOPRO_G.XPT');
first=1;
last=0;
crtn_tab=zeros(35000,2);
cols=[1 14; 1 14; 1 15];

for fn=1:3
    crtn=xptread(fils(fn,:));
    crtn=crtn(:,cols(fn,:));

    last=last+size(crtn,1);

    crtn_tab(first:last,:)=table2array(crtn(:,1:2));
    first=last+1;
end

crtn_tab(first:end,:)=[];
crtn_tab(find(isnan(crtn_tab(:,2))),:)=[];

demog=dlmread('../demog_data/demo_table.txt');

siz=size(crtn_tab,1);

for i=1:siz
    ind=find(demog(:,1)==crtn_tab(i,1));
    crtn_tab(i,3:5)=demog(ind,2:4);
end

crtn_tab(find(crtn_tab(:,4)<20),:)=[];
crtn_tab(find(crtn_tab(:,5)~=4),5)=0;

egfr=ones(size(crtn_tab,1),8);
egfr(:,1:3)=crtn_tab(:,[1 2 4]); % id, creatinine, age, kappa, alpha, gender factor, race factor, egfr

epi=0; % 0 for MDRD, 1 for EPI
if (epi==1)
    egfr(:,4)=0.7;
    egfr(find(crtn_tab(:,3)==1),4)=0.9;

    egfr(:,5)=-0.329;
    egfr(find(crtn_tab(:,3)==1),5)=-0.411;

    egfr(find(crtn_tab(:,3)==2),6)=1.018;
    egfr(find(crtn_tab(:,5)==4),7)=1.159;

    egfr(:,8)=141.*min(egfr(:,2)./egfr(:,4),1).^egfr(:,5).*max(egfr(:,2)./egfr(:,4),1).^(-1.209).*0.993.^egfr(:,3).*egfr(:,6).*egfr(:,7);
else
    egfr(find(crtn_tab(:,3)==2),4)=0.742;
    egfr(find(crtn_tab(:,5)==4),5)=1.212;
    
    egfr(:,8)=175.*egfr(:,2).^(-1.154).*egfr(:,3).^(-0.203).*egfr(:,4).*egfr(:,5);
end

dlmwrite('egfr_table.txt',egfr(:,[1,8]), 'precision', '%10.1f','delimiter',' ');
