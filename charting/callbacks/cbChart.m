classdef cbChart
    %cbChart various static callbacks for charts
    
    properties
        barsToShift;
        ti;
    end
    
    methods
        function obj=cbChart()
            % About 252 trading days in a year.
            obj.barsToShift = 252;
        end
    end
    
    methods(Static)
        % Custom Data Cursor callback
        function txt = dataCursor(~,event_obj, ti)
            pos = event_obj.Position;
            bar = floor(pos(1));
            bar_date = ti.dates(bar);
            txt = sprintf('%s\nO=%.1f\nH=%.1f\nL=%.1f\nC=%.1f',...
                datestr(bar_date),... 
                ti.open(bar),...
                ti.high(bar),... 
                ti.low(bar),... 
                ti.close(bar));
        end
        
        function shiftLeft(src, event)
            cb = src.UserData;
            
            xl = xlim;
            left = xl(1) - cb.barsToShift;
            if left < 1
                left = 1;
            end
            right = left + cb.barsToShift;
            xlim([left right]);
        end
        
        function shiftRight(src, event)
            cb = src.UserData;
            ti = cb.ti;
            lmax = length(ti.open);
        
            xl = xlim;
            right = xl(2) + cb.barsToShift;
            if right > lmax
                right = lmax;
            end
            
            left = right - cb.barsToShift;
            xlim([left right]);
        end
    end
    
end

