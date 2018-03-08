%% Feature extraction - featureEx.m
% Obtain a set of temporal feature starting from the N(j) samples of the
% signal.
clear fftA fftB fftC fftD;

clear featuresA;
featuresA = [max(smoothA); min(smoothA); skewness(smoothA); ...
    kurtosis(smoothA)];
clear featuresB;
featuresB = [max(smoothB); min(smoothB); skewness(smoothB); ...
    kurtosis(smoothB)];
clear featuresC;
featuresC = [max(smoothC); min(smoothC); skewness(smoothC); ...
    kurtosis(smoothC)];
clear featuresD;
featuresD = [max(smoothD); min(smoothD); skewness(smoothD); ...
    kurtosis(smoothD)];

%% TODO: Autocorrelation
% computed at lags 0,1,2, ... T= min[20,length(y)-1]
clear RxxA;
RxxA = my_autocorr(smoothA); % See my_autocorr.m
clear RxxB;
RxxB = my_autocorr(smoothB);
clear RxxC;
RxxC = my_autocorr(smoothC);
clear RxxD;
RxxD = my_autocorr(smoothD);

if showPlots
    figure, plot(1:size(RxxA),RxxA);
    figure, plot(1:size(RxxA),RxxB);
    figure, plot(1:size(RxxA),RxxC);
    figure, plot(1:size(RxxA),RxxD);
end

featuresA = [featuresA; RxxA];
featuresB = [featuresB; RxxB];
featuresC = [featuresC; RxxC];
featuresD = [featuresD; RxxD];

%% Frequential features:
% - Fundamental frequency f0
% - Power Spectral Density PSD

% Define the frequency domain
f = 12.2*(0:N(index)/2-1);

% Compute the single-sided spectrum
fftA = my_fft(smoothA); % See my_fft.m
fftB = my_fft(smoothB);
fftC = my_fft(smoothC);
fftD = my_fft(smoothD);

% The max amplitude should be a good approximation for the fundamental
% frequency
[y, x] = max(fftA); 
% [~, x2] = findpeaks(fftA, 'MinPeakProminence', 0.7*max(fftA));

% PSD
PSD = sum(fftA.^2);
% figure
% plot(f,fftA(:,[1 11 111]));
% hold on;
% plot(f(x([1 11 111])),y([1 11 111]),'rv');
featuresA = [featuresA' f(x)' PSD']';

clear x;
[~, x] = max(fftB);
featuresB = [featuresB; f(x); sum(fftB.^2)];
clear x;
[~, x] = max(fftC); 
featuresC = [featuresC; f(x); sum(fftC.^2)];
clear x;
[~, x] = max(fftD); 
featuresD = [featuresD; f(x); sum(fftD.^2)];

%% Rotate matrix
% Since we use 4 columns to represent 3 sensor signals + 1 "virtual" sensor
% (the sum), we move all the features of the same piece of signal on the same
% column.
newFeaturesA = rotate_features(featuresA);
newFeaturesB = rotate_features(featuresB);
newFeaturesC = rotate_features(featuresC);
newFeaturesD = rotate_features(featuresD);
