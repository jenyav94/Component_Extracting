function [J_part, J_der, j0, n0] = calc_fun_uncert(H)

[L, M] = size(H);
h = ifft(H);
lin_h = [0:L-1]';
lin_H = [0:L/2-1, -L/2:-1]';

j0 = sum((lin_h*ones(1,M)).*abs(h).^2)./sum(abs(h).^2);
n0 = sum((lin_H*ones(1,M)).*abs(H).^2)./sum(abs(H).^2);

mh0 = sum(((lin_h*ones(1,M)) - ones(L,1)*j0).^2.*abs(h).^2);
MH0 = sum(((lin_H*ones(1,M)) - ones(L,1)*n0).^2.*abs(H).^2);

J2 = 2*pi/L*mh0.*MH0 - 1/(8*pi)*sum(abs(H).^2,1).^2;

h2 = fft((lin_h*ones(1,M)-ones(L,1)*j0).^2.*h) / L;
J2_der = 4*pi/L*((lin_h*ones(1,M)-ones(L,1)*n0).^2.*H.*(ones(L,1)*mh0) ...
    +(ones(L,1)*MH0).*h2)-1/(2*pi)*H.*(ones(L,1)*sum(abs(H).^2,1));

J_part = zeros(1,M);
J_der = zeros(L,M);

k0 = find(J2 > 0);

J_part(k0) = sqrt(J2(k0));
J_der(:,k0) = J2_der(:,k0)./(2*ones(L,1)*J_part(k0));

% if (length(k0)<M),
%     disp('Fun_uncertainty < 0!');
% end
