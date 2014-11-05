import scala.collection.mutable.HashMap
class StockBroker(val shares:HashMap[String, Double]) {
  var cash:BigDecimal = 0.0
  def sellAll(name:String, price:BigDecimal) {
    cash = cash + shares(name) * price
    shares -= name
  }
}
