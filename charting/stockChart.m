function stockChart(ti,type,showclose)
%stockChart(ti)
% ti:  trade instrument
% type: 'line' (default), 'ha' (HeikenAshi)
SMAS = 43;
SMAL = 252;
% number of price bars to show
SHOWBARS = 250;

% Default close is just our regular price.
close = ti.close;
% number of price bars in the data
nbars = length(close);

% Default drawing price is our line
if ~exist('type', 'var') || isempty(type)
    type = 'line';
end

% Default is not to show a line plot with the closing prices.
if ~exist('showclose', 'var') || isempty(type)
    showclose = 'no';
end
   
%===== SET UP THE GRAPHICS =====
figure1 = figure;

% Create axes. Expand to fill more of screen
axes1 = axes('Parent',figure1,'Position',[0.03 0.05 0.95 0.9]);
% lines on top/right edges
box(axes1,'on');

% Add grid lines
grid on
grid minor

% If data is too large to reasonably fit on the screen, set the xlimits to
% only show the most recent data. +1 so last point isn't truncated.
if nbars > SHOWBARS
    x_max = nbars+1;
    x_min = nbars-SHOWBARS;
    xlim([x_min x_max]);
end

% 
hold(axes1,'on');

%===== CREATE THE CHART =====
% Create items needed for HeikenAshi
switch(type)
    % Standard line drawing
    case 'line'
        plot(close);
        
    % Heiken Ashi candlesticks
    case 'ha'
        [ho,hh,hl,hc] = heikenAshi(ti);
        candlestick(ho', hh', hl', hc');
end

% Show a plot with the actual closing prices.
if strcmp(showclose, 'showclose') 
    % Create standard line plot
    markers_close = plot(ti.close, 'o');
    markers_close.MarkerSize = 2;
    markers_close.MarkerEdgeColor = [0 0 0.8];
    %plot_price.MarkerEdgeColor = 'r';
    %plot_price.LineWidth = 1.5;
end

%===== ADD INDICATORS TO DRAWINGS =====
% Create SMA based on our selected closing price type
data_smas = sma(close, SMAS);
data_smal = sma(close, SMAL);
plot_smas = plot(data_smas);
plot_smas.Color = [0 0.8 0];
plot_smal = plot(data_smal);
plot_smal.Color = [0.8 0 0];

hold off
