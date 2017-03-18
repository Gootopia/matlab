function r = returns( ti, period, type )
%logReturn = natural log of closing price returns
%   r = log return
%   ti = trading instrument
%   period = lookback period
%   offset = index of price period

% Default period is daily
if ~exist('period', 'var') || isempty(period)
    period = 1;
end

if ~exist('type', 'var') || isempty(type)
    type='normal';
end

bars = length(ti.close);
r = zeros(1,bars);

% Starting point depends on using absolute or a lookback period
if strcmp(type,'abs')
    n_start = 1;
else
    n_start = period+1;
end

% Compute returns
for n=n_start:bars
    p_0 = ti.close(n);

    if strcmp(type, 'abs') ~= 1
        p_lookback = ti.close(n-period);
    end
    
    % lookback returns: logarithmic
    if strcmp(type,'log')
        r(n) = log(p_0 / p_lookback);
    % absolute return over beginning of data
    elseif strcmp(type,'abs')
        r(n) = p_0 / ti.close(1);
    %lookback returns: ratio
    else
        r(n) = (p_0 - p_lookback) / p_lookback;
    end
end

% get rid of the initial bars which were before lookback period.
r = r(n_start:bars);

end

