cd('.\Data')

% load data
DF = readmatrix('MediationData.csv');
DF = zscore(DF);

xx = num2cell(DF(:,1));
yy = num2cell(DF(:,2));
mm = DF(:, 3:size(DF, 2));
mm_cell = cell(size(xx,1), 1);

for i=1:size(DF, 1)
   
    mm_cell{i} = mm(i,:)';
    
end

% compute PDM for 
pdm = multivariateMediation(xx,yy,mm_cell, 'B', 50, 'svd', 'plots');

varRetained = pdm.dat.M_tilde*pdm.dat.Dt;
sum(var(varRetained)/size(mm, 2))

cd('..\Results')
pdm2 = multivariateMediation(pdm, 'nPDM', 4, 'svd', 'bootPDM', 'Bsamp', 5, 'save2file', 'test.mat', 'returnbootsamples');


