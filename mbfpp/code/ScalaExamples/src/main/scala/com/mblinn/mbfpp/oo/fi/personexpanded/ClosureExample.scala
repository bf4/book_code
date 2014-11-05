package com.mblinn.mbfpp.oo.fi.personexpanded

object ClosureExample {

  case class Person(firstName: String, middleName: String, lastName: String)

  def makeComposedComparison(comparisons: (Person, Person) => Int*) = 
    (p1: Person, p2: Person) => 
      comparisons.map(cmp => cmp(p1, p2)).find(_ != 0).getOrElse(0)
    
  def firstNameComparison(p1: Person, p2: Person) = 
    p1.firstName.compareTo(p2.firstName)

  def lastNameComparison(p1: Person, p2: Person) = 
    p1.lastName.compareTo(p2.lastName)
  
  val firstAndLastNameComparison = makeComposedComparison(
      firstNameComparison, lastNameComparison
  )

  val p1 = Person("John", "", "Adams")
  val p2 = Person("John", "Quincy", "Adams")
}