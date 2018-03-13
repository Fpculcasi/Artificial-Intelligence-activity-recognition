%% 03 Data cleaning - cleaning.m
% Clean the signal from noise by mean of a smoothing filter
% (Savitzky-Golay Filter), sgolayfilt(X,K,F):
%  - K=3, third-order polynomial;
%  - F=7, just an odd value greater than the piece of signal;

clear smoothA;
smoothA = sgolayfilt(A,3,7);
if showPlots
    figure, plot(0.082*(1:size(smoothA,1)),[A(:,1) smoothA(:,1)])
    title('Volunteer 1 - Stairs (Slice 1)');
    xlabel('time [s]');
    ylabel('pressure [ohm]');
    legend('sensor 1 - original', 'sensor 1 - smooth');
end

clear smoothB;
smoothB = sgolayfilt(B,3,7);

clear smoothC;
smoothC = sgolayfilt(C,3,7);

clear smoothD;
smoothD = sgolayfilt(D,3,7);

% Use Z-score normalization for each signal, in order to be able to compare
% signals.
smoothA = zscore(smoothA);
smoothB = zscore(smoothB);
smoothC = zscore(smoothC);
smoothD = zscore(smoothD);

if showPlots
    figure, plot(0.082*(1:size(smoothA)),smoothA(:,1:4))
    title('Volunteer 1 - Stairs (Slice 1)');
    xlabel('time [s]');
    ylabel('pressure [ohm]');
    legend('sensor 1', 'sensor 2', 'sensor 3', 'sensor 4');
end
