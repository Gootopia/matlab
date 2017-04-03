% starting equity
cash = 100000;
position = t_cash;
curr_position = t_cash;
period = 126;

% Determine historical annual returns
% Assumes trading instrument data already set up. See 'testsetup.m'
% NOTE: must truncate so that date lengths match!
r_spy = returns(t_spy, 'std', period);
r_efa = returns(t_efa, 'std', period);

%  Conversion Vector. Values in percent.
cv_cash = [20 20 10 10 5 5 5 5 5 5 5 5];

% month tracker
sd = datetime(datestr(base.dates(1)));
curr_month = month(sd);

% Backtesting loop
for n=1:length(r_spy)
    % dates vector actually includes lookback period whereas returns do
    % not, so we must compensate
    n_date = n+period;
    
    % Current Day
    d=datetime(datestr(base.dates(n_date)));
    
    % Check trade at start of each month
    if month(d) ~= curr_month
        
        % Get period returns for previous day
        ret_spy = r_spy(n);
        ret_efa = r_efa(n);
        
        % Implement GEM dual momentum logic
        % First is absolute (equity > 0% return).
        % Then is relative (which equity has highest).
        % Otherwise go to cash/bond alternative
        position = t_cash;
        if ret_spy > 0
            if ret_spy > ret_efa
                position = t_spy;
            else
                position = t_efa;
            end
        end
        
        %disp(sprintf('%s: %s,spy=%f,efa=%f',d, position,r_spy(n), r_efa(n)));
        
        % Signal generated: Convert to new position
        if ~strcmp(position.ticker, curr_position.ticker)
            disp(sprintf('%s: %s->%s, equity=$%.2f',d,curr_position.ticker, position.ticker, equity));
            
            % Position conversion takes place over N days. N and cash
            % percentage allocated to each day are determined by the
            % 'conversion vector (CV)'. The CV can differ, depending on
            % cash->equity or equity->cash.
              
            if ~strcmp(position.ticker, 'CASH')
                % CASH->EQUITY. TRANSACTION PRICE = OPEN
                v_buy = position.open(n:n+length(cv_cash)-1)';
                [transactions, shares, err] = PositionConversion.cashToEquity(cash, v_buy, cv_cash)
            else

            end
           
        end
        % Done for the month
        curr_month = month(d);
        curr_position = position;
    end
end
