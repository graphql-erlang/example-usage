-module(example_schema).
-author("mrchex").

%% API
-export([
  schema/0
]).


schema() -> graphql:schema(#{
  query => graphql:objectType(<<"RootSchema">>, <<"Graphql entrypoint">>, #{
    <<"calculator">> => #{
      type => {object, fun example_calculator:calculator/0},
      description => <<"Because we can!">>,
      args => #{
        <<"a">> => #{type => integer},
        <<"b">> => #{type => integer}
      },

      % pass args down as object
      resolver => fun(_, Args) -> Args end
    }
  })
}).