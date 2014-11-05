package com.mblinn.mbfpp.oo.visitor

object Examples {
	trait Person {
	  def fullName: String
	  def firstName: String
	  def lastName: String
	  def houseNum: Int
	  def street: String
	}
	
	class SimplePerson(val firstName: String, val lastName: String,
			val houseNum: Int, val street: String) extends Person {
	  def fullName = firstName + " " + lastName
	}
	
	class ComplexPerson(name: Name, address: Address) extends Person {
	  def fullName = name.firstName + " " + name.lastName
	  
	  def firstName = name.firstName
	  def lastName = name.lastName
	  def houseNum = address.houseNum
	  def street = address.street
	}
	class Address(val houseNum: Int, val street: String)
	class Name(val firstName: String, val lastName: String)
	
	implicit class ExtendedPerson(person: Person) {
	  def fullAddress = person.houseNum + " " + person.street
	}
}