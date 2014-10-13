function [imps imphilb ind_beg max_imp min_imp] = findImp(threshold,channel,filename,filt)
%filename = '../Зося/Дальность_130/136-11.wav';

max_imp=0;
min_imp=0;
ind_beg=[];

init_sample =0; % 3.7e6; %0;
delta_sample = 4e6;
L=600;

imps = []; imphilb=[];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~, Fs] = wavread(filename,20);
size_s = wavread(filename,'size');
len_signal = size_s(1);
N_channels = size_s(2);
last_sample = min([100e6, len_signal]);
%
if (len_signal <= init_sample+delta_sample),
    delta_sample = len_signal - init_sample;
    last_sample = len_signal;
end

% Main parameters
Fsk = Fs/1000;
%N_200 = ceil(L/Fsk*400);
%N_200 = ceil(L/Fsk*300);
%
% Synchronization
Lh = 50;
wh = hanning(2*Lh+1);
wh = wh/sum(wh);
threshold_low = 0.2*threshold;
Shift = 3000;
impCounter = 0; % counter of impulses 

%
B_high = fir1(1000,0.01,'high');
A_high = 1;
%
% Loop over big parts of signal
N_frames = 0;
clear ind_beg s_all power freq_center g_all s_ext_all
seg_beg = 0;
seg_end = init_sample;
ind_beg=[];

while (seg_end < last_sample),
    seg_beg = seg_end;
    seg_end = min([seg_beg + delta_sample, last_sample]);
    % Read the part of the signal
    [s,Fs] = wavread(filename,[seg_beg+1,seg_end]);
    % Extract the channel
    if (N_channels > 1),
        s = s(:,channel);
    end
    
    if(filt==true)
    % Filtering. Cut frequency = 200 kHz.
    s = filtfilt(B_high,A_high,s);
    %
    end
    % Hilbert transform and envelope of the signal.
    h = hilbert(s);
    abs_h = abs(h);
    %
    num=[0.92727435, -1.8544941, 0.92727435];
    den=[1, -1.9059465, 0.9114024];
    h_low = filter(num,den,h);
    abs_h_low = abs(h_low);
    %
    % Loop over impulses.
    ind_old = 1000; %1e6; %1000;
    ind = find(abs_h(ind_old+1:end)>threshold, 1);
while (~isempty(ind) && (ind_old+ind+L <= length(s))),
    % Synchronization
    ind_init = ind_old+ind;
    h_max = max(abs_h_low(ind_init+[1:100]));
    hw = conv(wh,abs_h_low(ind_init+[0:-1:-500]));
    ind_back = find(hw(2*Lh+1:end-Lh)<max([threshold_low,h_max*0.1]),1);
    if isempty(ind_back),
        ind_old = ind_old+ind+Shift;
        ind = find(abs_h(ind_old+1:end)>threshold, 1);
        continue;
    end
    N_frames = N_frames + 1;
    ind0 = ind_init - (ind_back-1+Lh);
    % 
    
    s0 = s(ind0+[-300:900]);
    h0 = h(ind0+[-300:900]);
    %plot(s0);
    
    imps(1:1201, N_frames) = s0;
    imphilb(1:1201, N_frames) = h0;
    impCounter = impCounter+1;
    
    if(max_imp<max(s0))
        max_imp=max(s0);
    end
    
    if(min_imp>min(s0))
        min_imp=min(s0);
    end
    
    
    ind_old = ind_old+ind+Shift;
    ind = find(abs_h(ind_old+1:end)>threshold, 1);
    
    ind_beg(N_frames) = ind0 + seg_beg;
end
end

end

