/***
 * Excerpted from "Pragmatic Scala",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/vsscala2 for more book information.
***/
import scala.actors._
import Actor._

object NetAssetStockPriceHelper {
  val symbolsAndUnits = StockPriceFinder.getTickersAndUnits
  
  def getInitialTableValues : Array[Array[Any]] = {
    val emptyArrayOfArrayOfAny = new Array[Array[Any]](0,0)
    
    (emptyArrayOfArrayOfAny /: symbolsAndUnits) { (data, element) =>
      val (symbol, units) = element
      data ++ Array(List(symbol, units, "?", "?").toArray)
    }
  }
  
  def fetchPrice(updater: Actor) = actor {

  val caller = self

  symbolsAndUnits.keys.foreach { symbol =>
    actor { caller ! (symbol, StockPriceFinder.getLatestClosingPrice(symbol)) }
  }

  val netWorth = (0.0 /: (1 to symbolsAndUnits.size)) { (worth, index) =>
    receiveWithin(10000) { 
      case (symbol : String, latestClosingPrice: Double) =>
      val units = symbolsAndUnits(symbol)
      val value = units * latestClosingPrice
      updater ! (symbol, units, latestClosingPrice, value)
      worth + value
    }
  }
   
   updater ! netWorth
  }
}
