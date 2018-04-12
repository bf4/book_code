#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class TodoViewController < UITableViewController

  attr_accessor :todos

  def viewDidLoad
    view.dataSource = view.delegate = self
    configure_buttons
    load_todos
  end

  def tableView(tableView, numberOfRowsInSection:section)
    todos ? todos.size : 0
  end

  CellId = "TodoCell"
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CellId) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:CellId)
      cell.selectionStyle = UITableViewCellSelectionStyleNone
      cell
    end

    todo = todos[indexPath.row]
    title = todo["title"]
    if todo["complete"]
      title = "\u2714 " + title
    else
      title = "      " + title
    end
    cell.textLabel.text = title
    cell.tag = todo["id"]
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    todo = todos[indexPath.row]
    todo = todo.mutableCopy
    todo["complete"] = !todo["complete"]
    api = TodoApi.new lambda {|data, error = nil|
      if error.nil?
        load_todos
      end
    }

    api.update_todo todo
  end

  def add_todo(title)
    api = TodoApi.new lambda {|data, error = nil|
      if error.nil?
        load_todos
      end
    }

    api.create_todo title
  end

  def present_add_todo_form
    alert = UIAlertController.alertControllerWithTitle("Add Todo",
      message: "Enter title:",
      preferredStyle: UIAlertControllerStyleAlert
    )
    cancelAction = UIAlertAction.actionWithTitle("Cancel",
      style:UIAlertActionStyleDefault,
      handler:nil
    )
    addAction = UIAlertAction.actionWithTitle("Add",
      style:UIAlertActionStyleDefault,
      handler:lambda{|action|
        title = alert.textFields[0].text
        unless title.empty?
          add_todo title
        end
      }
    )
    alert.addAction cancelAction
    alert.addAction addAction
    alert.addTextFieldWithConfigurationHandler nil
    presentViewController(alert, animated: true, completion:nil)
  end

  def load_todos
    api = TodoApi.new lambda {|data, error = nil|
      if error.nil?
        self.todos = data
        view.reloadData
      end
    }

    api.get_all_todos
  end

  def configure_buttons
    add_button = UIBarButtonItem.alloc.
      initWithBarButtonSystemItem(
        UIBarButtonSystemItemAdd,
                                target: self,
                                action: 'present_add_todo_form')
    self.navigationItem.rightBarButtonItem = add_button
  end

end
