# Repo for reproduction of issue with `DBConnection.disconnect_all`

## Instructions

Run:

```
mix deps.get
mix ecto.create
iex -S mix
```

Then run:

```elixir
DisconnectAll.Test.go 4294
```

and examine the output.

Then run:

```elixir
DisconnectAll.Test.go 4295
```

and examine the output.

## Expected output

With `4294` as the interval parameter, we get the expected output, which is something like this:

```
iex(1)> DisconnectAll.Test.go 4294
[11:48:25.888] [info] Checking out all connections (iteration 1)...
[11:48:25.889] [info] Calling disconnect_all...
[11:48:25.891] [info] Checking out all connections (iteration 2)...
[11:48:25.905] [info] 1) #PID<0.448.0> checking out: 59614
[11:48:25.905] [info] 1) #PID<0.449.0> checking out: 59615
[11:48:26.406] [info] 1) #PID<0.449.0> checking back in: 59615
[11:48:26.406] [info] 1) #PID<0.448.0> checking back in: 59614
[11:48:26.412] [info] 2) #PID<0.450.0> checking out: 59614
[11:48:26.414] [info] Postgrex.Protocol (#PID<0.411.0>) disconnected: ** (DBConnection.ConnectionError) disconnect_all requested
[11:48:26.423] [info] 2) #PID<0.451.0> checking out: 59943
[11:48:26.892] [info] Checking out all connections (iteration 3)...
[11:48:26.913] [info] 2) #PID<0.450.0> checking back in: 59614
[11:48:26.913] [info] Postgrex.Protocol (#PID<0.412.0>) disconnected: ** (DBConnection.ConnectionError) disconnect_all requested
[11:48:26.921] [info] 3) #PID<0.452.0> checking out: 59947
[11:48:26.924] [info] 2) #PID<0.451.0> checking back in: 59943
[11:48:26.925] [info] 3) #PID<0.453.0> checking out: 59943
[11:48:27.422] [info] 3) #PID<0.452.0> checking back in: 59947
[11:48:27.426] [info] 3) #PID<0.453.0> checking back in: 59943
[11:48:27.893] [info] Checking out all connections (iteration 4)...
[11:48:27.895] [info] 4) #PID<0.454.0> checking out: 59947
[11:48:27.895] [info] 4) #PID<0.455.0> checking out: 59943
[11:48:28.395] [info] 4) #PID<0.454.0> checking back in: 59947
[11:48:28.396] [info] 4) #PID<0.455.0> checking back in: 59943
[11:48:28.894] [info] Checking out all connections (iteration 5)...
[11:48:28.895] [info] 5) #PID<0.457.0> checking out: 59943
[11:48:28.895] [info] 5) #PID<0.456.0> checking out: 59947
[11:48:29.396] [info] 5) #PID<0.457.0> checking back in: 59943
[11:48:29.396] [info] 5) #PID<0.456.0> checking back in: 59947
[11:48:29.895] [info] Checking out all connections (iteration 6)...
[11:48:29.898] [info] 6) #PID<0.459.0> checking out: 59947
[11:48:29.898] [info] 6) #PID<0.458.0> checking out: 59943
[11:48:30.399] [info] 6) #PID<0.458.0> checking back in: 59943
[11:48:30.399] [info] 6) #PID<0.459.0> checking back in: 59947
[11:48:30.896] [info] Checking out all connections (iteration 7)...
[11:48:30.897] [info] 7) #PID<0.461.0> checking out: 59947
[11:48:30.897] [info] 7) #PID<0.460.0> checking out: 59943
[11:48:31.398] [info] 7) #PID<0.460.0> checking back in: 59943
[11:48:31.398] [info] 7) #PID<0.461.0> checking back in: 59947
[11:48:31.897] [info] Checking out all connections (iteration 8)...
[11:48:31.899] [info] 8) #PID<0.462.0> checking out: 59943
[11:48:31.900] [info] 8) #PID<0.463.0> checking out: 59947
[11:48:32.400] [info] 8) #PID<0.462.0> checking back in: 59943
[11:48:32.401] [info] 8) #PID<0.463.0> checking back in: 59947
[11:48:32.898] [info] Checking out all connections (iteration 9)...
[11:48:32.904] [info] 9) #PID<0.465.0> checking out: 59947
[11:48:32.904] [info] 9) #PID<0.464.0> checking out: 59943
[11:48:33.405] [info] 9) #PID<0.465.0> checking back in: 59947
[11:48:33.405] [info] 9) #PID<0.464.0> checking back in: 59943
[11:48:33.899] [info] Checking out all connections (iteration 10)...
[11:48:33.902] [info] 10) #PID<0.466.0> checking out: 59947
[11:48:33.903] [info] 10) #PID<0.467.0> checking out: 59943
[11:48:34.403] [info] 10) #PID<0.466.0> checking back in: 59947
[11:48:34.404] [info] 10) #PID<0.467.0> checking back in: 59943
:ok
```

i.e. the connections get disconnected at some point within the next ~4s, as can be seen by the `ConnectionError` logs.

## Actual output

With `4295` as the interval paramter, we get an unexpected output, which is something like this:

```
iex(2)> DisconnectAll.Test.go 4295
[11:49:48.177] [info] Checking out all connections (iteration 1)...
[11:49:48.177] [info] Calling disconnect_all...
[11:49:48.178] [info] Checking out all connections (iteration 2)...
[11:49:48.179] [info] 1) #PID<0.471.0> checking out: 59943
[11:49:48.179] [info] 1) #PID<0.470.0> checking out: 59947
[11:49:48.680] [info] 1) #PID<0.471.0> checking back in: 59943
[11:49:48.680] [info] 1) #PID<0.470.0> checking back in: 59947
[11:49:48.682] [info] 2) #PID<0.472.0> checking out: 59943
[11:49:48.683] [info] 2) #PID<0.473.0> checking out: 59947
[11:49:49.179] [info] Checking out all connections (iteration 3)...
[11:49:49.184] [info] 2) #PID<0.473.0> checking back in: 59947
[11:49:49.184] [info] 2) #PID<0.472.0> checking back in: 59943
[11:49:49.186] [info] 3) #PID<0.475.0> checking out: 59943
[11:49:49.187] [info] 3) #PID<0.474.0> checking out: 59947
[11:49:49.687] [info] 3) #PID<0.475.0> checking back in: 59943
[11:49:49.688] [info] 3) #PID<0.474.0> checking back in: 59947
[11:49:50.180] [info] Checking out all connections (iteration 4)...
[11:49:50.183] [info] 4) #PID<0.476.0> checking out: 59943
[11:49:50.183] [info] 4) #PID<0.477.0> checking out: 59947
[11:49:50.684] [info] 4) #PID<0.476.0> checking back in: 59943
[11:49:50.684] [info] 4) #PID<0.477.0> checking back in: 59947
[11:49:51.181] [info] Checking out all connections (iteration 5)...
[11:49:51.185] [info] 5) #PID<0.478.0> checking out: 59943
[11:49:51.185] [info] 5) #PID<0.479.0> checking out: 59947
[11:49:51.686] [info] 5) #PID<0.478.0> checking back in: 59943
[11:49:51.686] [info] 5) #PID<0.479.0> checking back in: 59947
[11:49:52.182] [info] Checking out all connections (iteration 6)...
[11:49:52.187] [info] 6) #PID<0.481.0> checking out: 59947
[11:49:52.187] [info] 6) #PID<0.480.0> checking out: 59943
[11:49:52.688] [info] 6) #PID<0.481.0> checking back in: 59947
[11:49:52.688] [info] 6) #PID<0.480.0> checking back in: 59943
[11:49:53.183] [info] Checking out all connections (iteration 7)...
[11:49:53.184] [info] 7) #PID<0.482.0> checking out: 59947
[11:49:53.186] [info] 7) #PID<0.483.0> checking out: 59943
[11:49:53.685] [info] 7) #PID<0.482.0> checking back in: 59947
[11:49:53.687] [info] 7) #PID<0.483.0> checking back in: 59943
[11:49:54.184] [info] Checking out all connections (iteration 8)...
[11:49:54.192] [info] 8) #PID<0.484.0> checking out: 59947
[11:49:54.192] [info] 8) #PID<0.485.0> checking out: 59943
[11:49:54.693] [info] 8) #PID<0.484.0> checking back in: 59947
[11:49:54.693] [info] 8) #PID<0.485.0> checking back in: 59943
[11:49:55.185] [info] Checking out all connections (iteration 9)...
[11:49:55.188] [info] 9) #PID<0.486.0> checking out: 59947
[11:49:55.188] [info] 9) #PID<0.487.0> checking out: 59943
[11:49:55.689] [info] 9) #PID<0.486.0> checking back in: 59947
[11:49:55.689] [info] 9) #PID<0.487.0> checking back in: 59943
[11:49:56.186] [info] Checking out all connections (iteration 10)...
[11:49:56.190] [info] 10) #PID<0.488.0> checking out: 59947
[11:49:56.190] [info] 10) #PID<0.489.0> checking out: 59943
[11:49:56.691] [info] 10) #PID<0.488.0> checking back in: 59947
[11:49:56.691] [info] 10) #PID<0.489.0> checking back in: 59943
:ok
iex(3)> [11:49:58.467] [info] Postgrex.Protocol (#PID<0.411.0>) disconnected: ** (DBConnection.ConnectionError) disconnect_all requested
[11:49:58.467] [info] Postgrex.Protocol (#PID<0.412.0>) disconnected: ** (DBConnection.ConnectionError) disconnect_all requested
```

i.e. the connections don't get disconnected until they are idle at the very end of the function. This can be seen because the `ConnectionError` logs are at the very end, about ~2s after the final checkin.

## Explanation of code

The DB pool size is set to 2 for ease of seeing the problem.

First the code checks out 2 connections from the pool, then it calls `disconnect_all`.

It then checks the connections back in, but immediately after, checks then out again, and keeps doing this on a loop 10 times. This is so that the connections never go idle.

From the docs for `disconnect_all` (https://hexdocs.pm/db_connection/DBConnection.html#disconnect_all/3) we would expect the connections to be disconnected at some point within the interval, when checked in. However, values above `4294` only disconnect the connections when the connections become idle.

## Reason for the bug

We call to `:erlang.phash2` in this function: https://github.com/elixir-ecto/db_connection/blob/81cb6b6bf473f70758a58a5385beb482cc0e39aa/lib/db_connection/holder.ex#L243

`:erlang.phash2` has a maximum parameter value of `2^32` (https://www.erlang.org/doc/man/erlang.html#phash2-2).

We are passing the `interval` in "erlang native time units". On my operating system:

```elixir
System.convert_time_unit(floor(:math.pow(2, 32)), :native, :millisecond)
```

gives

```
4294
```

hence the upper bound on the interval parameter.

When the interval is bigger than this, the `rescue` clause in `maybe_disconnect` is invoked, which simply returns `false`, i.e. we don't disconnect until the connection becomes idle.