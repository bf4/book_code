#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
require 'java'

$CLASSPATH << 'fest-swing-1.2.jar' << 'fest-util-1.1.2.jar' << 'fest-reflect-1.2.jar' << 'fest-assert-1.2.jar' << 'PresentationClock.jar'

java_import 'org.fest.swing.edt.GuiActionRunner'
java_import 'org.fest.swing.edt.GuiQuery'
java_import 'org.freeshell.zs.presentationclock.PresentationClock'
java_import 'org.fest.swing.fixture.FrameFixture'
java_import 'org.fest.swing.core.matcher.JButtonMatcher'
java_import 'org.fest.swing.core.matcher.DialogMatcher'

class TimerQuery < GuiQuery
  def executeInEDT
    PresentationClock.new []
  end
end

q = TimerQuery.new
f = GuiActionRunner.execute q
w = FrameFixture.new f

sleep 0.5

w.button(JButtonMatcher.with_text("Reset")).click

sleep 0.5

w.close
w.option_pane.require_title("Confirm Exit - PresentationClock").yes_button.click
