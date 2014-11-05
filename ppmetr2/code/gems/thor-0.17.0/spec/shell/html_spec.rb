#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Thor::Shell::HTML do
  def shell
    @shell ||= Thor::Shell::HTML.new
  end

  describe "#say" do
    it "set the color if specified" do
      out = capture(:stdout) { shell.say "Wow! Now we have colors!", :green }
      expect(out.chomp).to eq('<span style="color: green;">Wow! Now we have colors!</span>')
    end

    it "sets bold if specified" do
      out = capture(:stdout) { shell.say "Wow! Now we have colors *and* bold!", [:green, :bold] }
      expect(out.chomp).to eq('<span style="color: green; font-weight: bold;">Wow! Now we have colors *and* bold!</span>')
    end

    it "does not use a new line even with colors" do
      out = capture(:stdout) { shell.say "Wow! Now we have colors! ", :green }
      expect(out.chomp).to eq('<span style="color: green;">Wow! Now we have colors! </span>')
    end
  end

  describe "#say_status" do
    it "uses color to say status" do
      $stdout.should_receive(:puts).with('<span style="color: red; font-weight: bold;">    conflict</span>  README')
      shell.say_status :conflict, "README", :red
    end
  end

end
