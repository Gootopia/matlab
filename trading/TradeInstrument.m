classdef TradeInstrument 
    %TradeInstrument Trading instrument (Stock, Future, etc)
    % Encapsulates the properties of a particular underlying
    % Conststructor t=TradeInstrument(symbol, secType)
    properties
        % Interactive brokers IContract COM object
        contract
        
        % start and end dates for the data in the vectors below
        dateStart
        dateEnd
        
        % Type of data: '1 day' (default), '1W', 'M'
        period
        
        % Price data
        % All are vectors (1xN)
        date
        open
        high
        low
        close
    end
    
    methods
        % Constructor(symbol, secType)
        % symbol = ticker name (i.e: 'AAPL')
        % secType = 'STK', 'FUT', etc (see IP API)
        function obj=TradeInstrument(symbol, secType)
            % Check if the connection exists. Create if needed.
            if ~exist('ib_tws', 'var')
                ibConnect;
            end
            
            % Create the ib contract for this security
            obj.contract=ib_tws.Handle.createContract;
            obj.contract.symbol = symbol;
            obj.contract.secType = secType;
            
            % Set default time frame for data range as 1-year
            obj.dateEnd = floor(now);
            obj.dateStart = obj.dateEnd - 365;
            
            % Default period is 1 day
            obj.period = '1 day';
            
            % Defaults are USD currency and SMART exchange
            obj.contract.currency ='USD';
            obj.contract.exchange = 'SMART';
        end
        
        % getData(object)
        % object = this object
        % Downloads historical using the current data range and period
        function obj = getHistoricalData(obj)
            obj = ibHistory(obj, obj.dateStart, obj.period, obj.dateEnd);
        end
    end
    
end

