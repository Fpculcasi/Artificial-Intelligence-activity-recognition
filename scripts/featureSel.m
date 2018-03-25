%% 05 Feature Selection
% Sequential feature selection

% Fix the number of features on which we would like to reduce each signal
num_features = 6;

% Classify each activity with a different class:
% Y = 0 => supine
% Y = 1 => dorsiflexion
% Y = 2 => walking
% Y = 3 => stairs
sizeA = size(newFeaturesA,2);
sizeB = size(newFeaturesB,2);
sizeC = size(newFeaturesC,2);
sizeD = size(newFeaturesD,2);
X = [newFeaturesA     newFeaturesB   newFeaturesC     newFeaturesD]';
Y = [zeros(sizeA,1);  ones(sizeB,1); 2*ones(sizeC,1); 3*ones(sizeD,1)];

f = @(xtrain, ytrain, xtest, ytest) ...
    sum(ytest ~= classify(xtest, xtrain, ytrain));
if showPlots
    opts = statset('display','iter');
    [fs, history] = sequentialfs(f,X,Y,'nfeatures',num_features,...
        'options',opts);
else
    [fs, history] = sequentialfs(f,X,Y,'nfeatures',num_features);
end
