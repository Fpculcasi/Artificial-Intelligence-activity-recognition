%% 04 Feature extraction - featureEx.m
% Obtain a set of temporal feature starting from the N(j) samples of the
% signal.
featuresA = [max(smoothA); min(smoothA); quantile(smoothA,[.25 .5]); ...
    skewness(smoothA); kurtosis(smoothA)];
featuresB = [max(smoothB); min(smoothB); quantile(smoothB,[.25 .5]); ...
    skewness(smoothB); kurtosis(smoothB)];
featuresC = [max(smoothC); min(smoothC); quantile(smoothC,[.25 .5]); ...
    skewness(smoothC); kurtosis(smoothC)];
featuresD = [max(smoothD); min(smoothD); quantile(smoothD,[.25 .5]); ...
    skewness(smoothD); kurtosis(smoothD)];

% Autocorrelation: computed at lags 0,1,2, ... T= min[20,length(y)-1]
RxxA = my_autocorr(smoothA); % See my_autocorr.m
RxxB = my_autocorr(smoothB);
RxxC = my_autocorr(smoothC);
RxxD = my_autocorr(smoothD);

if showPlots
    figure('units','normalized','outerposition',[0 0 1 1]);
    
    subplot(2,2,1);
    plot(0:20,RxxA);
    title('Supine - All the volunteers, all the autocorrelations');
    xlabel('lags');
    ylabel('Rxx');
    
    subplot(2,2,2);
    plot(0:20,RxxB);
    title('Dorsifexion - All the volunteers, all the autocorrelations');
    xlabel('lags');
    ylabel('Rxx');
    
    subplot(2,2,3);
    plot(0:20,RxxC);
    title('Walk - All the volunteers, all the autocorrelations');
    xlabel('lags');
    ylabel('Rxx');
    
    subplot(2,2,4);
    plot(0:20,RxxD);
    title('Stairs - All the volunteers, all the autocorrelations');
    xlabel('lags');
    ylabel('Rxx');
end

% first value, autocorr with lags=0 is always equal to 1
% (it's irrelevant)
featuresA = [featuresA; RxxA(2:end,:)];
featuresB = [featuresB; RxxB(2:end,:)];
featuresC = [featuresC; RxxC(2:end,:)];
featuresD = [featuresD; RxxD(2:end,:)];

clear RxxA RxxB RxxC RxxD;

% Frequential features:
% - Fundamental frequency f0
% - Power Spectral Density PSD

% Define the frequency domain
f = 12.2*(0:N(index)/2-1);

% Compute the single-sided spectrum
fftA = my_fft(smoothA,N(index)); % See my_fft.m
fftB = my_fft(smoothB,N(index));
fftC = my_fft(smoothC,N(index));
fftD = my_fft(smoothD,N(index));

if(showPlots)
    figure('units','normalized','outerposition',[0 0 1 1]);
    
    subplot(2,2,1);
    plot(f,fftA);
    title('Supine - All the volunteers, all the spectra');
    xlabel('frequency [Hz]');
    ylabel('FFT');
    
    subplot(2,2,2);
    plot(f,fftB);
    title('Dorsifexion - All the volunteers, all the spectra');
    xlabel('frequency [Hz]');
    ylabel('FFT');
    
    subplot(2,2,3);
    plot(f,fftC);
    title('Walk - All the volunteers, all the spectra');
    xlabel('frequency [Hz]');
    ylabel('FFT');
    
    subplot(2,2,4);
    plot(f,fftD);
    title('Stairs - All the volunteers, all the spectra');
    xlabel('frequency [Hz]');
    ylabel('FFT');
end

% The max amplitude should be a good approximation for the fundamental
% frequency
[amp, x] = max(fftA); 
% [~, x2] = findpeaks(fftA, 'MinPeakProminence', 0.7*max(fftA));

% PSD
PSD = sum(fftA.^2);
% figure
% plot(f,fftA(:,[1 11 111]));
% hold on;
% plot(f(x([1 11 111])),y([1 11 111]),'rv');
featuresA = [featuresA; f(x); amp; PSD];

[amp, x] = max(fftB);
featuresB = [featuresB; f(x); amp; sum(fftB.^2)];
[amp, x] = max(fftC); 
featuresC = [featuresC; f(x); amp; sum(fftC.^2)];
[amp, x] = max(fftD); 
featuresD = [featuresD; f(x); amp; sum(fftD.^2)];

clear smoothA smoothB smoothC smoothD f i fftA fftB fftC fftD amp x PSD;

%% Rotate matrix
% Since we use 4 columns to represent 3 sensor signals + 1 "virtual"
% sensor (the sum), we move all the features of the same piece of signal
% on the same column.
newFeaturesA = rotate_features(featuresA);
newFeaturesB = rotate_features(featuresB);
newFeaturesC = rotate_features(featuresC);
newFeaturesD = rotate_features(featuresD);

clear featuresA featuresB featuresC featuresD;
