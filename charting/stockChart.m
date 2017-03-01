function stockChart(ti,type)
%stockChart(ti)
% ti:  trade instrument
% type: 'line' (default), 'ha' (HeikenAshi)
SMAS = 43;
SMAL = 252;

% Default close is just our regular price
close = ti.close;

% Default security type is 'STK'
if ~exist('type', 'var') || isempty(type)
    type = 'line';
end
            
% Create figure
figure1 = figure;

% Create axes. Expand to fill more of screen
axes1 = axes('Parent',figure1,'Position',[0.03 0.05 0.95 0.9]);
% lines on top/right edges
box(axes1,'on');
hold(axes1,'on');

% Create items needed for HeikenAshi
if strcmp(type,'ha') == 1
    [ho,hh,hl,hc] = heikenAshi(ti);
    candlestick(ho', hh', hl', hc');
else
    % Create standard line plot
    plot_price = plot(ti.close);
    plot_price.MarkerSize = 2;
    plot_price.MarkerEdgeColor = 'r';
    plot_price.Marker = 'o';
    plot_price.LineWidth = 1.5;
end

%===== ADD INDICATORS TO DRAWINGS =====
% Create SMA based on our selected closing price type
data_smas = sma(close, SMAS);
data_smal = sma(close, SMAL);
plot_smas = plot(data_smas);
plot_smas.Color = [0 0.8 0];
plot_smal = plot(data_smal);
plot_smal.Color = [0.8 0 0];

% Put 
% Add grid lines
grid on
grid minor
