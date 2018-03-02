%% Data cleaning - cleaning.m
% Clean the signal from noise by mean of a smoothing filter
% (Savitzky-Golay Filter), sgolayfilt(X,K,F):
%  - K=3, third-order polynomial
%  - F=7, just an odd value greater than the piece of signal

clear smoothA;
smoothA = sgolayfilt(A,3,7);
% plot(1:N(j),[A(:,1:4) smoothA(:,1:4)])

clear smoothB;
smoothB = sgolayfilt(B,3,7);

clear smoothC;
smoothC = sgolayfilt(C,3,7);

clear smoothD;
smoothD = sgolayfilt(D,3,7);
