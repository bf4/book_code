#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class CreateTodoOperation < Operation

  TODO = "todo"

  def initialize(context, title)
    super(context)
    @title = title
  end

  def run
    api = TodoApi.new
    todo, error = api.create_todo(@title)

    # TODO: deal with error if not nil
    intent = new_intent MainActivity::CREATE_TODO_COMPLETE_ACTION
    add_serializable_extras intent, TODO => todo

    broadcast_intent intent
  end

end

