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
RxxA = autocorr(smoothA(:,1));
for k=2:size(smoothA,2)
    RxxA = [RxxA autocorr(smoothA(:,k))];
end
clear RxxB;
RxxB = autocorr(smoothB(:,1));
for k=2:size(smoothB,2)
    RxxB = [RxxB autocorr(smoothB(:,k))];
end
clear RxxC;
RxxC = autocorr(smoothC(:,1));
for k=2:size(smoothC,2)
    RxxC = [RxxC autocorr(smoothC(:,k))];
end
clear RxxD;
RxxD = autocorr(smoothD(:,1));
for k=2:size(smoothD,2)
    RxxD = [RxxD autocorr(smoothD(:,k))];
end

if showPlots
    figure, plot(1:size(RxxA),RxxA);
    figure, plot(1:size(RxxA),RxxB);
    figure, plot(1:size(RxxA),RxxC);
    figure, plot(1:size(RxxA),RxxD);
end

%% Frequential features:
% - Fundamental frequency f0
% - Power Spectral Density PSD

% Define the frequency domain
f = 12.2*(0:N(index)/2-1);

% Compute the single-sided spectrum
fftA = fft(smoothA);
fftA = abs(fftA./N(index));
fftA(N(index)/2+1:end, :) = [];
fftA= 2.*fftA;

fftB = fft(smoothB);
fftB = abs(fftB./N(index));
fftB(N(index)/2+1:end, :) = [];
fftB= 2.*fftB;

fftC = fft(smoothC);
fftC = abs(fftC./N(index));
fftC(N(index)/2+1:end, :) = [];
fftC= 2.*fftC;

fftD = fft(smoothD);
fftD = abs(fftD./N(index));
fftD(N(index)/2+1:end, :) = [];
fftD= 2.*fftD;

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
featuresB = [featuresB' f(x)' sum(fftB.^2)']';
clear x;
[~, x] = max(fftC); 
featuresC = [featuresC' f(x)' sum(fftC.^2)']';
clear x;
[~, x] = max(fftD); 
featuresD = [featuresD' f(x)' sum(fftD.^2)']';
