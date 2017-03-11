% -----------------------------------------------------------
% function candlestick(O,H,L,C)
function candlestick(O,H,L,C)

colorDown = [1.0 0 0]; 
colorUp = [0 0.8 0]; 
colorLine = 'k';

date = (1:length(O))';

% w = Width of body, change multiplier to draw body thicker or thinner
% the 'min' ensures no errors on weekends ('time gap Fri. Mon.' > wanted
% spacing)
w=.3*min([(date(2)-date(1)) (date(3)-date(2))]);

l=length(O);

xl = xlim;
dleft = xl(1);
dright = xl(2);

if dleft < 1
    dleft = 1;
end

if dright > l
    dright = l;
end
dleft = 1;
dright = l;

%%%%%%%%draw line from Low to High%%%%%%%%%%%%%%%%%
for i=dleft:dright
   line([date(i) date(i)],[L(i) H(i)],'Color',colorLine);
   x=[date(i)-w date(i)-w date(i)+w date(i)+w date(i)-w];
   y=[O(i) C(i) C(i) O(i) O(i)];
   if O(i) > C(i)
        fill(x,y,colorDown);
   else
       fill(x,y,colorUp);
   end
end