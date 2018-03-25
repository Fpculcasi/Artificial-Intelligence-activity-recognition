%% 07 Fuzzy inference system
% How to define good membership functions?
% try to plot the distributions of values for every feature and choice the
% most separated, i.e. choice the features that better help to distinguish
% among classes of position/activities

for k=1:27,
    figure, histogram(newFeaturesA([k 27+k 54+k 81+k],:),20);
    hold on;
    histogram(newFeaturesB([k 27+k 54+k 81+k],:),20);
    histogram(newFeaturesC([k 27+k 54+k 81+k],:),20);
    histogram(newFeaturesD([k 27+k 54+k 81+k],:),20);
    title(strcat('PDF of feature ',num2str(k)));
    legend('supine','dorsiflexion','walking','stair');
end

%%
for w=1:4,
    for k=1:27,
        figure, histogram(newFeaturesA(((w-1)*27)+k,:),20);
        hold on;
        histogram(newFeaturesB(((w-1)*27)+k,:),20);
        histogram(newFeaturesC(((w-1)*27)+k,:),20);
        histogram(newFeaturesD(((w-1)*27)+k,:),20);
        title_str = strcat('PDF of feature ',num2str(k));
        title_str = strcat(title_str,', sensor ');
        title_str = strcat(title_str,num2str(w));
        title(title_str);
        clear title_str;
        legend('supine','dorsiflexion','walking','stair');
    end
end

%%
inputs = X(:,[86 87 88 106]);
inputs = [inputs actual];
