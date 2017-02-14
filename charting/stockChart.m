function stockChart(ti)
%stockChart(ti)
%  ti:  trade instrument

% Create figure
figure1 = figure;

% Create axes. Expand to fill more of screen
axes1 = axes('Parent',figure1,'Position',[0.03 0.05 0.95 0.9]);
hold(axes1,'on');

% Create plot
plot1 = plot(ti.close);
plot1.MarkerSize = 2;
plot1.MarkerEdgeColor = 'r';
plot1.Marker = 'o';

% lines on top/right edges
box(axes1,'on');
% Add grid lines
grid on
grid minor
