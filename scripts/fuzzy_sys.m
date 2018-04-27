%% 07 Fuzzy inference system
% How to define good membership functions?
% try to plot the distributions of values for every feature and choice the
% most separated, i.e. choice the features that better help to distinguish
% among classes of position/activities

% Plot boxplots to better distinguish among mean, quartiles, max and min of
% every feature distribution
if(showPlots),
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
end

%% Plot PDF of every feature to ease the definition of membership functions

if(showPlots),
    for k=mod(find(fs),29), % features
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
end

%%

fs(:)=0;
fs([27 36 40 45]) = 1;

% mamdani = readfis('mamdani.fis');
mamdani = readfis('mamdani.fis');

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

outputs = evalfis(inputs,mamdani);
% errors = gsubtract(targets,outputs);
% pre_error = sqrt(mean(errors.^2))

if(showPlots),
    figure,
    plot(1:size(outputs,1),targets,'bo',1:size(outputs,1),outputs,'rx');
    hold on;
    plot(1:size(outputs,1),zeros(1,size(outputs,1)),'k--');
    plot(1:size(outputs,1),0.3*ones(1,size(outputs,1)),'k--');
    plot(1:size(outputs,1),0.5*ones(1,size(outputs,1)),'k--');
    plot(1:size(outputs,1),0.7*ones(1,size(outputs,1)),'k--');
    plot(1:size(outputs,1),ones(1,size(outputs,1)),'k--');
    title('Result of Mamdani FIS');
    xlabel('inputs');
    ylabel('classes');
    legend('target class','output class');
end

% just to better understand plot
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
end

% figure,
% plot(1:size(outputs,1),targets,'bo',1:size(outputs,1),outputs,'rx');
% title('Result of Mamdani FIS');
% xlabel('inputs');
% ylabel('classes');
% legend('target class','output class');

% figure, plot(outputs(1:size1),1:size1,'bo');
% hold on;
% plot(outputs(size1+1:size2),size1+1:size2,'go');
% plot(outputs(size2+1:size3),size2+1:size3,'ro');
% plot(outputs(size3+1:end),size3+1:size4,'ko');

cfmatrix2(actual',(outputs.*5)',[1 2 3 4], 0, 1);

clear k;
