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
    % Create a Fitting Network
    hiddenLayerSize = n;
    net = fitnet(hiddenLayerSize);

    for k=1:10,
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
[~,hiddenLayerSize] = min(meanPerformance);
net = fitnet(hiddenLayerSize);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Train the Network
[net,tr] = train(net,inputs,targets);

% Test the Network
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);

% View the Network
% view(net)

% Plots
% figure, plotperform(tr)
% figure, plottrainstate(tr)
figure, plotconfusion(targets,outputs)
% figure, ploterrhist(errors)