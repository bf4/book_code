package com.mblinn.mbfpp.oo.nullobject

object Examples {

  case class Person(firstName: String="John", lastName: String="Doe")
  val nullPerson = Person()
  
  def fetchPerson(people: Map[Int, Person], id: Int) = 
    people.getOrElse(id, nullPerson)
 
  val joe = Person("Joe", "Smith")
  val jack = Person("Jack", "Brown")
  val somePeople = Map(1 -> joe, 2 -> jack)
  
  def vecFoo = Vector("foo")
  def someFoo = Some("foo")
  def someBar = Some("bar")
  def aNone = None
    
  def buildPerson(firstNameOption: Option[String], lastNameOption: Option[String]) =
    (for(
        firstName <- firstNameOption;
        lastName <- lastNameOption)
      yield Person(firstName, lastName)).getOrElse(Person("John", "Doe"))
}