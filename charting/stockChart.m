function stockChart(ti,type,showclose)
%stockChart(ti)
% ti:  trade instrument
% type: 'line' (default), 'ha' (HeikenAshi)
SMAS = 43;
SMAL = 252;
% number of price bars to show
SHOWBARS = 500;

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
f = figure;
% Save the trade instrument so we can use it in the tooltip.
f.UserData = ti;

% Create axes. Expand to fill more of screen
axes1 = axes('Parent',f,'Position',[0.03 0.05 0.95 0.9]);
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

hold(axes1,'on');

%===== CHART CALLBACK STUFF =====
cb = cbChart();
cb.ti = ti;

%===== CREATE THE TOOLBAR =====
% Create all the toolbar stuff
tb = uitoolbar(f);

p_leftShift = uipushtool(tb);
img = imread('icons\LeftArrow.png');
p_leftShift.CData = img;
p_leftShift.UserData = cb;
p_leftShift.ClickedCallback = @cbChart.shiftLeft;
img = imread('icons\RightArrow.png');
p_rightShift = uipushtool(tb);
p_rightShift.CData = img;
p_rightShift.UserData = cb;
p_rightShift.ClickedCallback = @cbChart.shiftRight;

%===== CREATE DATACURSOR CALLBACK ====
h=datacursormode(f);
h.DisplayStyle = 'window';
% Callback also gets the ti so we can access the data.
h.UpdateFcn = {@cbChart.dataCursor, ti};

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
    
    % Standard candlestick chart
    case 'candle'
        candlestick(ti.open, ti.high, ti.low, ti.close);
end

% Show a plot with the actual closing prices.
if strcmp(showclose, 'showclose') 
    % Create standard line plot
    markers_close = plot(ti.close, 'o');
    markers_close.MarkerSize = 4;
    markers_close.MarkerEdgeColor = [0 0 0.8];
end

% Show Dates along x-axis
xticks(ti.date_xticks);
xticklabels(cellstr(ti.date_xticklabels));
xtickangle(45);

%===== ADD INDICATORS TO DRAWINGS =====
% Create SMA based on our selected closing price type
data_smas = sma(close, SMAS);
data_smal = sma(close, SMAL);
plot_smas = plot(data_smas);
plot_smas.Color = [0 0.8 0];
plot_smal = plot(data_smal);
plot_smal.Color = [0.8 0 0];

hold off
