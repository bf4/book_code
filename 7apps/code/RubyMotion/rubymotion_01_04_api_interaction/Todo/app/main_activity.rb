#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class MainActivity < Android::Support::V7::App::AppCompatActivity
  LOAD_TODOS_COMPLETE_ACTION  = "load_todo_complete"
  CREATE_TODO_COMPLETE_ACTION = "create_todo_complete"

  class TodoReciever < Android::Content::BroadcastReceiver
    def onReceive(context, intent)
      action = intent.getAction
      case action
      when LOAD_TODOS_COMPLETE_ACTION
        todos = intent.getSerializableExtra LoadTodosOperation::TODOS
        puts "Loaded todo list: #{todos}"
      when CREATE_TODO_COMPLETE_ACTION
        todo = intent.getSerializableExtra CreateTodoOperation::TODO
        puts "Created todo: #{todo["title"]}"
      end
    end
  end

  def onCreate(savedInstanceState)
    super

    @todoReciever = TodoReciever.new
    createIntentFilter =
      Android::Content::IntentFilter.new(CREATE_TODO_COMPLETE_ACTION)
    loadIntentFilter =
      Android::Content::IntentFilter.new(LOAD_TODOS_COMPLETE_ACTION)
    Android::Support::V4::Content::LocalBroadcastManager.
      getInstance(self).registerReceiver(@todoReciever, createIntentFilter)
    Android::Support::V4::Content::LocalBroadcastManager.
      getInstance(self).registerReceiver(@todoReciever, loadIntentFilter)
  end

  def loadTodos
    LoadTodosOperation.new(getApplicationContext).execute
  end

  def createTodo(title)
    CreateTodoOperation.new(getApplicationContext, title).execute
  end

end
