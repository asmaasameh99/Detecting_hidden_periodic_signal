% Made by Aya_Mohamed , ID 149
clc;
clear all;
close all;
load n2.mat
%we divided the whole signal to 11 figures to determine which part has the
%hidden periodic signal and went through the spectrogram technique to find
%the hidden signal
s1=n2(1:500);
spectrogram(s1)
figure
s2=n2(500:1000);
spectrogram(s2)
figure
s3=n2(1000:2000);
spectrogram(s3)
figure
s4=n2(2000:3000);
spectrogram(s4)
figure
s5=n2(3000:4000);
spectrogram(s5)
figure
s6=n2(4000:5000);
spectrogram(s6)
figure
s7=n2(5000:6000);
spectrogram(s7)
figure
s8=n2(6000:7000);
spectrogram(s8)
figure
s9=n2(7000:8000);
spectrogram(s9)
figure
s10=n2(8000:9000);
spectrogram(s10)
figure
s11=n2(9000:10000);
spectrogram(s11)
figure
%11 figures are plotted and we doubted that the periodic signal is inserted in figure 1 and the
%autocorrelation proved this

%cropping this detected part and plotting it 
s1cropped=s1(:,1:500); %cropping s1 in which the periodic signal is inserted
subplot(3,1,1)
plot(s1cropped)
title('the cropped periodic signal')

%the filter used to remove the noise from the noisy cropped periodic signal
windowwidth = 27; %method of implementing filter
polynomialorder = 4; %order of the filter
smoothm = sgolayfilt(s1cropped, polynomialorder, windowwidth); %the filter used
subplot(3,1,2);
plot(smoothm);
title('Smoothed Signal');
% we deduced the length of the signal using the data cursor and it is estimated to be L=239
%also the location S=[x,y]=[106,0.9099] in the 1st figure scaled from 1:500

%autocorrelation
norm=smoothm-mean(smoothm);
[corr,lags]=xcorr(smoothm,smoothm); %this returns the lags at which the correlations are computed
subplot(3,1,3)
plot(lags,corr)
title('autocorrelated signal')
%to get the period of the signal
 [pks,locs]=findpeaks(corr); %this returns the indices at which the peaks occur
mean1=mean(diff(locs));
mean2=mean(pks);
%use the peak locations returned by findpeaks to compute the mean interval between maxima
[pks,locs]=findpeaks(corr,'MinPeakDistance',ceil(mean1),'MinPeakHeight',ceil(mean2));
diff(locs)
mean(diff(locs))
% we deduced that the period=24.5556

%to determine the amplitude of the signal
mdft = fft(smoothm); % Obtain the DFT
k=2*abs(mdft/239); %length of the period L=239
maxk=max(k);
%we got that the amplitude of the signal=0.9341







% subplot(3,1,1)
% plot(s1cropped)
% title('the cropped periodic signal')
% %autocorrelation
% m=xcorr(s1cropped,s1cropped);
% subplot(3,1,2)
% plot(m)
% title('autocorrelated signal')
% 
% %to remove the noise from the noisy periodic signal and get a smooth signal
% windowwidth = 27; %method of implementing filter
% polynomialorder = 4; %order of the filter
% smoothm = sgolayfilt(m, polynomialorder, windowwidth); %the filter used
% subplot(3,1,3);
% plot(smoothm);
% title('Smoothed Signal');
% 
% %to determine the amplitude of the signal
% mdft = fft(smoothm); % Obtain the DFT
% %  camp = 2/length(smoothm)*mdft(101);
% %  abs(camp)  % amplitude
% %  angle(camp) % phase
% % camp=2*abs(mdft/length(smoothm));
% % subplot(4,1,4)
% % plot(camp)