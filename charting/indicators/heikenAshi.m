function [ ho,hh,hl,hc ] = heikenAshi(ti)
% heikenAshi() Create heiken ashi values from a trading instrument
%   ti = Trading Instrument
%   ho,hh,hl,hc = heikenAshi vectors for open/high/low/close

n = length(ti.close);
ho = zeros(1,n);
hh = zeros(1,n);
hl = zeros(1,n);
hc = zeros(1,n);

% Compute Heiken Ashi bars. Formulas from Wikipedia entry.
for n=1:size(ti.close)
    % HA close is average of the 4 bar values
    hc(n) = (ti.open(n) + ti.high(n) + ti.low(n) + ti.close(n))/4;
    % HA high is max of the bar OHC
    high = [ti.high(n) ti.open(n) ti.close(n)];
    hh(n) = max(high);
    % HA low is min of the bar OLC
    low = [ti.low(n) ti.open(n) ti.close(n)];
    hl(n) = min(low);
    % HA open is average of previous bar OC
    if n~=1
        ho(n) = (ho(n-1) + hc(n-1)) / 2;
    else
        % No previous bar here, so just use current
        ho(1) = ti.open(1);
    end
end

end

