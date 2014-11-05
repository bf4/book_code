#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Rake

  # The NameSpace class will lookup task names in the the scope
  # defined by a +namespace+ command.
  #
  class NameSpace

    # Create a namespace lookup object using the given task manager
    # and the list of scopes.
    def initialize(task_manager, scope_list)
      @task_manager = task_manager
      @scope = scope_list.dup
    end

    # Lookup a task named +name+ in the namespace.
    def [](name)
      @task_manager.lookup(name, @scope)
    end

    # Return the list of tasks defined in this and nested namespaces.
    def tasks
      @task_manager.tasks_in_scope(@scope)
    end
  end
end
