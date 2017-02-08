-module(example_sup).
-behaviour(supervisor).

-define(STOP_CHILD_TIMEOUT, 5000).
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, ?STOP_CHILD_TIMEOUT, Type, [I]}).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->

  {ok, { {one_for_one, 1, 10}, [
    ?CHILD(example_webserver, worker)
  ] }}.
