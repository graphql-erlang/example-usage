-module(example).

-export([
  start/0,
  stop/0
]).


start() ->
  ok = application:start(example).

stop() ->
  application:stop(example).
