#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule HtmlTest do
  use ExUnit.Case
  require EEx

  @times 100_000
  @template ~s(<h1><%= to_string "Welcome" %></h1><div><%= to_string "hello" %><span><%= to_string "there" %></span></div><table id="<%= "counter" %>" class="<%= "wide" %>"><tr><%= for x <- 1..4 do %><td><%= to_string x %></td><% end %></tr></table>)

  EEx.function_from_string :def, :render_eex, @template, []

  def render_html do
    import Html2
    html = markup do
      h1 do: text("Welcome")
      div do
        text "hello"
        span do
          text "there"
        end
      end

      table id: "counter", class: "wide" do
        tr do
          for x <- 1..4 do
            td do: text(x)
          end
        end
      end
    end
  end

  def benchmark(name, times, func) do
    wrap = fn ->
      for _ <- 0..times, do: func.()
    end

    time = wrap
    |> :timer.tc
    |> elem(0)
    |> Kernel./(1_000_000)

    IO.puts "#{name} x #{@times} in #{inspect time}"
  end

  test "eex renders" do
    benchmark "EEX", @times, fn -> render_eex end

    assert render_eex ==
     "<h1>Welcome</h1><div>hello<span>there</span></div><table id=\"counter\" class=\"wide\"><tr><td>1</td><td>2</td><td>3</td><td>4</td></tr></table>"
  end

  test "markup converts to html string" do
    benchmark "Html", @times, fn -> render_html end

    assert render_html ==
     "<h1>Welcome</h1><div>hello<span>there</span></div><table id=\"counter\" class=\"wide\"><tr><td>1</td><td>2</td><td>3</td><td>4</td></tr></table>"
  end
end
