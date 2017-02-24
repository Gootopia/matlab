function stockChart(ti)
%stockChart(ti)
%  ti:  trade instrument

SMAS = 43;
SMAL = 252;

% Create figure
figure1 = figure;

% Create axes. Expand to fill more of screen
axes1 = axes('Parent',figure1,'Position',[0.03 0.05 0.95 0.9]);
hold(axes1,'on');

% Create plot of closing price data
plot_price = plot(ti.close);
plot_price.MarkerSize = 2;
plot_price.MarkerEdgeColor = 'r';
plot_price.Marker = 'o';
plot_price.LineWidth = 1.5;

% Create SMA
data_smas = sma(ti.close, SMAS);
data_smal = sma(ti.close, SMAL);

plot_smas = plot(data_smas);
plot_smas.Color = [0 0.8 0];
plot_smal = plot(data_smal);
plot_smal.Color = [0.8 0 0];

% lines on top/right edges
box(axes1,'on');
% Add grid lines
grid on
grid minor
