%% 06 Neural network

% "What's the best number of hidden neurons?"
inputs = X(:,fs)';
targets = zeros(4,size(Y,1));
targets(1,1:sizeA) = 1;
targets(2,sizeA+1:sizeA+sizeB) = 1;
targets(3,sizeA+sizeB+1:sizeA+sizeB+sizeC) = 1;
targets(4,sizeA+sizeB+sizeC+1:end) = 1;

n1 = 1;  % lowest number of hidden neurons
n2 = 10; % highest number of hidden neurons
performances = zeros(10,1);
regressions = zeros(10,4);
meanPerformance = zeros(n2-n1+1,1);
meanRegression = zeros(n2-n1+1,4);

for n = n1:1:n2,
    % Create a Pattern Recognition Network
    hiddenLayerSize = n;

    for k=1:10,
        net = patternnet(hiddenLayerSize);
        % Setup Division of Data for Training, Validation, Testing
        net.divideParam.trainRatio = 70/100;
        net.divideParam.valRatio = 15/100;
        net.divideParam.testRatio = 15/100;
        
        % hide window: speed up computations
        net.trainParam.showWindow = false;

        % Train the Network
        [net,~] = train(net,inputs,targets);
        
        % Test the Network
        outputs = net(inputs);
        performances(k) = perform(net,targets,outputs);
        [regressions(k,:),~,~] = regression(targets,outputs);
    end
    meanRegression(n,:) = mean(regressions);
    meanPerformance(n) = mean(performances);
end

if showPlots
    figure, plot(n1:n2, meanPerformance, 'r-o');
    title('MSE: less is better');
    ylabel('mean square error');
    xlabel('# of hidden neurons');
    legend('mean performance');

    figure, plot(n1:n2, meanRegression, 'g-o');
    title('R-value: correlation between output and targets');
    ylabel('Regression coefficent');
    xlabel('# of hidden neurons');
    legend('mean regression');
end

%% Train the neural network
% Best among the networks with chosen number of hidden neurons
[~,hiddenLayerSize] = min(meanPerformance);
p = inf;
for k=1:10,
    net_temp = patternnet(hiddenLayerSize);
    % Setup Division of Data for Training, Validation, Testing
    net_temp.divideParam.trainRatio = 70/100;
    net_temp.divideParam.valRatio = 15/100;
    net_temp.divideParam.testRatio = 15/100;

    % hide window: speed up computations
    net_temp.trainParam.showWindow = false;

    % Train the Network
    [net_temp,tr_temp] = train(net_temp,inputs,targets);

    % Test the Network
    outputs = net_temp(inputs);
    p_temp = perform(net_temp,targets,outputs);
    if(p_temp < p),
        best_net = net_temp;
        p = p_temp;
        tr = tr_temp;
    end
end

%% Print evaluations

outputs = best_net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(best_net,targets,outputs);

% % View the Network
% view(best_net)
% 
% % Plots
% figure, plotperform(tr)
% figure, plottrainstate(tr)
% figure, plotconfusion(targets,outputs)
% figure, ploterrhist(errors)

[actual,~,~] = find(targets);
[~,predict] = max(outputs);
cfmatrix2(actual',predict,[1 2 3 4], 1, 1);
