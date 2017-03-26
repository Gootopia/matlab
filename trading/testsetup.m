disp 'Creating Instruments (SPY, EFA)...';
% Dummy instrument for convenience
t_cash = TradeInstrument('CASH');

% Portfolio of trading instruments
t_spy = TradeInstrument('SPY');
t_efa = TradeInstrument('EFA');

disp 'Downloading Data: SPY...';
t_spy = getHistorical(t_spy, '1/1/1990');
disp 'Downloading Data: EFA...';
t_efa = getHistorical(t_efa, '1/1/1990');

disp 'Truncating Data...';
bars_spy = length(t_spy.close);
bars_efa = length(t_efa.close);

l_shortest = min([bars_efa bars_spy]);

t_spy = truncate(t_spy, l_shortest);
t_efa = truncate(t_efa, l_shortest);

% Cash has no "close", but we need a vector for the algorithm
t_cash.close = 0*t_spy.close;

% Compute rolling yearly (252 day) returns
r_efa = returns(t_efa, 'std', 252);
r_spy = returns(t_spy, 'std', 252);

% Compute absolute returns
rabs_efa = returns(t_efa, 'abs');
rabs_spy = returns(t_spy, 'abs');

%================ Start ===============

