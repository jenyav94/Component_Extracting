function [g0, fc, pos] = extractComp(s0,h0,lb,rb,freq_border )

c1 = 0; c2 = 0; c3 = 0;
Fs=3000000;
L=rb-lb+1;

%%%%%%% Calculate the central frequency and the band width.
freq_ext = [0, freq_border, max(freq_border)+100];
freq_fix = (freq_ext(2:end) + freq_ext(1:end-1))/2;
kappa = (freq_ext(2:end) - freq_ext(1:end-1)).^(-4);    
%kappa = ones(size(freq_fix));
N_comp = length(freq_fix);

% Main parameters
Fsk = Fs/1000;
%N_200 = ceil(L/Fsk*400);
N_200 = ceil(L/Fsk*300);
%

s1=s0(lb:rb);
s0=[];
s0=s1;

h1=h0(lb:rb);
h0=[];
h0=h1;

s0f = fft(s0);
    %
    scrsz = get(0,'ScreenSize');
    figure(1);
    plot([1:L]/Fs*1e6,s0);
    figure(3);
    plot([0:N_200]/L*Fsk,abs(s0f(1:N_200+1)),'.-');
    %
    
   

% The main procedure: component extraction by minimization uncertainty
    h_init = separate_optimal(h0, freq_fix, kappa, Fsk);
    [g0, fc, pos] = tune_component_uncert(h_init, Fsk);
    g0re = real(g0);
                    % Save components separately
                    c1 = g0re(:,1);
                    c2 = g0re(:,2);
                    c3 = g0re(:,3);
                    
    g0ref = fft(g0re);
    
    %
    figure(2);
    plot([1:L]/Fs*1e6,g0re);
    %
    figure(4);
    plot([0:N_200]/L*Fsk,abs(g0ref(1:N_200+1,:)),'.-');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

