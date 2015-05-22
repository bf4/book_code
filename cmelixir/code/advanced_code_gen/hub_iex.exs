#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
$ iex -S mix

iex> Hub.
atlas/0                        bclose.vim/0
calliope/0                     chrismccord.com/0
dot_vim/0                      elixir/0
elixir_express/0               ex_copter/0
genserver_stack_example/0      gitit/0
go/1                           haml-coffee/0
historian/0                    jazz/0
jellybeans.vim/0               labrador/0
linguist/0                     phoenix_chat_example/0
plug/0                         phoenix_haml/0
phoenix_render_example/0       phoenix_vs_rails_showdown/0

iex> Hub.linguist
%{"description" => "Elixir Internationalization library",
  "full_name" => "chrismccord/linguist",
  "git_url" => "git://github.com/chrismccord/linguist.git",
  "open_issues" => 4, "open_issues_count" => 4,
  "pushed_at" => "2014-08-04T13:28:30Z",
  "watchers" => 33,
  ...
}

iex> Hub.linguist["description"]
"Elixir Internationalization library"

iex> Hub.linguist["watchers"]
33

iex> Hub.go :linguist
Launching browser to https://github.com/chrismccord/linguist...

