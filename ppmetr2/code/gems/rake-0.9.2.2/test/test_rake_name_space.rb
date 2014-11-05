#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path('../helper', __FILE__)

class TestRakeNameSpace < Rake::TestCase

  class TM
    include Rake::TaskManager
  end

  def test_namespace_creation
    mgr = TM.new
    ns = Rake::NameSpace.new(mgr, [])
    refute_nil ns
  end

  def test_namespace_lookup
    mgr = TM.new
    ns = mgr.in_namespace("n") do
      mgr.define_task(Rake::Task, "t")
    end

    refute_nil ns["t"]
    assert_equal mgr["n:t"], ns["t"]
  end

  def test_namespace_reports_tasks_it_owns
    mgr = TM.new
    nns = nil
    ns = mgr.in_namespace("n") do
      mgr.define_task(Rake::Task, :x)
      mgr.define_task(Rake::Task, :y)
      nns = mgr.in_namespace("nn") do
        mgr.define_task(Rake::Task, :z)
      end
    end
    mgr.in_namespace("m") do
      mgr.define_task(Rake::Task, :x)
    end

    assert_equal ["n:nn:z", "n:x", "n:y"],
      ns.tasks.map { |tsk| tsk.name }
    assert_equal ["n:nn:z"], nns.tasks.map {|t| t.name}
  end
end
