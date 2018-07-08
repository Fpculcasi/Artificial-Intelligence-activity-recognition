%% 05 Feature Selection
% - Sequential feature selection
% How many feature are the needed feature to use in order to classify each
% activity?

% Each activity is classified with a different class:
% Y = 0 => supine
% Y = 1 => dorsiflexion
% Y = 2 => walking
% Y = 3 => stairs
sizes(1) = size(newFeaturesA,2);
sizes(2) = size(newFeaturesB,2);
sizes(3) = size(newFeaturesC,2);
sizes(4) = size(newFeaturesD,2);
cum_sizes(1) = sizes(1);
cum_sizes(2) = cum_sizes(1)+sizes(2);
cum_sizes(3) = cum_sizes(2)+sizes(3);
cum_sizes(4) = cum_sizes(3)+sizes(4);

X = [newFeaturesA     newFeaturesB   newFeaturesC     newFeaturesD]';
Y = [zeros(sizes(1),1);  ones(sizes(2),1); ...
    2*ones(sizes(3),1); 3*ones(sizes(4),1)];

f = @(xtrain, ytrain, xtest, ytest) ...
    sum(ytest ~= classify(xtest, xtrain, ytrain));
if showPlots
    opts = statset('display','iter');
    [~, ~] = sequentialfs(f,X,Y,'options',opts);
end

%% Once selected the number of features, fix it
num_features = 6;
[fs, ~] = sequentialfs(f,X,Y,'nfeatures',num_features);

clear f;
