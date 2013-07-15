%% @author Dirk Reinemann
%% @description This file contains test cases of the lzw.erl file.

-module(lzw_test).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").

clzw_test() -> 
	?assert([66,65,256,257,65,260] == lzw:clzw("BABAABAAA")).