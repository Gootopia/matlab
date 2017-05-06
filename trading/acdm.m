disp '===== ACDM =====';
disp 'Creating Instruments...';

% Portfolio of trading instruments
disp 'CREATING INSTRUMENTS...';
t_spy = TradeInstrument('SPY');
t_iwm = TradeInstrument('IWM');
t_efa = TradeInstrument('EFA');

disp 'Creating Credit...';
t_lqd = TradeInstrument('LQD');
t_hyg = TradeInstrument('HYG');

disp 'Creating Real Estate...';
t_rem = TradeInstrument('REM');
t_vnq = TradeInstrument('VNQ');

disp 'Creating Fear...';
t_gld = TradeInstrument('GLD');
t_tlt = TradeInstrument('TLT');

p=cell(9,1);
p(1) = {t_spy};
p(2) = {t_iwm};
p(3) = {t_efa};
p(4) = {t_lqd};
p(5) = {t_hyg};
p(6) = {t_rem};
p(7) = {t_vnq};
p(8) = {t_gld};
p(9) = {t_tlt};
disp 'DOWNLOADING DATA...';
startdate = '1/1/2008';

tickers=size(p);
for n=1:tickers(1)
    sym = p{n};
    disp(sprintf('%s',sym.ticker));
    sym = getHistorical(sym, startdate);
    p(n)= {sym};
end

% Compute rolling yearly (252 day) returns
%r_efa = returns(t_efa, 'std', 252);
%r_spy = returns(t_spy, 'std', 252);
