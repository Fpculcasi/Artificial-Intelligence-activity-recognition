%% 05 Feature Selection
% Sequential feature selection

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
% 
% % Randomly order activities features
% perm = randperm(size(Y));
% X = X(perm,:);
% Y = Y(perm);
% 
% % Divide dataset in training/test datasets
% w = 0.7*size(Y);
% XT = X(1:w, :); Xt = X(w+1:end, :);
% YT = Y(1:w); Yt = Y(w+1:end);

f = @(xtrain, ytrain, xtest, ytest) ...
    sum(ytest ~= classify(xtest, xtrain, ytrain));
opts = statset('display','iter');

[fs, history] = sequentialfs(f,X,Y,'nfeatures',10,'options',opts);