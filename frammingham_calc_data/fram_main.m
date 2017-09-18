patdata=dlmread('pat_full_data.txt');

fmind=find(patdata(:,2)==2);
mlind=find(patdata(:,2)==1);

fdata=patdata(fmind,:);
mdata=patdata(mlind,:);

ftab=zeros(size(fdata,1),8);
mtab=zeros(size(mdata,1),8);

fchart=zeros(24,2);
fchart(:,1)=-2:21;
fchart(:,2)=[0.5 1 1.2 1.5 1.7 2.0 2.4 2.8 3.3 3.9 4.5 5.3 6.3 7.3 8.6 10 11.7 13.7 15.9 18.5 21.5 24.8 28.5 30];

mchart=zeros(22,2);
mchart(:,1)=-3:18;
mchart(:,2)=[0.5 1.1 1.4 1.6 1.9 2.3 2.8 3.3 3.9 4.7 5.6 6.7 7.9 9.4 11.2 13.2 15.6 18.4 21.6 25.3 29.4 30];

%%%%%%%%%%FEMALES%%%%%%%%%%

%Age

ftab(find(fdata(:,3)<=34),1)=0;
ftab(find(fdata(:,3)>=35 & fdata(:,3)<=39),1)=2;
ftab(find(fdata(:,3)>=40 & fdata(:,3)<=44),1)=4;
ftab(find(fdata(:,3)>=45 & fdata(:,3)<=49),1)=5;
ftab(find(fdata(:,3)>=50 & fdata(:,3)<=54),1)=7;
ftab(find(fdata(:,3)>=55 & fdata(:,3)<=59),1)=8;
ftab(find(fdata(:,3)>=60 & fdata(:,3)<=64),1)=9;
ftab(find(fdata(:,3)>=65 & fdata(:,3)<=69),1)=10;
ftab(find(fdata(:,3)>=70 & fdata(:,3)<=74),1)=11;
ftab(find(fdata(:,3)>=75),1)=12;

%HDL

ftab(find(fdata(:,4)>=60),2)=-2;
ftab(find(fdata(:,4)>=50 & fdata(:,4)<=59),2)=-1;
ftab(find(fdata(:,4)>=45 & fdata(:,4)<=49),2)=0;
ftab(find(fdata(:,4)>=35 & fdata(:,4)<=44),2)=1;
ftab(find(fdata(:,4)<35),2)=2;

%Cholesterol

ftab(find(fdata(:,5)<160),3)=0;
ftab(find(fdata(:,5)>=160 & fdata(:,5)<=199),3)=1;
ftab(find(fdata(:,5)>=200 & fdata(:,5)<=239),3)=3;
ftab(find(fdata(:,5)>=240 & fdata(:,5)<=279),3)=4;
ftab(find(fdata(:,5)>=280),3)=5;

%SBP without medication

ftab(find(fdata(:,6)==0 & fdata(:,7)<120),4)=-3;
ftab(find(fdata(:,6)==0 & fdata(:,7)>=120 & fdata(:,7)<=129.9),4)=0;
ftab(find(fdata(:,6)==0 & fdata(:,7)>=130 & fdata(:,7)<=139.9),4)=1;
ftab(find(fdata(:,6)==0 & fdata(:,7)>=140 & fdata(:,7)<=149.9),4)=2;
ftab(find(fdata(:,6)==0 & fdata(:,7)>=150 & fdata(:,7)<=159.9),4)=4;
ftab(find(fdata(:,6)==0 & fdata(:,7)>=160),4)=5;

%SBP with medication

ftab(find(fdata(:,6)>0 & fdata(:,7)<120),4)=-1;
ftab(find(fdata(:,6)>0 & fdata(:,7)>=120 & fdata(:,7)<=129.9),4)=2;
ftab(find(fdata(:,6)>0 & fdata(:,7)>=130 & fdata(:,7)<=139.9),4)=3;
ftab(find(fdata(:,6)>0 & fdata(:,7)>=140 & fdata(:,7)<=149.9),4)=5;
ftab(find(fdata(:,6)>0 & fdata(:,7)>=150 & fdata(:,7)<=159.9),4)=6;
ftab(find(fdata(:,6)>0 & fdata(:,7)>=160),4)=7;

%Smoker

ftab(find(fdata(:,8)==0),5)=0;
ftab(find(fdata(:,8)==1),5)=3;

%Diabetes

ftab(find(fdata(:,9)==0),6)=0;
ftab(find(fdata(:,9)==1),6)=4;

%Summing points

ftab(:,7)=sum(ftab(:,1:6),2);

%Score calculation

[ind, loc]=ismember(ftab(:,7),fchart(:,1));
loc(find(ftab(:,7)>21))=24;
loc(find(ftab(:,7)<-2))=1;

ftab(:,8)=fchart(loc,2);


%%%%%%%%%%MALES%%%%%%%%%%

%Age

mtab(find(mdata(:,3)<=34),1)=0;
mtab(find(mdata(:,3)>=35 & mdata(:,3)<=39),1)=2;
mtab(find(mdata(:,3)>=40 & mdata(:,3)<=44),1)=5;
mtab(find(mdata(:,3)>=45 & mdata(:,3)<=49),1)=6;
mtab(find(mdata(:,3)>=50 & mdata(:,3)<=54),1)=8;
mtab(find(mdata(:,3)>=55 & mdata(:,3)<=59),1)=10;
mtab(find(mdata(:,3)>=60 & mdata(:,3)<=64),1)=11;
mtab(find(mdata(:,3)>=65 & mdata(:,3)<=69),1)=12;
mtab(find(mdata(:,3)>=70 & mdata(:,3)<=74),1)=14;
mtab(find(mdata(:,3)>=75),1)=15;

%HDL

mtab(find(mdata(:,4)>=60),2)=-2;
mtab(find(mdata(:,4)>=50 & mdata(:,4)<=59),2)=-1;
mtab(find(mdata(:,4)>=45 & mdata(:,4)<=49),2)=0;
mtab(find(mdata(:,4)>=35 & mdata(:,4)<=44),2)=1;
mtab(find(mdata(:,4)<35),2)=2;

%Cholesterol

mtab(find(mdata(:,5)<160),3)=0;
mtab(find(mdata(:,5)>=160 & mdata(:,5)<=199),3)=1;
mtab(find(mdata(:,5)>=200 & mdata(:,5)<=239),3)=2;
mtab(find(mdata(:,5)>=240 & mdata(:,5)<=279),3)=3;
mtab(find(mdata(:,5)>=280),3)=4;

%SBP without medication

mtab(find(mdata(:,6)==0 & mdata(:,7)<120),4)=-2;
mtab(find(mdata(:,6)==0 & mdata(:,7)>=120 & mdata(:,7)<=129.9),4)=0;
mtab(find(mdata(:,6)==0 & mdata(:,7)>=130 & mdata(:,7)<=139.9),4)=1;
mtab(find(mdata(:,6)==0 & mdata(:,7)>=140 & mdata(:,7)<=149.9),4)=2;
mtab(find(mdata(:,6)==0 & mdata(:,7)>=150 & mdata(:,7)<=159.9),4)=2;
mtab(find(mdata(:,6)==0 & mdata(:,7)>=160),4)=3;

%SBP with medication

mtab(find(mdata(:,6)>0 & mdata(:,7)<120),4)=0;
mtab(find(mdata(:,6)>0 & mdata(:,7)>=120 & mdata(:,7)<=129.9),4)=2;
mtab(find(mdata(:,6)>0 & mdata(:,7)>=130 & mdata(:,7)<=139.9),4)=3;
mtab(find(mdata(:,6)>0 & mdata(:,7)>=140 & mdata(:,7)<=149.9),4)=4;
mtab(find(mdata(:,6)>0 & mdata(:,7)>=150 & mdata(:,7)<=159.9),4)=4;
mtab(find(mdata(:,6)>0 & mdata(:,7)>=160),4)=5;

%Smoker

mtab(find(mdata(:,8)==0),5)=0;
mtab(find(mdata(:,8)==1),5)=4;

%Diabetes

mtab(find(mdata(:,9)==0),6)=0;
mtab(find(mdata(:,9)==1),6)=3;

%Summing points

mtab(:,7)=sum(mtab(:,1:6),2);

%Score calculation

[ind, loc]=ismember(mtab(:,7),mchart(:,1));
loc(find(mtab(:,7)>18))=22;
loc(find(mtab(:,7)<-3))=1;

mtab(:,8)=mchart(loc,2);

patdata(fmind,10:11)=ftab(:,7:8);
patdata(mlind,10:11)=mtab(:,7:8);

dlmwrite('fram_scores_data.txt', patdata(:,[1 10 11]), 'precision', '%10.1f', 'delimiter', ' ');