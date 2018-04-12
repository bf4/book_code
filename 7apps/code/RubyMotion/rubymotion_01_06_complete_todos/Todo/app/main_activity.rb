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
  UPDATE_TODO_ACTION          = "update_todo_action"

  class TodoReceiver < Android::Content::BroadcastReceiver
    attr_accessor :activity

    def onReceive(context, intent)
      action = intent.getAction
      case action
      when LOAD_TODOS_COMPLETE_ACTION
        todos = intent.getSerializableExtra LoadTodosOperation::TODOS
        activity.displayTodos todos
      when CREATE_TODO_COMPLETE_ACTION
        todo = intent.getSerializableExtra CreateTodoOperation::TODO
        puts "Created todo: #{todo["title"]}"
      end
    end
  end

  def onCreate(savedInstanceState)
    super

    setContentView R::Layout::Main_layout
    createReceiver
  end

  def onStart
    super

    @listView = findViewById R::Id::Todo_list
    loadTodos
  end

  def loadTodos
    LoadTodosOperation.new(getApplicationContext).execute
  end

  def displayTodos(todos)
    @listView.setAdapter(createAdapter(todos))
  end

  def createTodo(title)
    CreateTodoOperation.new(getApplicationContext, title).execute
  end

  def onClick(checkbox)
    position = checkbox.getTag
    todo = @listView.getAdapter.getItem(position)
    todo["complete"] = checkbox.isChecked
    UpdateTodoOperation.new(getApplicationContext, todo).execute
  end

  def createReceiver
    @todoReceiver = TodoReceiver.new.tap do |receiver|
      receiver.activity = self
      createIntentFilter = Android::Content::IntentFilter.new(
        CREATE_TODO_COMPLETE_ACTION)
      loadIntentFilter = Android::Content::IntentFilter.new(
        LOAD_TODOS_COMPLETE_ACTION)
      Android::Support::V4::Content::LocalBroadcastManager.
        getInstance(self).registerReceiver(receiver, createIntentFilter)
      Android::Support::V4::Content::LocalBroadcastManager.
        getInstance(self).registerReceiver(receiver, loadIntentFilter)
    end
  end

  def createAdapter(todos)
    TodoAdapter.new(self, 0, todos).tap do |adapter|
      adapter.todo_checkbox_listener = self
    end
  end

end
