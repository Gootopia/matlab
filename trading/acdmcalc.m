disp '===== ACDM =====';
disp 'Creating Instruments...';

% Portfolio of trading instruments
disp 'CREATING INSTRUMENTS...';

% Create Indicies. Could use enum, but this keeps it in the file
SPY=1;
IWM=2;
EFA=3;
LQD=4;
HYG=5;
REM=6;
VNQ=7;
GLD=8;
TLT=9;

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
r=cell(9,1);
p(SPY) = {t_spy};
p(IWM) = {t_iwm};
p(EFA) = {t_efa};
p(LQD) = {t_lqd};
p(HYG) = {t_hyg};
p(REM) = {t_rem};
p(VNQ) = {t_vnq};
p(GLD) = {t_gld};
p(TLT) = {t_tlt};
disp 'DOWNLOADING DATA...';
startdate = '1/1/2008';

tickers=size(p);
for n=1:tickers(1)
    sym = p{n};
    disp(sprintf('%s',sym.ticker));
    sym = getHistorical(sym, startdate);
    r(n) = {returns(sym, 'std', 252)};
    p(n)= {sym};
end

% Compute rolling yearly (252 day) returns
%r_efa = returns(t_efa, 'std', 252);
%r_spy = returns(t_spy, 'std', 252);
