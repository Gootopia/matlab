classdef cbChart
    %cbChart various static callbacks for charts
    
    properties
        shiftBars;
        ti;
    end
    
    methods
        function obj=cbChart()
            obj.shiftBars = 252;
        end
    end
    
    methods(Static)
        % Custom Data Cursor callback
        function txt = dataCursor(~,event_obj, ti)
            pos = event_obj.Position;
            bar = floor(pos(1));
            bar_date = ti.dates(bar);
            %Build output string for display
            txt = sprintf('%s\nO=%.1f\nH=%.1f\nL=%.1f\nC=%.1f',...
                datestr(bar_date),... 
                ti.open(bar),...
                ti.high(bar),... 
                ti.low(bar),... 
                ti.close(bar));
        end
        
        function shiftLeft(src, event)
            cb = src.UserData;
            ti = cb.ti;
            
            % Shift existing window by desired amount
            % This maintains the current width set by xlim.
            xl = xlim;
            x_width = xl(2) - xl(1);
            left = xl(1) - cb.shiftBars;
            if left < 1
                left = 1;
            end
            right = left + x_width;
            
            % clip window to contain period high/low
            clipChart(ti, left, right);
        end
        
        function shiftRight(src, event)
            cb = src.UserData;
            ti = cb.ti;
            lmax = length(ti.open);
        
            % Shift existing datawindow by desired amount.
            % This maintains the current width set by xlim.
            xl = xlim;
            x_width = xl(2) - xl(1);
            right = xl(2) + cb.shiftBars;
            if right > lmax
                right = lmax;
            end
            
            left = right - x_width;

            % clip window to contain period high/low
            clipChart(ti, left, right);

        end
    end
    
end

