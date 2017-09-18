data=dlmread('../build_sp/target_pop2_input.txt');
newtpind=(data(:,6)+(data(:,7)<60)+(data(:,8)>=15)+(data(:,9)>=75))>=1;
ov_elig=dlmread('../build_sp/overall_elig2.txt');
trt_elig=dlmread('../build_sp/elig_traits_tp2.txt');
spectp=1; %SPRINT specific TP
if (spectp==1)
    data=data(find(newtpind==1),:);
    ov_elig=ov_elig(find(newtpind==1),:);
    trt_elig=trt_elig(find(newtpind==1),:);
end
catv=categorical(data(:,1:6));

siz=size(data,1);

% Apply Gower's Normalization
high=repmat(max(data),siz,1);
low=repmat(min(data),siz,1);

data1=(data-low)./high;

% Calculate trait significance
sig=1-sum(trt_elig)./siz;

% Apply trait significance
data2=repmat(sig,siz,1).*data1;

tbl=table(catv(:,1),catv(:,2),catv(:,3),catv(:,4),catv(:,5),catv(:,6),data2(:,7),data2(:,8),data2(:,9),data2(:,10),data(:,11),data(:,12));

% Calculating SVM REgression surface
mdl = fitrsvm(tbl,'Var12','KernelFunction','gaussian','KernelScale','auto');
ypred = resubPredict(mdl);

residuals=abs(ypred-data2(:,9));
weights=1./(1.0+abs(residuals));

% Calculating GIST scores
mgist=sum(weights.*ov_elig)/sum(weights);

nofeat=size(data,2);
sgist=zeros(nofeat,1);
trt_elig(:,6)=repmat(min(1,sum(trt_elig(:,6:9),2)),1,4);
for i=1:nofeat
     sgist(i)=sum(trt_elig(:,i).*weights)/sum(weights);
end

% Order of traits

% Diabetes - Exclusion
% Stroke - Exclusion
% Proteinuria - Exclusion
% Heart failure - Exclusion
% End stage kidney failure - Exclusion
% Previous CHD (part of high CVD risk) - Inclusion
% Chronic kidney disease (part of high CVD risk) - Inclusion
% Framigham risk over 30% - (part of high CVD risk) - Inclusion
% Seniority (age>75) - (part of high CVD risk) - Inclusion
% SBP (part of sbp+medication trait) - Inclusion
% Hypertensive medications (part of sbp+medications trait) - Inclusion
% Age - Inclusion