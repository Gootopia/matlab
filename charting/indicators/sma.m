function [output] = sma(price, period )
%SMA(Price, length)
% Compute simple moving average of a price vector
% price = 1:N price vector
% length = SMA length

% Start with first element of the data
index = 1;
% Initial SMA period is 1 and we build from there
tPeriod = 1;
% total number of vector elements
n = length(price);

% Allocate vectors so we don't need to adjust length each iteration
% Max size of sum elements is the period of the SMA
sma_elements = zeros(1,period);
% Max size of the output data is the size of the input data
output = zeros(1,n);

% Compute SMA over all points in the data. Adjust length as necessary
% at the start so we track gracefully
for j = 1:n
    k = 1;
    % Build the sum vector from the current period
    for i=index:index+tPeriod - 1
        sma_elements(k) = price(i);
        k=k+1;
    end

    % SMA = sum / length
    output(j) = sum(sma_elements) / tPeriod;

    % Once we hit the desired SMA period, we use that length forever
    if tPeriod < period
        tPeriod=tPeriod+1;
    else
        % Don't start moving the data window until period exceeded
        index = index+1;
    end
end


