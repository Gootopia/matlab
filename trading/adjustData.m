function ti = adjustData(ti, source)
%adjustData - Make any known corrections to historical data
%   ti = trade instrument
%   [OPT] source = data provider ('ib', 'yahoo');

switch(ti.ticker)
    case 'EFA'
        % 3:1 stock split 6/9/2005
        n=1;
        splitdate = datenum('6/9/2005');
        while (ti.dates(n) < splitdate)
            ti.close(n) = ti.close(n)/3;
            n = n+1;
        end
end

end

