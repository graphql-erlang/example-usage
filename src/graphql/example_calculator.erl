-module(example_calculator).
-include_lib("graphql/include/types.hrl").

%% API
-export([
  calculator/0
]).

calculator() -> graphql:objectType(<<"Calculator_ololo">>, <<"Simple calculator">>, #{
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
