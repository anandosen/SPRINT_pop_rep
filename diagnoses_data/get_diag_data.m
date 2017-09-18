fils=char('MCQ_E.XPT', 'MCQ_F.XPT', 'MCQ_G.XPT');
first=1;
last=0;
diag_tab=zeros(35000,6);
cols=[1 21 23 25 27 29; 1 22 24 26 28 30; 1 24 26 28 30 32];

for fn=1:3
    diagdata=xptread(fils(fn,:));
    diagdata=diagdata(:,cols(fn,:));

    last=last+size(diagdata,1);

    diag_tab(first:last,:)=table2array(diagdata(:,1:6));
    first=last+1;
end

diag_tab(first:end,:)=[];

for i=2:6
    diag_tab(find(diag_tab(:,i)~=1),i)=0;
end
 
diag_tab(:,3)=max(max(diag_tab(:,3),diag_tab(:,4)),diag_tab(:,5));
diag_tab(:,4:5)=[];
 
dlmwrite('hf_pat.txt',diag_tab(:,[1,2]), 'precision', '%10i','delimiter',' ');
dlmwrite('chd_pat.txt',diag_tab(:,[1,3]), 'precision', '%10i','delimiter',' ');
dlmwrite('stroke_pat.txt',diag_tab(:,[1,4]), 'precision', '%10i','delimiter',' ');