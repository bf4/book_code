package com.mblinn.mbfpp.oo.command.register

class CashRegister(var total: Int) {
  def addCash(toAdd: Int) {
    total += toAdd
  }
}

object Register {
  def makePurchase(register: CashRegister, amount: Int) = {
    () => {
      println("Purchase in amount: " + amount)
      register.addCash(amount)
    }
  }
  
  var purchases: Vector[() => Unit] = Vector()
  def executePurchase(purchase: () => Unit) = {
    purchases = purchases :+ purchase
    purchase()
  }
}