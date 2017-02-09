-module(example_graphql_handler).

%% API
-export([init/3, handle/2, terminate/3]).


init(_Type, Req, _Opts) ->
  {ok, Req, #{
  }}.

handle(Req, State)->
  {ok, Body, _} = cowboy_req:body(Req),

  #{
    <<"query">> := Document,
    <<"variables">> := Variables
  } = jsx:decode(Body, [return_maps]),

  Schema = example_schema:schema(),

  % pass State as context
  Response = graphql:execute(Schema, Document, #{}, State),

  {ok, Reply} = cowboy_req:reply(200, [
    {<<"content-type">>, <<"application/json">>}
  ], jsx:encode(Response), Req),
  {ok, Reply, State}.

terminate(_Reason, _Req, _State) ->
  ok.