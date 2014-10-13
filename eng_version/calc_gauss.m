function [A, phi, a, sigma] = calc_gauss(h)

% h - the complex envelope;

%1. Define the complex argument

h_abs = abs(h);
[h_max, i_max] = max(h_abs);

ip = find(h_abs(i_max+1:end) < 0.1*h_max, 1);

if isempty(ip), ip = length(h) - i_max; end

h0 = h(1 : i_max+ip);
phi = angle(sum(h0));

g = real(h0*exp(-1i*phi));
L = i_max + ip;

%w = ones(L,1);
w = [L:-1:1]'.^2;
w = w/sum(w)*L;

gm = sum(g.*[0:L-1]')/sum(g);
s2 = 1/(sum(g.*([0:L-1]'-gm).^2)/sum(g));

[A, J_der_gm, J_der_s2] = calc_der_J(g, gm, s2, w);
e = g - A*exp(-s2*([0:L-1]'-gm).^2);
fun_min = sum(w.*e.^2);
step0 = 1e-6;
step = step0;
while (step > 1e-8),
    gm_new = gm - step*J_der_gm;
    s2_new = s2 - step*J_der_s2;
    if (s2_new*gm_new^2 < log(10)), s2_new = log(10)/gm_new^2; end
    e_new = g - A*exp(-s2_new*([0:L-1]'-gm_new).^2);
    fun = sum(w.*e_new.^2);
    if (fun_min > fun*1.0001),
        %disp([fun, fun_min]);
        %figure(1);
        %plot([e, e_new]);
        fun_min = fun;
        gm = gm_new;
        s2 = s2_new;
        e = e_new;
        step = step0;
        [A, J_der_gm, J_der_s2] = calc_der_J(g, gm, s2, w);
    else
        step = step/2;
    end
end

a = gm;
sigma = 1/sqrt(s2);


