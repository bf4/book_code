package com.mblinn.mbfpp.oo.fi.person

object PersonExample {  
  (int1: Int, int2: Int) => int1 + int2
  
  case class Person(firstName: String, lastName: String)

  val p1 = Person("Michael", "Bevilacqua")
  val p2 = Person("Pedro", "Vasquez")
  val p3 = Person("Robert", "Aarons")

  val people = Vector(p3, p2, p1)
  
  people.sortWith((p1, p2) => p1.firstName < p2.firstName)
}