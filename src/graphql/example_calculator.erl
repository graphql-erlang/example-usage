-module(example_calculator).
-include("graphql/include/types.hrl").

%% API
-export([
  calculator/0
]).

calculator() -> graphql:objectType(<<"Calculator">>, <<"Simple calculator">>, #{
  <<"plus">> => #{
    type => ?INT,
    description => <<"A + B">>,
    resolver => fun (#{<<"a">> := A, <<"b">> := B}, _)-> A + B end
  },

  <<"minus">> => #{
    type => ?INT,
    description => <<"A - B">>,
    resolver => fun (#{<<"a">> := A, <<"b">> := B}, _)-> A - B end
  },

  <<"devide">> => #{
    type => ?FLOAT,
    description => <<"A / B">>,
    resolver => fun (#{<<"a">> := A, <<"b">> := B}, _)-> A / B end
  },

  <<"multiply">> => #{
    type => ?INT,
    description => <<"A * B">>,
    resolver => fun (#{<<"a">> := A, <<"b">> := B}, _)-> A * B end
  }
}).
