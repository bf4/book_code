#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
iex> c "macros/unless.exs"
[ControlFlow]

iex> require ControlFlow
nil

iex> ast = quote do 
...>   ControlFlow.unless 2 == 5, do: "block entered"
...> end
{{:., [], [{:__aliases__, [alias: false], [:ControlFlow]}, :unless]}, [],
 [{:==, [context: Elixir, import: Kernel], [2, 5]}, [do: "block entered"]]}

iex> expanded_once = Macro.expand_once(ast, __ENV__) 
{:if, [context: ControlFlow, import: Kernel],
 [{:!, [context: ControlFlow, import: Kernel],
   [{:==, [context: Elixir, import: Kernel], [2, 5]}]}, [do: "block entered"]]}

iex> expanded_fully = Macro.expand_once(expanded_once, __ENV__) 
{:case, [optimize_boolean: true],
 [{:!, [context: ControlFlow, import: Kernel],
   [{:==, [context: Elixir, import: Kernel], [2, 5]}]},
  [do: [{:->, [],
     [[{:when, [],
        [{:x, [counter: 4], Kernel},
         {:in, [context: Kernel, import: Kernel],
          [{:x, [counter: 4], Kernel}, [false, nil]]}]}], nil]},
    {:->, [], [[{:_, [], Kernel}], "block entered"]}]]]}

