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
% mamdani = readfis('mamdani.fis');
mamdani5 = readfis('mamdani5.fis');

inputs = X(:,fs);

size1 = sizeA;
size2 = size1+sizeB;
size3 = size2+sizeC;
size4 = size3+sizeD;
targets = zeros(size(Y,1),1);
targets(1:size1) = 0.2;
targets(size1+1:size2) = 0.4;
targets(size2+1:size3) = 0.6;
targets(size3+1:end) = 0.8;

outputs = evalfis(inputs,mamdani5);
% errors = gsubtract(targets,outputs);
% pre_error = sqrt(mean(errors.^2))

figure, plot(1:size(outputs,1),targets,'bo',1:size(outputs,1),outputs,'rx');
title('Result of Mamdani FIS');
xlabel('inputs');
ylabel('classes');
legend('target class','output class');

% just to better understand plot
count = 0;
for k=1:size(outputs,1)
    if outputs(k)<0.3
        outputs(k) = 0.2;
    elseif outputs(k)<0.5
        outputs(k) = 0.4;
    elseif outputs(k)<0.7
        outputs(k) = 0.6;
    else
        outputs(k) = 0.8;
    end
    
    if outputs(k) == targets(k),
        count = count + 1;
    end
end

figure, plot(1:size(outputs,1),targets,'bo',1:size(outputs,1),outputs,'rx');
title('Result of Mamdani FIS');
xlabel('inputs');
ylabel('classes');
legend('target class','output class');

% figure, plot(outputs(1:size1),1:size1,'bo');
% hold on;
% plot(outputs(size1+1:size2),size1+1:size2,'go');
% plot(outputs(size2+1:size3),size2+1:size3,'ro');
% plot(outputs(size3+1:end),size3+1:size4,'ko');

cfmatrix2(actual',(outputs.*5)',[1 2 3 4], 1, 1);

%% ANFIS
inputs = [inputs actual];

anfisedit;
