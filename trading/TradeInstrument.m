classdef TradeInstrument 
    %TradeInstrument Trading instrument (Stock, Future, etc)
    % Encapsulates the properties of a particular underlying
    % Conststructor t=TradeInstrument(symbol, secType)
    properties
        % Interactive brokers IContract COM object
        contract
        
        % start and end dates for the data in the vectors below
        dStart
        dEnd
        
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
        % [Opt]secType = 'STK' (default), 'FUT', etc (see IP API)
        function obj=TradeInstrument(symbol, secType)
            % Check if the connection exists. Create if needed.
            ibConnect
            
            % Create the ib contract for this security
            obj.contract=ib_tws.Handle.createContract;
            obj.contract.symbol = symbol;
            
            % Default security type is 'STK'
            if ~exist('secType', 'var') || isempty(secType)
                secType = 'STK';
            end
            obj.contract.secType = secType;
            
            % Set default time frame for data range as 1-year
            obj.dEnd = floor(now);
            obj.dStart = obj.dEnd - 365;
            
            % Default period is 1 day
            obj.period = '1 day';
            
            % Defaults are USD currency and SMART exchange
            obj.contract.currency ='USD';
            obj.contract.exchange = 'SMART';
        end
        
        % getHistorical(object)
        % object = this object
        % Downloads historical using the current data range and period
        function obj = getHistorical(obj, ib_tws)
            % Convert startdate from 'mm/dd/yyyy' to double if not already
            if isa(obj.dStart, 'char')
                obj.dStart = datenum(obj.dStart);
            end
            % Convert end date from 'mm/dd/yyyy' to double if not already
            if isa(obj.dEnd, 'char')
                obj.dEnd = datenum(obj.dEnd);
            end
            
            obj = ibHistory(ib_tws, obj, obj.dStart, obj.period, obj.dEnd);
        end
    end
    
end

