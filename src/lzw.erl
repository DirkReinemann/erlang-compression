%% @author Dirk Reinemann
%% @description This file provides an implementation of the Lempel-Ziv-Welch compression algortihm.

-module(lzw).
-export([clzw/1]).

%% Encodes the given character string.

clzw(Value) -> clzw(Value, [], clzw_init(), 256).

clzw([], P, Dictionary, _) -> {_, Index} = clzw_find(Dictionary, P), [Index];
clzw([X|XS], P, Dictionary, Count) ->
	PX = [lists:append([P,X])],
	case clzw_find(Dictionary, PX) of
		{found, _} -> clzw(XS, PX, Dictionary, Count);
		none ->
			case clzw_find(Dictionary, P) of
				{found, Index} -> [Index] ++ clzw(XS, [X], [{Count,PX}|Dictionary], Count + 1)
			end
	end.

clzw_init() -> [ {X, [X]} || X <- lists:seq(0, 255) ].

clzw_find([], _) -> none;
clzw_find([X|XS], Value) ->
	case clzw_comp(element(2, X), Value) of
		true -> {found, element(1, X)};
		false -> clzw_find(XS, Value)
	end.

clzw_comp([], []) -> true;
clzw_comp([], _) -> false;
clzw_comp(_, []) -> false;
clzw_comp([X|_], [Y|_]) when X /= Y -> false;
clzw_comp([X|XS], [Y|YS]) when X == Y -> clzw_comp(XS, YS).