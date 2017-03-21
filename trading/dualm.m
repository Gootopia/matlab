% starting equity
E = 100000;
position = 'flat';
base = t_spy;
period = 252;

% Determine historical annual returns
% Assumes trading instrument data already set up. See 'testsetup.m'
% NOTE: must truncate so that date lengths match!
r_spy = returns(t_spy, 'std', period);
r_efa = returns(t_efa, 'std', period);

% month tracker
sd = datetime(datestr(base.dates(1)));
curr_month = month(sd);

% Backtesting loop
for n=1:length(r_spy)
    % dates vector actually includes lookback period whereas returns
    % do not, so we must compensate
    n_date = n+period;
    
    % Current Day
    d=datetime(datestr(base.dates(n_date)));
    
    % Check trade at start of each month
    if month(d) ~= curr_month
        
        % Implement GEM dual momentum logic
        % First is absolute (equity > 0% return).
        % Then is relative (which equity has highest).
        % Otherwise go to cash/bond alternative
        ret_spy = r_spy(n);
        ret_efa = r_efa(n);
        if ret_spy > 0
            if ret_spy > ret_efa
                position = 'spy';
            else
                position = 'efa';
            end
        else
            position = 'cash';
        end
        
        disp(sprintf('%s: %s,spy=%f,efa=%f',d, position,r_spy(n), r_efa(n)));
        % Done for the month
        curr_month = month(d);
    end
end
