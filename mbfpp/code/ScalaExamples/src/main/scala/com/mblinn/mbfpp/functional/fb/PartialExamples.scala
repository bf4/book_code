package com.mblinn.mbfpp.functional.fb

object PartialExamples {

  def addTwoInts(intOne: Int, intTwo: Int) = intOne + intTwo

  val addFortyTwo = addTwoInts(42, _: Int)

  def taxForState(amount: Double, state: Symbol) = state match {
    // Simple tax logic, for example only!  
    case ('NY) => amount * 0.0645
    case ('PA) => amount * 0.045
    // Rest of states...
  }
  val nyTax = taxForState(_: Double, 'NY)
  val paTax = taxForState(_: Double, 'PA)
}