#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'thor/actions'
require 'tempfile'

describe Thor::Actions::CreateLink do
  before do
    @hardlink_to = File.join(Dir.tmpdir, 'linkdest.rb')
    ::FileUtils.rm_rf(destination_root)
    ::FileUtils.rm_rf(@hardlink_to)
  end

  def create_link(destination=nil, config={}, options={})
    @base = MyCounter.new([1,2], options, { :destination_root => destination_root })
    @base.stub!(:file_name).and_return('rdoc')

    @tempfile = Tempfile.new("config.rb")

    @action = Thor::Actions::CreateLink.new(@base, destination, @tempfile.path,
                                            { :verbose => !@silence }.merge(config))
  end

  def invoke!
    capture(:stdout) { @action.invoke! }
  end

  def silence!
    @silence = true
  end

  describe "#invoke!" do
    it "creates a symbolic link for :symbolic => true" do
      create_link("doc/config.rb", :symbolic => true)
      invoke!
      destination_path = File.join(destination_root, "doc/config.rb")
      expect(File.exists?(destination_path)).to be_true
      expect(File.symlink?(destination_path)).to be_true
    end

    it "creates a hard link for :symbolic => false" do
      create_link(@hardlink_to, :symbolic => false)
      invoke!
      destination_path = @hardlink_to
      expect(File.exists?(destination_path)).to be_true
      expect(File.symlink?(destination_path)).to be_false
    end

    it "creates a symbolic link by default" do
      create_link("doc/config.rb")
      invoke!
      destination_path = File.join(destination_root, "doc/config.rb")
      expect(File.exists?(destination_path)).to be_true
      expect(File.symlink?(destination_path)).to be_true
    end

    it "does not create a link if pretending" do
      create_link("doc/config.rb", {}, :pretend => true)
      invoke!
      expect(File.exists?(File.join(destination_root, "doc/config.rb"))).to be_false
    end

    it "shows created status to the user" do
      create_link("doc/config.rb")
      expect(invoke!).to eq("      create  doc/config.rb\n")
    end

    it "does not show any information if log status is false" do
      silence!
      create_link("doc/config.rb")
      expect(invoke!).to be_empty
    end
  end

  describe "#identical?" do
    it "returns true if the destination link exists and is identical" do
      create_link("doc/config.rb")
      expect(@action.identical?).to be_false
      invoke!
      expect(@action.identical?).to be_true
    end
  end
end
