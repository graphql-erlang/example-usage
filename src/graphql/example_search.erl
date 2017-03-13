-module(example_search).
-include_lib("graphql/include/types.hrl").

%% API
-export([
  union/0,
  post/0,
  comment/0,
  user/0
]).

union() -> ?UNION(<<"UnionSearch">>, <<"Test union introspection">>, [
  fun post/0,
  fun comment/0,
  fun user/0
]).

post() -> graphql:objectType(<<"Post">>, <<"Post for union search">>, #{
  <<"title">> => #{ type => ?STRING },
  <<"text">> => #{ type => ?STRING }
}).

comment() -> graphql:objectType(<<"Comment">>, <<"Comment for union search">>, #{
  <<"text">> => #{type => ?STRING}
}).

user() -> graphql:objectType(<<"User">>, <<"User for union search">>, #{
  <<"username">> => #{ type => ?STRING}
}).
