function [sym_golden, sig_100] = multi_frame_generation(iter_time, ...
    num_symbol, L_sig_5_head, N_OFDM)
    sym_golden = zeros(48*num_symbol, iter_time); 
    sig_100    = zeros(L_sig_100, iter_time);
    for j = 1 : iter_time
    sig_100(1:length(STS), j) = STS;
    sig_100(length(STS)+1:length(STS)+length(LTS), j)= LTS;
        for ii = 0 : num_symbol-1
            X_golden    = ofdm_generate();              %f
            sig_a       = ifft(ifftshift(X_golden));    %t
            x_cp        = ofdm_addCP(sig_a);            %t
            x_cp        = x_cp/mean(abs(x_cp));         %t
            sym_golden(48*ii+1 : 48*(ii+1), j) = X_golden(data_idx);
            sig_100(L_sig_5_head + ii*(N_OFDM)+1 : ...
                    L_sig_5_head + (ii+1)*(N_OFDM), j) = x_cp;
        end
    % sig_100(L_sig_5_head+1:end, j) = sig_100(L_sig_5_head+1:end, j) ...
    %                        /mean(abs(sig_100(L_sig_5_head+1:end, j)));
    end
end