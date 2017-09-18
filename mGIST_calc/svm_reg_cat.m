data=dlmread('../build_sp/target_pop1_input.txt');
ov_elig=dlmread('../build_sp/overall_elig.txt');
trt_elig=dlmread('../build_sp/elig_traits_tp1.txt');
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
catv=categorical(data2(:,1:6));
tbl=table(catv(:,1),catv(:,2),catv(:,3),catv(:,4),catv(:,5),catv(:,6),data2(:,7),data2(:,8),data2(:,9));

% Calculating SVM REgression surface
mdl = fitrsvm(tbl,'Var9','KernelFunction','gaussian','KernelScale','auto');
ypred = resubPredict(mdl);

residuals=abs(ypred-data2(:,9));
weights=1./(1.0+abs(residuals));

% Calculating GIST scores
mgist=sum(weights.*ov_elig)/sum(weights);

nofeat=size(data,2);
sgist=zeros(nofeat,1);
for i=1:nofeat
     sgist(i)=sum(trt_elig(:,i).*weights)/sum(weights);
end

% Order of traits

% High CVD risk criteria - Inclusion
% Diabetes - Exclusion
% Stroke - Exclusion
% Proteinuria - Exclusion
% Heart failure - Exclusion
% End stage kidney failure - Exclusion
% SBP (part of sbp+medication trait) - Inclusion
% Hypertensive medications (part of sbp+medications trait) - Inclusion
% Age - Inclusion

