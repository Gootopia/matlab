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
            obj.dEnd = floor(now);
            obj.dStart = obj.dEnd - 365;
            
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
            
            % Convert end date from 'mm/dd/yyyy' to double if not already
            if isa(obj.dEnd, 'char')
                obj.dEnd = datenum(obj.dEnd);
            end
            
            % determine where to pull historical data from (ib/yahoo)
            % Handle yahoo requests (daily only)
            if isa(obj.dataSource, 'yahoo')
                obj = yahooHistory(obj.dataSource, obj, obj.dStart, obj.period, obj.dEnd);
            % Handle IB requests (required for intraday)
            elseif isa(obj.dataSource, 'ibtws')
                obj = ibHistory(obj.dataSource, obj, obj.dStart, obj.period, obj.dEnd);
            end
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

