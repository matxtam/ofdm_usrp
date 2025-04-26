% a = datetime;
a = tic;
b = 1:10;
c = 1:10;
parfor i = 1
end
d = toc(a);
% ap = datetime;
% fprintf("%s", ap - a);
%% 
close all; clc;
% test code
ii=1;
range = sec_index(1,ii):sec_index(2,ii);
conv_sig_LTS = abs(conv(buffer_big(range), flipud(conj(single_LTS)), "valid"));
crit_lts = max(abs(conv_sig_LTS))-0.3;
lts_peaks = find(abs(conv_sig_LTS) >= crit_lts);
lts_start = sec_index(1,ii) + lts_peaks(1)-1;
ofdm_start = lts_start + 2*64;
plot(range(1:440), real(buffer_big(range(1:440))));
hold on;
stem(lts_start(ii), 6);
hold on;
stem(ofdm_start(ii), 6);
hold on;
plot((1:length(conv_sig_LTS))+sec_index(1,ii)-1, abs(conv_sig_LTS))
legend('1','2','3')

%% 
close all; clc;
ii=1;
range = sec_index(1,ii):sec_index(2,ii);
conv_sig_LTS = abs(conv(buffer_big(range), flipud(conj(single_LTS)), "valid"));
temp = abs(conv(buffer_big(range), flipud(conj(single_LTS)), "same"));
crit_lts = max(abs(conv_sig_LTS))-0.3;

lts_peaks = find(abs(conv_sig_LTS) >= crit_lts);
lts_start = sec_index(1,ii) + lts_peaks(1)-1;
ofdm_start = lts_start + 2*64;

stem(lts_start, 7);
hold on;
stem(ofdm_start, 7);
hold on;
plot(range, temp(range-sec_index(1,ii)+1))
%% 
conv_sig_LTS = abs(conv(buffer_big, flipud(conj(single_LTS)), "valid"));
plot(conv_sig_LTS)
hold on;
stem(ofdm_start, 6*ones(size(ofdm_start)));
hold on;
stem(lts_start, 6*ones(size(lts_start)));
xlim([9000, 12000])
%% 
short = buffer_big(10090:18610);
conv_sig_LTS = conv(short, flipud(conj(single_LTS)), "valid"); % inden range should be adjusted
plot(abs(conv_sig_LTS))
crit_lts = max(abs(conv_sig_LTS))-0.3;
lts_peaks = find(abs(conv_sig_LTS) >= crit_lts);
%% 

close all;
semilogy(SNR_big_13(1:3), BER_big_13(1:3), Marker="square", Color='blue')
hold on;
semilogy(SNR_big_13(4:6), BER_big_13(4:6), Marker="square", Color='blue')
title('13. BER vs SNR in dB in 4-QAM scheme');
xlabel('SNR (db)')
ylabel('BER (in log scale)')
xlim([-80, 45])
ylim([1e-5, 1])
