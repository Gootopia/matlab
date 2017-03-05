function ti = createTickLabels(ti)
% - Create tick labels for dates
%   ti = trade instrument with filled in data

n = length(ti.close);
% It's a pain to determine ahead of time how many we need. Build as we go.
xticklabels = strings(1,2);
xticks = zeros(1,2);

month = 0;
xtick_index = 1;

% Loop thru all dates and extract the start of each month
for xtick=1:n
    % Convert datenum format to datevec so we can easily get month/year.
    ds = datestr(ti.dates(xtick));
    dt = datetime(ds);
    dv = datevec(dt);
    
    % New label for each month
    if month ~= dv(2)
        year = dv(1);
        % Only show last 2 digits of the year
        if year >= 2000
            year = year - 2000;
        else
            year = year - 1900;
        end
        labelStr = sprintf('%02d/%02d/%02d',dv(2), dv(3), year);
        
        % Save the label and the index for charting purposes
        xticklabels(xtick_index) = labelStr;
        xticks(xtick_index) = xtick;
        month = dv(2);
        xtick_index = xtick_index+1;
    end

end
    ti.date_xticklabels = xticklabels;
    ti.date_xticks = xticks;
end

