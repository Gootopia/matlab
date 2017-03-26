classdef UnitTest
    properties
    end
    
    methods
        function obj=UnitTest()
        end
    end
    
    methods(Static)
        % Standard a=b comparison. Asserts if a != b.
        function ASSERT_EQUAL(a,b,msg)
            ln=UnitTest.GET_LN();
            if ~exist('msg', 'var')
                msg = 'EQUAL Failed';
            end
            msg=sprintf('%d: %s', ln, msg);
            assert(isequal(a,b),msg);
        end
        
        % Determines line number of caller function
        function ln=GET_LN()
            s=dbstack;
            % Needs to be 3 as we are 2 levels removed from caller
            ln=s(3).line;
        end
    end
end
