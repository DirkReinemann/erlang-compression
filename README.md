erlang-compression
==================

Implementation of data compression algorithms in Erlang.

API
---

### rle.erl

1. crle(String) -> String 

	> Compresses the given character string with the RLE-Algorithm.

2. drle(String) -> String

	> Decompresses the given RLE-encoded character string.

