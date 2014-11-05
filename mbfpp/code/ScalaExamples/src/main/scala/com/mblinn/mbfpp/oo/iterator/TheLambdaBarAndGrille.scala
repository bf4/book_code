package com.mblinn.mbfpp.oo.iterator

import com.mblinn.oo.iterator.Address;

object TheLambdaBarAndGrille {

  case class Person(name: String, address: Address)
  case class Address(zip: Int)
  def generateGreetings(people: Seq[Person]) =
    for (Person(name, address) <- people if isCloseZip(address.zip))
      yield "Hello, %s, and welcome to the Lambda Bar And Grille!".format(name)
  def isCloseZip(zipCode: Int) = zipCode == 19123 || zipCode == 19103

  def printGreetings(people: Seq[Person]) =
    for (Person(name, address) <- people if isCloseZip(address.zip))
      println("Hello, %s, and welcome to the Lambda Bar And Grille!".format(name))
}