function clipChart( ti, rangeStart, rangeEnd )
%CLIPCHART rescale the chart for max/min over the given range
%   ti = trade instrument
%   start = start of data range
%   end = end of data range
h=ti.high;
l=ti.low;

xlim([rangeStart rangeEnd]);
ymax = max(h(rangeStart:rangeEnd));
ymin = min(l(rangeStart:rangeEnd));
ylim([ymin ymax]);
end

