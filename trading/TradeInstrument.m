classdef TradeInstrument 
    %TradeInstrument Trading instrument (Stock, Future, etc)
    % Encapsulates the properties of a particular underlying
    % Conststructor t=TradeInstrument(tws, symbol, secType)
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
        % Constructor
        % tws = instance of TWS (returned from ibtws)
        % symbol = ticker name (i.e: 'AAPL')
        % secType = 'STK', 'FUT', etc (see IP API)
        function obj=TradeInstrument(tws, symbol, secType)
            obj.contract=tws.Handle.createContract;
            obj.contract.symbol = symbol;
            obj.contract.secType = secType;
            % Defaults are USD currency and SMART exchange
            obj.contract.currency ='USD';
            obj.contract.exchange = 'SMART';
        end
    end
    
end

