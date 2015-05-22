/***
 * Excerpted from "Pragmatic Scala",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/vsscala2 for more book information.
***/
import scala.swing._
import event._

object SampleGUI extends SimpleGUIApplication {
  def top = new MainFrame {
    title = "A Sample Scala Swing GUI"
  
    val label = new Label { text = "------------"}
    val button = new Button { text = "Click me" }

    contents = new FlowPanel {
      contents += label
      contents += button    
    }
    listenTo(button)
    reactions += {
      case ButtonClicked(button) =>
        label.text = "You clicked!"
    }
  }
}