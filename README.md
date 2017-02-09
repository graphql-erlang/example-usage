# Erlang GraphQL Example

IMPORTANT: Need installed libgraphqlparser

Just run:
```
    rebar3 auto
```

Now you can use included Graph*i*QL client at http://127.0.0.1:8088

You can find schemas at src/graphql. RootObject in example_schema.erl

# calculator

Simple example :)

Request:
```
{
  calculator(a:23 b: 150) {
    plus
    minus
    devide
    multiply
  }
}
```

Response:
```
{
  "data": {
    "calculator": {
      "multiply": 3450,
      "devide": 0.15333333333333332,
      "minus": -127,
      "plus": 173
    }
  },
  "errors": []
}
```

