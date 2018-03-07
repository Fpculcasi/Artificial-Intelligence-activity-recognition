%% Data splitting - split.m
% - We need to split every signal to find out the least temporal interval
%   that is necessary and sufficient to recognize the position/activity.

% N.B. We are using a sampling period of ~82ms (12.2Hz).
% Number of samples based on the interval size:
% N1 = 12.2Hz * 3sec = 36.6;    %3sec
% N2 = 61;                      %5sec
% N3 = 122;                 	%10sec
% N4 = 144.4;               	%12sec
% N5 = 183;                     %15sec
% N6 = 244;             		%20sec
% N7 = 366;             		%30sec
% N8 = 732;             		%1min
% N9 = 1464;                    %2min
% N = 2196;                     %3min - NO SIGNAL HAS A 3min LONG TRACE
N = [37 61 122 145 183 244 366 732 1464];

% The index only need to use one choice among the upper showed.
index = 7;
clear A B C D;
A = Struct(1).supine(1:N(index), 2:5);
B = Struct(1).dorsiflexion(1:N(index), 2:5);
C = Struct(1).walking(1:N(index), 2:5);
D = Struct(1).stair(1:N(index), 2:5);

% If the piece of signal cannot fill entirely the number of samples
% needed, it wont be used:
% "length(Struct(i).<activity>)/N(j)" is used just for its integer part so
% to truncate incomplete pieces of signal.
for i=1:10
    for k=2:length(Struct(i).supine)/N(index)
        A = [A Struct(i).supine(1+N(index)*(k-1):k*N(index), 2:5)];
    end
    for k=2:length(Struct(i).dorsiflexion)/N(index)
        B = [B Struct(i).dorsiflexion(1+N(index)*(k-1):k*N(index), 2:5)];
    end
    for k=2:length(Struct(i).walking)/N(index)
        C = [C Struct(i).walking(1+N(index)*(k-1):k*N(index), 2:5)];
    end
    for k=2:length(Struct(i).stair)/N(index)
        D = [D Struct(i).stair(1+N(index)*(k-1):k*N(index), 2:5)];
    end
end
