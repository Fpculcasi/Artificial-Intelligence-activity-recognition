%% 07 Fuzzy inference system
% How to define good membership functions?
% try to plot the distributions of values for every feature and choice the
% most separated, i.e. choice the features that better help to distinguish
% among classes of position/activities

% Plot boxplots to better distinguish among mean, quartiles, max and min of
% every feature distribution
for k=mod(find(fs),29),
    
    figure,
    for w=0:3
        subplot(2,2,w+1);
        var = [newFeaturesA(w*29 + k,:)'; ...
            newFeaturesB(w*29 + k,:)'; ...
            newFeaturesC(w*29 + k,:)';  ...
            newFeaturesD(w*29 + k,:)'];
        grp = [zeros(1,size(newFeaturesA,2)), ...
            ones(1,size(newFeaturesB,2)), ...
            2.*ones(1,size(newFeaturesC,2)), ...
            3.*ones(1,size(newFeaturesD,2))];
        boxplot(var,grp,'Labels',{'A','B','C','D'});
        tmp_title = 'Feature ';
        tmp_title = strcat(tmp_title,num2str(k));
        tmp_title = strcat(tmp_title,', sensor ');
        tmp_title = strcat(tmp_title,num2str(w+1));
        tmp_title = strcat(tmp_title,': alias ');
        tmp_title = strcat(tmp_title,num2str(w*29 + k));
        title(tmp_title);
        clear tmp_title;
    end
end

%% Plot PDF of every feature to ease the definition of membership functions

for k=mod(find(fs),29), % feature
    figure,
    for w=0:3, % sensors
        subplot(2,2,w+1);
        [f,xi] = ksdensity(newFeaturesA(w*29+k,:));
        plot(xi,f);
        hold on;
        [f,xi] = ksdensity(newFeaturesB(w*29+k,:));
        plot(xi,f);
        [f,xi] = ksdensity(newFeaturesC(w*29+k,:));
        plot(xi,f);
        [f,xi] = ksdensity(newFeaturesD(w*29+k,:));
        plot(xi,f);
        title_str = strcat('Feat.',num2str(k));
        title_str = strcat(title_str,', sens.');
        title_str = strcat(title_str,num2str(w+1));
        title_str = strcat(title_str,', aka ');
        title_str = strcat(title_str,num2str(w*29+k));
        title(title_str);
        clear title_str;
        legend('supine','dorsiflexion','walking','stair');
    end
end

clear f xi;

%%
% mamdani = readfis('mamdani2.fis');

inputs = X(:,fs);
targets = zeros(size(Y,1),1);
targets(1:sizeA) = 0.1;
targets(sizeA+1:sizeA+sizeB) = 0.5;
targets(sizeA+sizeB+1:sizeA+sizeB+sizeC) = 0.7;
targets(sizeA+sizeB+sizeC+1:end) = 0.8;

outputs = evalfis(inputs,mamdani4);
errors = gsubtract(targets,outputs);

figure, plot(1:size(outputs,1),targets,'bo',1:size(outputs,1),outputs,'rx');
title('Result of Mamdani FIS');
xlabel('inputs');
ylabel('classes');
legend('target class','output class');

%% ANFIS
inputs = [inputs actual];

anfisedit;
