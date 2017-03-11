function ti = yahooHistory(c, ti, startdate, period, enddate)
% yahoo daily price data download.
%
%ibHistory(ti, startdate, enddate, period)
% ti = TradeInstrument
% startdate = starting date. Refer to Matlab IB documentation
% period[opt] = '1 day' (default), '1W', 'M'
% enddate[opt] = ending date. Default is 'floor(now)'
% Use: t_aapl = ibHistory(t_aapl, startdate, enddate)
%
% NOTE This is needed because Matlab is "pass-by-value" so results will be
% discarded if you do not do this.

% Default download period is '1 day'
if ~exist('period','var') || isempty(period)
  period = 'd';
end

% Assume today if we don't provide an enddate
if ~exist('enddate', 'var') || isempty(enddate)
    enddate = floor(now);
end

priceData = fetch(c, ti.ticker, startdate, enddate, period);

% yahoo data has most recent data first, so flip vectors
priceData = flip(priceData);

% Grab the data we want (exclude volume and such)
% Refer to Matlab IB docs for details
ti.dates = priceData(:,1);
ti.open = priceData(:,2);
ti.high = priceData(:,3);
ti.low= priceData(:,4);
ti.close = priceData(:,5);

% Create custom tick labels of the format 'MM/YY' for graphing purposes
ti = createTickLabels(ti);
end