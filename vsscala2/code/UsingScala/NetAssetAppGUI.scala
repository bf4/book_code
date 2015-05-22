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
import scala.actors._
import Actor._
import java.awt.Color

object NetAssetAppGUI extends SimpleGUIApplication {
  def top = mainFrame
  
  val mainFrame = new MainFrame {
    title = "Net Asset"
    
    val dateLabel = new Label { text = "Last updated: ----- " }
         
    val valuesTable = new Table(
       NetAssetStockPriceHelper.getInitialTableValues, 
       Array("Ticker", "Units", "Price", "Value")) {
       showGrid = true
       gridColor = Color.BLACK
    }

    val updateButton = new Button { text = "Update" }
    val netAssetLabel = new Label { text = "Net Asset: ????" }

    contents = new BoxPanel(Orientation.Vertical) {
      contents += dateLabel
      contents += valuesTable
      contents += new ScrollPane(valuesTable)
      
      contents += new FlowPanel {
        contents += updateButton
        contents += netAssetLabel
      }      
    }

    listenTo(updateButton)    
    
    reactions += {
      case ButtonClicked(button) =>
        button.enabled = false
        NetAssetStockPriceHelper fetchPrice uiUpdater
    }
             
    val uiUpdater = new Actor {
      def act = {
        loop {
          react {
            case (symbol : String, units : Int, price : Double, value : Double) =>
              updateTable(symbol, units, price, value)
            case netAsset =>
              netAssetLabel.text = "Net Asset: " + netAsset
              dateLabel.text = "Last updated: " + new java.util.Date()
              updateButton.enabled = true 
          }
        }
      }
      
      override protected def scheduler() = new SingleThreadedScheduler
    }
    
    uiUpdater.start()

    def updateTable(symbol: String, units : Int, price : Double, value : Double) {
      for(i <- 0 until valuesTable.rowCount) {
        if (valuesTable(i, 0) == symbol) {
          valuesTable(i, 2) = price
          valuesTable(i, 3) = value
        }
      }
    }
  }
}
