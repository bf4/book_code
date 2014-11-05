#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
require 'java'

Dir['jars/*.jar'].each { |jar| require jar }

java_import org.freeshell.zs.presentationclock.PresentationClock
java_import org.fest.swing.edt.GuiActionRunner
java_import org.fest.swing.edt.GuiQuery
java_import org.fest.swing.fixture.FrameFixture
java_import org.fest.swing.core.matcher.JButtonMatcher
java_import org.fest.swing.core.matcher.JLabelMatcher

class AppStarter < GuiQuery
  # Launch the app in the Event Dispatch Thread (EDT),
  # which is the thread reserved for user interfaces.
  # FEST will call this method for us before the test.
  #
  def executeInEDT
    PresentationClock.new []
  end
end

module HasFrame
  runner  = GuiActionRunner.execute(AppStarter.new)
  @@window = FrameFixture.new(runner)

  # ... more methods go here ...

  at_exit do
    title = 'Confirm Exit - PresentationClock'

    @@window.close
    @@window.option_pane.require_title(title).yes_button.click
  end

  def reset
    button = @@window.button(JButtonMatcher.with_text 'Reset')
    button.click
  end

  def look_for_text(expected)
    @@window.label JLabelMatcher.with_text(expected)
  end

end

World(HasFrame)

