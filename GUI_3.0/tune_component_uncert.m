function [h_opt, f_opt, j_opt, J] = tune_component_uncert(h, Fsk)

H = fft(h);
[L, M] = size(h);

lin_h = [0:L-1]';

N_200 = ceil(L/Fsk*400);
[i_beg, i_end] = find_correct(H(1:N_200+1,:));

[J_part, J_der, j0, n0] = calc_fun_uncert(H);
J = sum(J_part);

N_iter = zeros(1,M-1);
for k = 1:M-1,
    ind = [i_beg(k):i_end(k)]'-1;
    N_ind = length(ind);
    flag_new = true;
    while (flag_new == true),
        N_iter(k) = N_iter(k)+1;
        flag_new = false;
        dH = zeros(N_ind,M);
        for n=1:N_ind,
            i_corr = [k, k+1];
            dH(n,i_corr) = J_der(ind(n)+1,i_corr) - sum(J_der(ind(n)+1,i_corr),2)/2*ones(1,2);
        end
    
        while (max(max(abs(dH))) > 1e-6),
            H_new = H;
            H_new(ind+1,:) = H_new(ind+1,:) - dH*0.1;
            [J_part_new, J_der_new, j0_new, n0_new] = calc_fun_uncert(H_new);
            J_new = sum(J_part_new);
            if (J > J_new),
                %disp(J_new);
                J = J_new;
                J_der = J_der_new;
                H = H_new;
                j0 = j0_new;
                n0 = n0_new;
                flag_new = true;
                break;
            else
                dH = dH/2;
            end
        end
    end
end
%disp(J/norm(H));
%disp(N_iter);

f_opt = n0/L*Fsk;
h_opt = ifft(H);
j_opt = j0;
