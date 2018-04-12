#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class TodoAdapter < Android::Widget::ArrayAdapter

  attr_accessor :todos, :todo_checkbox_listener

  class TodoViewHolder
    attr_accessor :checkbox
  end

  def getView(position, convert_view, parent_view)
    if convert_view.nil?
      inflater = Android::View::LayoutInflater.from getContext
      convert_view = inflater.inflate R::Layout::Todo_item, parent_view, false
      view_holder = TodoViewHolder.new
      convert_view.setTag view_holder
      view_holder.checkbox = convert_view.findViewById R::Id::Todo_checkbox
    else
      view_holder = convert_view.getTag
    end

    todo = getItem position
    view_holder.checkbox.tap do |cb|
      cb.setText todo["title"]
      cb.setChecked todo["complete"]
      cb.setTag position
      cb.setOnClickListener todo_checkbox_listener
    end
    convert_view
  end

end

