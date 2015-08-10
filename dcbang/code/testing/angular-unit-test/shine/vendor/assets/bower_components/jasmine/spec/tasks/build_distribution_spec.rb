#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
require 'spec_helper.rb'

describe "Build Jasmine task" do

  let(:jasmine_core_dir) { "#{Dir.tmpdir}/jasmine-core" }
  let(:jasmine_dev) { JasmineDev.new }

  before do
    reset_dir jasmine_core_dir
    @output = capture_output { jasmine_dev.build_distribution jasmine_core_dir }
  end

  it "should say that JSHint is running" do
    @output.should match(/Running JSHint/)
    @output.should match(/Jasmine JSHint PASSED/)
  end

  it "should tell the developer it is building the distribution" do
    @output.should match(/Building Jasmine distribution/)
  end

  it "should build jasmine.js in the destination directory" do
    File.exist?("#{jasmine_core_dir}/jasmine.js").should be_true
  end

  it "should build jasmine-html.js in the destination directory" do
    File.exist?("#{jasmine_core_dir}/jasmine-html.js").should be_true
  end

  it "should build jasmine.css" do
    File.exist?("#{jasmine_core_dir}/jasmine.css").should be_true
  end
end