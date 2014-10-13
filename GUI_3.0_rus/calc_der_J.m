function [A, J_der_alpha, J_der_s2] = calc_der_J(f, alpha, s2, w)

L = length(f);
bell = exp(-s2*([0:L-1]'-alpha).^2);

A = sum(w.*f.*bell)/sum(w.*bell.^2);
e = f - A*bell;

J_der_alpha = -2*sum(w.*e.*bell*s2.*([0:L-1]'-alpha));
J_der_s2 =    sum(w.*e.*bell.*([0:L-1]'-alpha).^2);
