classdef TradeInstrument 
    %TradeInstrument Trading instrument (Stock, Future, etc)
    % Encapsulates the properties of a particular underlying
    % Conststructor t=TradeInstrument(symbol, secType)
    properties
        % ticker symbol, security type
        ticker
        tickerType
        
        % Interactive brokers IContract COM object
        contract
        
        % Historical Connection Endpoint
        % Source = 'ib' or 'yahoo'
        dataSource
        
        % start and end dates for the data in the vectors below
        dStart
        dEnd
        
        % Type of data: '1 day' (default), '1W', 'M'
        period
        
        % Price data
        % All are vectors (1xN)
        dates
        date_xticklabels
        date_xticks
        open
        high
        low
        close
    end
    
    methods
        % Constructor(symbol, source, secType)
        % symbol = ticker name (i.e: 'AAPL')
        % source = ibtws or yahoo instance
        % [OPT]secType = 'STK' (default), 'FUT', etc (see IP API)
        function obj=TradeInstrument(symbol, secType, source)
            obj.ticker = symbol;
            
            % Default data source is 'yahoo'
            if ~exist('source', 'var') || isempty(source)
                source = yahoo;
            end
            obj.dataSource = source;
            
            % Default security type is 'STK'
            if ~exist('secType', 'var') || isempty(secType)
                secType = 'STK';
            end
            obj.tickerType = secType;
            
            % Set default time frame for data range as 1-year
            % 0 indicates always use most recent date as end
            obj.dEnd = 0;
            obj.dStart = '1/1/2017';
            
            % Default period is 1 day. Format is different for ib/yahoo.
            if isa(source, 'yahoo')
                obj.period = 'd';
            else
                obj.period = '1 day';
            end
        end
        
        % getHistorical(object, start, source)
        % object = this object
        % [OPT] = start date ('MM/DD/YYYY')
        % Downloads historical using the current data range and period
        % from the current source
        function obj = getHistorical(obj, start)
            % If starting date was provided, use that one
            if exist('start','var')
                obj.dStart = start;
            end
            
            % Convert startdate from 'mm/dd/yyyy' to double if not already
            if isa(obj.dStart, 'char')
                obj.dStart = datenum(obj.dStart);
            end
            
            % Always grab up to most recent data.
            obj.dEnd = floor(now);
            
            % determine where to pull historical data from (ib/yahoo)
            % Handle yahoo requests (daily only)
            if isa(obj.dataSource, 'yahoo')
                obj = yahooHistory(obj.dataSource, obj, obj.dStart, obj.period, obj.dEnd);
            % Handle IB requests (required for intraday)
            elseif isa(obj.dataSource, 'ibtws')
                obj = ibHistory(obj.dataSource, obj, obj.dStart, obj.period, obj.dEnd);
            end
            
            % Apply any known corrections (splits, errors, etc.)
            obj = adjustData(obj);
        end
        
        % Truncate data to most recent 'n' bars
        function obj = truncate(obj, n)
            bars = length(obj.close);
            n_start = bars-n+1;
            obj.open = obj.open(n_start: bars);
            obj.high = obj.high(n_start: bars);
            obj.low = obj.low(n_start:bars);
            obj.close = obj.close(n_start: bars);
            obj.dates = obj.dates(n_start: bars);
            % Update with new tick labels based on truncated data
            obj = createTickLabels(obj);
        end
        
        function obj = setYahoo(obj)
        end
        
        function obj = setIB(obj,ib)
            if isempty(obj.contract)
                obj.contract=ib.Handle.createContract;
                obj.contract.symbol = obj.ticker;
                % Defaults are USD currency and SMART exchange
                obj.contract.currency ='USD';
                obj.contract.exchange = 'SMART';   
            end
            obj.dataSource = ib;
        end
        
    end
    
end

