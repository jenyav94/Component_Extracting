function [g, gf, J_min] = separate_optimal(h0, freq_init, kappa, Fsk)

L = length(h0);
h0f = fft(h0);
omega = freq_init/Fsk;

%N_400 = floor(400/Fsk*L);
N = L;
alpha = [0:N-1]/L;
M = length(omega);
ind0 = [];
coef = zeros(N,M);
for k=1:M,
    ind_equal = find(abs(alpha - omega(k))<=1e-8);
    if ~isempty(ind_equal),
        ind0 = [ind0, ind_equal];
        coef(ind_equal,1:M) = 0;
        coef(ind_equal,k) = 1;
    end
end

if ~isempty(ind0),
    ind0_sort = sort(ind0);
    ind1 = [1:ind0_sort(1)-1];
    for j=2:length(ind0_sort),
        ind1 = [ind1, ind0_sort(j-1)+1:ind0_sort(j)-1];
    end
    ind1 = [ind1, ind0_sort(end)+1 : N];
else
    ind1 = [1:N];
end
L_ind = length(ind1);
%
denom_inv = zeros(N,1);
denom_inv(ind1) = 1./sum((ones(L_ind,1)*(1./kappa)).*(alpha(ind1)'*ones(1,M) - ones(L_ind,1)*omega).^(-4),2);
for k=1:M,
    coef(ind1,k) = denom_inv(ind1)./(kappa(k)*(alpha(ind1)'-omega(k)).^4);
end
% Test: sum(coef,2) == ones(N,1).

for k=1:M,
    g(1:L,k) = ifft(coef(:,k).*h0f(1:N),L);
end
gf = fft(real(g));
J_min = sum(abs(h0f(1:N)).^2.*denom_inv);
