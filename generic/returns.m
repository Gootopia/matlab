function r = returns( ti, type, period)
%returns = compute returns of desired type/period
%   r = return. Length is shorter than ti data due to lookback.
%   ti = trading instrument
%   type = 'abs' (absolute), 'log' (lognormal), 'normal' (default ratio)
%   period = lookback length

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
    n_start = period;
end

% Must always add 1 to get past the lookback period
n_start = n_start+1;

% Compute returns
for n=n_start:bars
    % Must use previous bar to avoid "look-ahead" syndrome
    p_0 = ti.close(n-1);
    d_0 = datestr(ti.dates(n-1));
    
    % Get value at start of period
    if ~strcmp(type, 'abs')
        p_lookback = ti.close(n-period);
        d_lookback = datestr(ti.dates(n-period));
    end
    
    % logarithmic
    if strcmp(type,'log')
        r(n) = log(p_0 / p_lookback);
    % absolute return since beginning of data
    elseif strcmp(type,'abs')
        r(n) = p_0 / ti.close(1);
    % Ratio return
    else
        r_period = (p_0 - p_lookback) / p_lookback;
        r(n) = r_period;
    end
    
    % Display return for debugging purposes
    %disp(sprintf('%s: P0=%f, PLB=%f, R=%f',d_0,p_0,p_lookback,r(n)));
end

% get rid of the initial bars which were before lookback period.
r = r(n_start:bars);

end

