erlang-compression
==================

Implementation of data compression algorithms in Erlang.

API

rle.erl
=======

crle(String) -> String

Compresses the given character string with the RLE-Algorithm.

drle(String) -> String

Decompresses the given RLE-encoded character string.

