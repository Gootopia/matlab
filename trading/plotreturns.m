% Plot rolling 252 day returns
figure
plot(rabs_efa);
hold
plot(rabs_spy);

% Show Dates along x-axis
xticks(t_spy.date_xticks);
xticklabels(cellstr(t_spy.date_xticklabels));
xtickangle(45);
grid on
grid minor

% Plot absolute returns
figure
plot(r_efa);
hold
plot(r_spy);
% Show Dates along x-axis
xticks(t_spy.date_xticks);
xticklabels(cellstr(t_spy.date_xticklabels));
xtickangle(45);
grid on
grid minor