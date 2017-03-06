classdef cbChart
    %cbChart various static callbacks for charts
    %   More to come!
    
    properties
        barsToShift;
        ti;
    end
    
    methods
        function obj=cbChart()
            obj.barsToShift = 252;
        end
    end
    
    methods(Static)
        function shiftLeft(src, event)
            cb = src.UserData;
            ti = cb.ti;
            
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

