%% 08 ANFIS
inputs2 = [inputs actual];

index = randperm(size(inputs2,1));

indTrain = floor(size(inputs2,1)*70/100);
indTest = floor(size(inputs2,1)*15/100);
% indVal = floor(size(inputs2,1)*15/100);

inTrain = inputs2(index(1:indTrain),:);
inTest = inputs2(index(indTrain+1:indTrain+indTest),:);
inVal = inputs2(index(end-indTest:end),:);

sugeno = mam2sug(mamdani);

anfisedit;

%%
outputs = evalfis(inputs,sugeno0);

if(showPlots),
    figure,
    plot(1:size(outputs,1),targets.*5,'bo',1:size(outputs,1),outputs,'rx');
    title('Result of Mamdani FIS');
    xlabel('inputs');
    ylabel('classes');
    legend('target class','output class');
end

% just to better understand plot
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

cfmatrix2(actual',outputs',[1 2 3 4], 0, 1);
%%
outputs = evalfis(inputs,sugeno2);

if(showPlots),
    figure,
    plot(1:size(outputs,1),targets.*5,'bo',1:size(outputs,1),outputs,'rx');
    title('Result of Mamdani FIS');
    xlabel('inputs');
    ylabel('classes');
    legend('target class','output class');
end

% just to better understand plot
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

cfmatrix2(actual',outputs',[1 2 3 4], 0, 1);
