#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
describe "Todo Controller" do

  before do
    class TodoViewController
      def load_todos
        # noop, so no api call is made
      end
    end
  end

  tests TodoViewController

  before do
    controller.todos = todo_data.values
  end

  it "marks completed items as complete" do
    views(UITableViewCell).each do |cell|
      todo = todo_data[cell.tag]
      displayed_title = cell.textLabel.text
      if todo["complete"]
        displayed_title.should.match(/\u2714/)
      else
        displayed_title.should.not.match(/\u2714/)
      end
    end
  end

  def todo_data
    {
      1 => { "id" => 1,
        "title" => "Get Milk",
        "complete" => false },
      2 => { "id" => 2,
        "title" => "Get Cereal",
        "complete" => true }
    }
  end

end
