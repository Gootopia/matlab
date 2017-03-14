function clipChart( ti, rangeStart, rangeEnd )
%CLIPCHART rescale the chart for max/min over the given range
%   ti = trade instrument
%   start = start of data range
%   end = end of data range
h=ti.high;
l=ti.low;

% Enforce lower bound
if rangeStart < 1
    rangeStart = 1;
end

% Enforce upper bound
vlen = length(h);
if rangeEnd > vlen
    rangeEnd = vlen;
end

% Round to integers (needed if the magnify tool was used).
rangeStart = floor(rangeStart);
rangeEnd = ceil(rangeEnd);

% Make sure we show the full bar on each end.
xlim([rangeStart-0.5 rangeEnd+0.5]);

% Scale to contain y values.
ymax = max(h(rangeStart:rangeEnd));
ymin = min(l(rangeStart:rangeEnd));
ylim([ymin ymax]);
end

