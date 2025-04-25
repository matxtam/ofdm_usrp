load("0423_success_1.mat");
load("0424_100_single.mat");
addpath("./test_code/");

send_amp = 0.1;

padded_sig_100 = send_amp*[zeros(100, 1); sig_100; zeros(100, 1)];


figure(1);
plot(real(padded_sig_100));

l = length(10*padded_sig_100);
[radio_Tx,radio_Rx] = USRP_init(l);
buffer = zeros(40*l, 1);

% Transmit the frame we generate

% Transmit 15 zero frames 
% (Otherwise there will be no output.) 
% (I not yet know why this bug happens.)
tx_signal = repmat(padded_sig_100, 10, 1);
for ii = 1:10
    
    if ii == 8
        fprintf("%d", ii);
        tunderrun = radio_Tx(padded_sig_100);
    else
        tunderrun = radio_Tx(complex(zeros(l, 1)));
    end
    % step(radio_Rx);
    [rcvdSignal, ~, toverflow] = step(radio_Rx);
    buffer_((1+(ii-1)*l):(ii*l)) = rcvdSignal;
end

% Keep reception for 15 frames 
for ii = 11 : 40
    [rcvdSignal, ~, toverflow] = step(radio_Rx);
    buffer((1+(ii-1)*l):(ii*l)) = rcvdSignal;
end 

% To save new data, uncomment this line. 
% Otherwise, keep it commented so that rx_sig.mat won't be modified.
% save rx_sig.mat buffer

release(radio_Tx)
release(radio_Rx)

figure()
plot(real(buffer));
hold off;