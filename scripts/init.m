%% 01 Data initialization - init.m
% - Data are grouped by activity/position and collected in a structure.
addpath('gitProjects/intelligent-system/');
load('ProjectWS.mat');

% This variable disable plots, so to fast computations.
showPlots = false;

% Neglect first row, it's just a row of zeros for every activity.
supine = {V01A(2:end,:), V02A(2:end,:), V03A(2:end,:), V04A(2:end,:),...
    V05A(2:end,:), V06A(2:end,:), V07A(2:end,:), V08A(2:end,:), ...
    V09A(2:end,:), V10A(2:end,:)};

dorsiflexion = {V01B(2:end,:), V02B(2:end,:), V03B(2:end,:), ...
    V04B(2:end,:), V05B(2:end,:), V06B(2:end,:), V07B(2:end,:), ...
    V08B(2:end,:), V09B(2:end,:), V10B(2:end,:)};

walking = {V01C(2:end,:), V02C(2:end,:), V03C(2:end,:), V04C(2:end,:),...
    V05C(2:end,:), V06C(2:end,:), V07C(2:end,:), V08C(2:end,:), ...
    V09C(2:end,:), V10C(2:end,:)};

stair = {V01D(2:end,:), V02D(2:end,:), V03D(2:end,:), V04D(2:end,:),...
    V05D(2:end,:), V06D(2:end,:), V07D(2:end,:), V08D(2:end,:), ...
    V09D(2:end,:), V10D(2:end,:)};

% Build the structure.
Struct = struct('supine',supine,'dorsiflexion',dorsiflexion,'walking',...
    walking,'stair',stair);

for i=1:10
    % - Create a new signal as the sum of the three existing components
    %   and append at the other components.
    Struct(i).supine = ...
        [Struct(i).supine(:,4), Struct(i).supine(:,1:3), ...
        sum(Struct(i).supine(:,1:3),2)];
    Struct(i).dorsiflexion = ...
        [Struct(i).dorsiflexion(:,4), Struct(i).dorsiflexion(:,1:3), ...
        sum(Struct(i).dorsiflexion(:,1:3),2)];
    Struct(i).walking = ...
        [Struct(i).walking(:,4), Struct(i).walking(:,1:3), ...
        sum(Struct(i).walking(:,1:3),2)];
    Struct(i).stair = ...
        [Struct(i).stair(:,4), Struct(i).stair(:,1:3), ...
        sum(Struct(i).stair(:,1:3),2)];
 
    % - Plot of each volunteer's activity/position signal and boxplot
    %   to better show patterns, time features, probability distribution.
    if showPlots
        % full screen figure
        figure('units','normalized','outerposition',[0 0 1 1]);
    
        subplot(2,3,1);
        plot(Struct(i).supine(:,1),Struct(i).supine(:,2:5));
        title(strcat('Supine - volunteer ',num2str(i)));
        legend('sensor1','sensor2','sensor3','sum');
        xlabel('time [s]');
        ylabel('pressure [ohm]');

        subplot(2,3,2);
        plot(Struct(i).dorsiflexion(:,1),Struct(i).dorsiflexion(:,2:5));
        title(strcat('Dorsiflexion - volunteer ',num2str(i)));
        legend('sensor1','sensor2','sensor3','sum');
        xlabel('time [s]');
        ylabel('pressure [ohm]');

        subplot(2,3,4);
        plot(Struct(i).walking(:,1),Struct(i).walking(:,2:5));
        title(strcat('Walking - volunteer ',num2str(i)));
        legend('sensor1','sensor2','sensor3','sum');
        xlabel('time [s]');
        ylabel('pressure [ohm]');

        subplot(2,3,5);
        plot(Struct(i).stair(:,1),Struct(i).stair(:,2:5));
        title(strcat('Stairs - volunteer ',num2str(i)));
        legend('sensor1','sensor2','sensor3','sum');
        xlabel('time [s]');
        ylabel('pressure [ohm]');

        subplot(2,3,[3 6]);
        var = [Struct(i).supine(:,5)' Struct(i).dorsiflexion(:,5)'...
            Struct(i).walking(:,5)' Struct(i).stair(:,5)'];
        var = var./3;
        grp = [zeros(1,length(Struct(i).supine)), ...
            ones(1,length(Struct(i).dorsiflexion)), ...
            2.*ones(1,length(Struct(i).walking)), ...
            3.*ones(1,length(Struct(i).stair))];
        boxplot(var,grp,'Labels',{'supine','dorsiflexion','walking',...
            'stair'});
    end
end

clear supine dorsiflexion walking stair i;

% clean origen structures
clear V01A V01B V01C V01D ...
    V02A V02B V02C V02D ...
    V03A V03B V03C V03D ...
    V04A V04B V04C V04D ...
    V05A V05B V05C V05D ...
    V06A V06B V06C V06D ...
    V07A V07B V07C V07D ...
    V08A V08B V08C V08D ...
    V09A V09B V09C V09D ...
    V10A V10B V10C V10D;