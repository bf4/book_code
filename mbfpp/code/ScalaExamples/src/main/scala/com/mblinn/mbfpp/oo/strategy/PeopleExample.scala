package com.mblinn.mbfpp.oo.strategy

object PeopleExample {
  case class Person(
      firstName: Option[String], 
      middleName: Option[String], 
      lastName: Option[String])
  
  def isFirstNameValid(person: Person) = person.firstName.isDefined
  
  def isFullNameValid(person: Person) = person match {
    case Person(firstName, middleName, lastName) => 
      firstName.isDefined && middleName.isDefined && lastName.isDefined
  }
  
  def personCollector(isValid: (Person) => Boolean) = {
    var validPeople = Vector[Person]()
    (person: Person) => { 
      if(isValid(person)) validPeople = validPeople :+ person
      validPeople
    }
  }
  
  val p1 = Person(Some("John"), Some("Quincy"), Some("Adams"))
  val p2 = Person(Some("Mike"), None, Some("Linn"))
  val p3 = Person(None, None, None)
}