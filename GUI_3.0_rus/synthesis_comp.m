function [t, s, s_gauss, s_hat] = synthesis_comp(g0,fc,pos )

Fs = 3e6;
Fsk = Fs/1e3;

L = size(g0,1);
t = [0 : L-1]/Fsk*1e3;

g0re = real(g0);
s = sum(g0re,2);

g0ref = fft(g0re);
sf = sum(g0ref,2);

clear g_hat s_hat
for i_comp = 1:3,
    env = g0(:,i_comp).*exp(-2i*pi*fc(i_comp)/Fsk*[0:L-1]');
    %
    [A, phi, a, sigma] = calc_gauss(env);
    g_hat(:,i_comp) = exp(1i*phi)*A*exp(-([0:L-1]'-a).^2/sigma^2);
    %
    s_hat(:,i_comp) = g_hat(:,i_comp).*exp(2i*pi*fc(i_comp)/Fsk*[0:L-1]');
end
s_gauss = real(sum(s_hat,2));


end

