function [edge_left, edge_right] = find_correct(H)

[L,M] = size(H);
A = max(max(abs(H)));

% The central frequency number, starting from 0, for any component.
n0 = sum(([0:L-1]'*ones(1,M)).*abs(H))./sum(abs(H));

% First and second derivatives, for any component.
dH = [zeros(1,M); (abs(H(3:L,:)) - abs(H(1:L-2,:)))/2; zeros(1,M)];
d2H = [zeros(1,M); (abs(H(1:L-2,:)) + abs(H(3:L,:)))/2 - abs(H(2:L-1,:)); zeros(1,M)];

% Loop in component pairs.
for k=1:M-1,
    ind = [ceil(n0(k)):floor(n0(k+1))]+1;   % the maximal interval.
    ind_left = find(abs(H(ind,k)) >= abs(H(ind,k+1))/0.8);
    if isempty(ind_left),
        edge_left(k) = ceil(n0(k))+1;
    else
        edge_left(k) = max(ind_left)+ind(1)-1;
    end
    ind_d2left = find((d2H(ind,k) > 0.25*abs(H(ind,k))) & (abs(H(ind,k)) > 0.1*A) & (-dH(ind,k)<0.5*abs(H(ind,k))));
    if ~isempty(ind_d2left),
        edge_left(k) = min([edge_left(k), min(ind(ind_d2left))]);
    end
    %
    ind_right = find(abs(H(ind,k)) <= abs(H(ind,k+1))*0.8);
    if isempty(ind_right),
        edge_right(k) = floor(n0(k+1))+1;
    else
        edge_right(k) = min(ind_right)+ind(1)-1;
    end
    ind_d2right = find((d2H(ind,k+1) > 0.25*abs(H(ind,k+1))) & (abs(H(ind,k+1)) > 0.1*A) & (dH(ind-1,k)<0.5*abs(H(ind,k))));
    if ~isempty(ind_d2right),
        edge_right(k) = max([edge_right(k), max(ind(ind_d2right))]);
    end
end
