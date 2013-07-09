-module(rle).
-compile(export_all).

% This file provides an implementation of the Run-Length-Encoding.
% To compress a character string you have to call crle(Value). The reuslt a RLE-encoded character string.
% To decompress a RLE-encoded character string you have to call drle(Value). The result is the original character string.

% Compress given Character String with Run-Length-Encoding.

crle([F,[]]) -> [{1,F}];
crle([F,S|LS]) -> string:join(lists:flatmap(fun({A,B}) -> io_lib:format("~w~c", [A,B]) end, crle_char([S|LS], F, 1)), "").

crle_char([], Character, Count) -> [{Count,Character}];
crle_char([L|LS], Character, Count) when Character /= L -> [{Count,Character}] ++ crle_char(LS, L, 1);
crle_char([L|LS], Character, Count) when Character == L -> crle_char(LS, Character, Count+1).

% Decompress given Character String with Run-Length-Encoding.

match(Value) -> 
	case re:run(Value, "[0-9]*[A-Za-z]*", [global]) of
        {match, Captured} -> Captured;
        nomatch -> ""
    end.

drle(Value) -> string:join(drle_pair(Value), "").

drle_pair(Value) ->
	case re:run(Value, "[0-9]*[A-Za-z]{1}") of
        {match, Captured} -> 
			{Start, Length} = hd(Captured),
		    {Count, _} = string:to_integer(string:sub_string(Value, Start + 1, Start + Length)),
		    Character = string:sub_string(Value, Length, Length),
			Newvalue = string:sub_string(Value, Length + 1),
		    drle_format(Count, Character) ++ drle_pair(Newvalue);
        nomatch -> []
    end.

drle_format(Count, Character) when Count == 0 -> [Character];
drle_format(Count, Character) when Count > 0 -> [Character] ++ drle_format(Count - 1, Character).
