-module(example_schema).
-include_lib("graphql/include/types.hrl").

%% API
-export([
  schema/0
]).

enum_fun() -> ?ENUM(<<"EnumFun">>, <<"Reusable enum">>, [
  ?ENUM_VAL(1, <<"ONE">>, <<"This is 1">>),
  ?ENUM_VAL(2, <<"TWO">>, <<"This is 2">>),
  ?ENUM_VAL(10, <<"TEN">>, <<"This is 10">>)
]).


schema() -> graphql:schema(#{
  query => graphql:objectType(<<"QueryRoot">>, <<"Graphql entrypoint">>, #{
    <<"calculator">> => #{
      type => fun example_calculator:calculator/0,
      description => <<"Because we can!">>,
      args => #{
        <<"a">> => #{type => ?INT},
        <<"b">> => #{type => ?INT}
      },

      % pass args down as object
      resolver => fun(_, Args) -> Args end
    },

    <<"enum">> => #{
      type => ?INT,
      description => <<"FUN + INLINE">>,
      args => #{
        <<"fun">> => #{type => fun enum_fun/0},
        <<"inline">> => #{type => ?ENUM(<<"EnumInline">>, <<"Inline enum. Steel must have unique name">>, [
          ?ENUM_VAL(4, <<"FOUR">>, <<"4">>),
          ?ENUM_VAL(5, <<"FIVE">>, <<"5">>)
        ])}
      },
      resolver => fun(_, #{<<"fun">> := A, <<"inline">> := B}) -> A + B end
    },

    <<"search">> => #{
      type => ?LIST(fun example_search:union/0),
      description => <<"Test Unions">>,
      resolver => fun() -> [
        {fun example_search:user/0, #{<<"username">> => <<"Union">>}},
        {fun example_search:post/0, #{<<"title">> => <<"Post1">>, <<"text">> => <<"text1">>}},
        {fun example_search:user/0, #{<<"username">> => <<"Union2">>}},
        {fun example_search:post/0, #{<<"title">> => <<"Post2">>, <<"text">> => <<"text2">>}},
        {fun example_search:post/0, #{<<"title">> => <<"Post3">>, <<"text">> => <<"text3">>}},
        {fun example_search:comment/0, #{<<"text">> => <<"comment">>}}
      ] end
    }
  }),

  mutation => graphql:objectType(<<"MutationRoot">>, <<"Test mutations">>, #{
    <<"store">> => #{
      type => fun example_store:type/0,
      resolver => fun(_,_, Context) ->
        EtsName = example,
        ets:new(EtsName, [set, named_table]),
        {#{}, Context#{
          ets_name => EtsName
        }}
      end
    }
  })
}).