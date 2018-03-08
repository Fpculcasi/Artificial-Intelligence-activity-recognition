%% Feature Selection
% Principal components analysis
coeff = zeros(size(newFeaturesA),1);
[pc,score,latent,tsquare] = princomp(zscore(...
	[newFeaturesA newFeaturesB newFeaturesC newFeaturesD]));
for k=1:5
	[~,x] = max(latent);
	coeff(x) = 1;
	latent(x) = 0;
end
coeff
