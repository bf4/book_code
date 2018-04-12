#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class TodoViewController < UITableViewController

  def viewDidLoad
    view.dataSource = view.delegate = self
  end

  def tableView(tableView, numberOfRowsInSection:section)
    0
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    nil
  end

end
