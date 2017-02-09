-module(example_calculator).
-author("mrchex").

%% API
-export([
  calculator/0
]).

calculator() -> graphql:objectType(<<"Calculator">>, <<"Simple calculator">>, #{
  <<"plus">> => #{
    type => integer,
    description => <<"A + B">>,
    resolver => fun (#{<<"a">> := A, <<"b">> := B}, _)-> A + B end
  },

  <<"minus">> => #{
    type => integer,
    description => <<"A - B">>,
    resolver => fun (#{<<"a">> := A, <<"b">> := B}, _)-> A - B end
  },

  <<"devide">> => #{
    type => integer,
    description => <<"A / B">>,
    resolver => fun (#{<<"a">> := A, <<"b">> := B}, _)-> A / B end
  },

  <<"multiply">> => #{
    type => integer,
    description => <<"A * B">>,
    resolver => fun (#{<<"a">> := A, <<"b">> := B}, _)-> A * B end
  }
}).
