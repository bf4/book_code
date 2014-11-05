package com.mblinn.mbfpp.oo.fi.personexpanded

object PersonExample {
  case class Person(firstName: String, middleName: String, lastName: String)
  val p1 = Person("Aaron", "Jeffrey", "Smith")
  val p2 = Person("Aaron", "Bailey", "Zanthar")
  val p3 = Person("Brian", "Adams", "Smith")
  val people = Vector(p1, p2, p3)

  def complicatedSort(p1: Person, p2: Person) =
    if (p1.firstName != p2.firstName) 
      p1.firstName < p2.firstName
    else if (p1.lastName != p2.lastName)
      p1.lastName < p2.lastName
    else
      p1.middleName < p2.middleName

}
