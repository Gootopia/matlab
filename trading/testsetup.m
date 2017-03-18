disp 'Creating Instruments (SPY, EFA)...';
t_spy = TradeInstrument('SPY');
t_efa = TradeInstrument('EFA');

disp 'Downloading Data: SPY...';
t_spy = getHistorical(t_spy, '1/1/1990');
disp 'Downloading Data: EFA...';
t_efa = getHistorical(t_efa, '1/1/1990');

disp 'Truncating Data...';
bars_spy = length(t_spy.close);
bars_agg = length(t_agg.close);

l_shortest = min([bars_efa bars_spyg]);

t_spy = truncate(t_spy, l_shortest);
t_efa = truncate(t_efa, l_shortest);

% Compute rolling yearly (252 day) returns
r_efa = returns(t_efa, 252, 'std');
r_spy = returns(t_spy, 252, 'std');

% Compute absolute returns
rabs_efa = returns(t_efa, 252, 'abs');
rabs_spy = returns(t_spy, 252, 'abs');

figure
plot(rabs_efa);
hold
plot(rabs_spy);

figure
plot(r_efa);
hold
plot(r_spy);
disp 'Setup Done.';
