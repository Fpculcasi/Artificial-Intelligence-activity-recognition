%% 08 ANFIS

% - Use mam2sug to transform the previously define Mamdani FIS in a Sugeno
%   type FIS
sugeno = mam2sug(mamdani);
sugeno.name = 'sugeno';

inputs = [inputs actual];

%% Create balanced sets for training, test and validation
clear index indTrain indTest indVal inTrain inTest inVal;
for i = 1:4
    index = randperm(sizes(i)); % give some randomness to the sets
    
    indTrain = floor(sizes(i)*70/100);	% 70%
    indTest = floor(sizes(i)*15/100);   % 15%
    indVal = indTest;                   % 15%
    
    if i == 1
        inTrain = inputs(index(1:indTrain),:);
        inTest = inputs(index(indTrain+1:indTrain+indTest),:);
        inVal = inputs(index(end-indVal:end),:);
    else
        inTrain = [inTrain; inputs(index(1:indTrain)+cum_sizes(i-1),:)];
        inTest = [inTest; ...
            inputs(index(indTrain+1:indTrain+indTest)+cum_sizes(i-1),:)];
        inVal = [inVal; inputs(index(end-indVal:end)+cum_sizes(i-1),:)];
    end
end

anfisedit;

%%
% sugeno1 - ANFIS from loded FIS
outputs = evalfis(inVal(:,1:end-1),sugeno1);

if showPlots,
    figure,
    plot(1:size(outputs,1),targets(index(end-indTest:end),:).*5,'bo', ...
        1:size(outputs,1),outputs,'rx');
    title('Result of Sugeno ANFIS');
    xlabel('inputs');
    ylabel('classes');
    legend('target class','output class');
end

% just to better discriminate the output class
for k=1:size(outputs,1)
    if outputs(k)<1.5
        outputs(k) = 1;
    elseif outputs(k)<2.5
        outputs(k) = 2;
    elseif outputs(k)<3.5
        outputs(k) = 3;
    else
        outputs(k) = 4;
    end
end

cfmatrix2(inVal(:,end)',outputs',[1 2 3 4], 0, 1);
