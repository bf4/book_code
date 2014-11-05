import cucumber.runtime.{ScalaDsl, EN, PendingException}
import junit.framework.Assert._
import scala.collection.mutable.HashMap

class StockBrokerStepDefinitions extends ScalaDsl with EN {

  // step definitions go here

  var broker:StockBroker = null
  Given("""^I have (\d+) shares of ([A-Z]+)"""){ (num:Double, name:String) =>
    val shares = new HashMap[String, Double]
    shares += name -> num
    broker = new StockBroker(shares)
  }

  When("""^I sell all my ([A-Z]+) shares for \$([0-9.]+)/share$"""){
    (name:String, price:BigDecimal) =>
    broker.sellAll(name, price)
  }

  Then("""^I should have \$([0-9.]+)$"""){ (expected:BigDecimal) =>
    assertEquals(expected, broker.cash)
  }
}
