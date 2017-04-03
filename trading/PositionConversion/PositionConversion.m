classdef PositionConversion
    %PositionConversion - Various conversion routines
    %   Detailed explanation goes here
    
    properties
    end
    
    methods(Static)
        % [cash_per_purchase,shares_purchased, err] = cashToEquity(cash_total, purchase_prices, cash_division)
        %   cash_total = total amount of cash allocated for purchase in 'N' transactions
        %   purchase_prices = vector of 'N' transaction prices
        %   cash_split = vector amount of cash allocated to individual 'N' transactions (10=10%, etc).
        % OUTPUTS:
        %   cash_per_purchase = vector of cash allocated to each transaction
        %   shares_purchased = vector of shares purchase in each transaction
        %   err = -1 (cash <=0), -2 (vector length inequality)
        function [cash_per_purchase, shares_purchased, err] = cashToEquity(cash_total, purchase_prices, cash_split)
            % Default return values
            cash_per_purchase=[];
            shares_purchased=[];

            % Cash must be > 0
            if cash_total <= 0
                err = -1;
                return;
            end

            % price and conversion vectors must be same length
            if length(purchase_prices) ~= length(cash_split)
                err = -2;
                return;
            end
            cash_per_purchase = cash_total*cash_split/100;
            shares_purchased=cash_per_purchase./purchase_prices;
        end
        
        % [profits,err] = equityToCash(shares, purchase_prices, sale_prices)
        %    shares = vector containg number of shares
        %    purchase_prices = vector containing purchase prices
        %    sale_prices = vector containing sale prices
        % OUTPUTS
        %    profits = vector of profit/loss for each transaction
        %    err = -1 (vector length inequality)
        function [profits, err] = equityToCash(shares, purchase_prices, sale_prices)
            err = 0;
            profits = 0;
            if length(shares) ~= length(sale_prices) || length(shares) ~= length(purchase_prices)
                err = -1;
                return;
            end
            profits = purchase_prices - sale_prices;
            profits = profits.*shares;
        end
    end
    
end

