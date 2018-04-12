#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class LoadTodosOperation < Operation

  TODOS = "todos"

  def initialize(context)
    super(context)
  end

  def run
    api = TodoApi.new
    todos, error = api.get_all_todos

    # TODO: deal with error if not nil
    intent = new_intent MainActivity::LOAD_TODOS_COMPLETE_ACTION
    add_serializable_extras intent, TODOS => todos

    broadcast_intent intent
  end

end
