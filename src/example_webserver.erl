-module(example_webserver).

-behaviour(gen_server).
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).


-record(state, {}).

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
  io:format("* Init webserver~n"),

  Dispatch = cowboy_router:compile([
    {'_', [
      {"/graphql", example_graphql_handler, []}
    ]}
  ]),

  cowboy:start_http(http, 100, [{port, 8088}], [
    {env, [{dispatch, Dispatch}]}
  ]),

  {ok, #state{}}.

%%%%%%%%%%%%%%%%%%%%%%
% GenServer callbacks
%%%%%%%%%%%%%%%%%%%%%%
handle_call(Msg, _From, State) ->
  io:format("Unknown handle_call: ~p~n", [Msg]),
  {reply, unknown, State}.

handle_cast(Msg, State) ->
  io:format("Unknown pubsub cast: ~p~n", [Msg]),
  {noreply, State}.

handle_info(start, S) ->
  {stop, normal, S}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.
