-module(example_store).
-include_lib("graphql/include/types.hrl").

%% API
-export([
  type/0
]).

type()-> graphql:objectType(<<"Store">>, <<"Store object">>, #{
  <<"get_value">> => #{
    type => ?STRING,
    args => #{
      <<"key">> => #{
        type => ?NON_NULL(?STRING),
        description => <<"Key for lookup">>
      }
    },
    resolver => fun(_, #{<<"key">> := Key}, #{ets_name := EtsName}) ->
      case ets:lookup(EtsName, Key) of
        [] -> <<"Not found value">>;
        [{Key, Value}] -> Value
      end
    end
  },

  <<"set_value">> => #{
    type => ?STRING,
    args => #{
      <<"key">> => #{
        type => ?NON_NULL(?STRING),
        description => <<"Key associated with value">>
      },
      <<"value">> => #{
        type => ?NON_NULL(?STRING),
        description => <<"Value for set or upgrade">>
      }
    },
    resolver => fun(_, #{<<"key">> := Key, <<"value">> := Value}, #{ets_name := EtsName}) ->
      true = ets:insert(EtsName, {Key, Value}),
      Value
    end
  }
}).
