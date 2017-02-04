classdef TradeInstrument 
    %TradeInstrument Trading instrument (Stock, Future, etc)
    % Encapsulates the properties of a particular underlying
    % Conststructor t=TradeInstrument(symbol, secType)
    properties
        % Interactive brokers IContract COM object
        contract
        
        % price data and date
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
            
            % Defaults are USD currency and SMART exchange
            obj.contract.currency ='USD';
            obj.contract.exchange = 'SMART';
        end
    end
    
end

