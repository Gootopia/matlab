% Script: ibConnect
% Connects to an open instance of ibTWS
% NOTES:
% 1) Need to enable activeX/Sockets in TWS Api dialog
% 2) Set 'allow connections from localhost only' to prevent having to
% manually accept the connection each time with the TWS dialog box.
% If you receive "unable to override" errors, you need to create a
% connection and then close it first.

% Check if a connection already exists using Matlab 'exist'
result = exist('ib_tws', 'var');

switch result
    % 1 => variable already exists, so we'll close that connection
    case 1
        close(ib_tws);
    otherwise
end

% Open a new connection on the local host over port 7496
% Verify TWS settings are correct
ib_tws = ibtws('',7496);

% obtain the next valid order Id number and display it.
% This also lets us know the connection is good.
%ib_nextId=orderid(ib_tws)