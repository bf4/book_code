#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'spec_helper'

describe "VCR.version" do
  subject { VCR.version }

  it { should =~ /\A\d+\.\d+\.\d+(\.\w+)?\z/ }
  its(:parts) { should be_instance_of(Array)  }
  its(:major) { should be_instance_of(Fixnum) }
  its(:minor) { should be_instance_of(Fixnum) }
  its(:patch) { should be_instance_of(Fixnum) }
end
