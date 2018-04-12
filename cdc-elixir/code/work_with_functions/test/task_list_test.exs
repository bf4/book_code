#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule TaskListTest do
  use ExUnit.Case

  test "add tasks and show" do
    File.rm("task_list.md")

    TaskList.add("My first task")
    TaskList.add("My second task")

    {:ok, contents} = TaskList.show_list

    assert contents == "[ ] My first task\n[ ] My second task\n"
  end

  test "add tasks and show using import" do
    File.rm("task_list.md")

    TaskListWithImport.add("My first task")
    TaskListWithImport.add("My second task")

    {:ok, contents} = TaskList.show_list

    assert contents == "[ ] My first task\n[ ] My second task\n"
  end
end
