function d = ibHistory(ib,ibContract,startdate,enddate,period)
%ibHistory() Interactive Brokers historical data download of date+OHLC.
% ib = TWS instance (ibtws)
% s = 
% Default download period is '1 day'
if ~exist('period','var') || isempty(period)
  period = '1 day';
end

% call IB toolbox function which gets a bunch of extra stuff
d_temp=history(ib,ibContract,startdate, enddate, 'TRADES', period);

% Only keep what we want (Date+OHLC)
d=d_temp(:,1:5);

end