package com.mblinn.mbfpp.oo.iterator
import org.junit.runner.RunWith
import org.scalatest.matchers.ShouldMatchers
import org.scalatest.FunSpec
import org.scalatest.junit.JUnitRunner

import com.mblinn.mbfpp.oo.iterator.TheLambdaBarAndGrille._
import com.mblinn.mbfpp.oo.iterator.TheLambdaBarAndGrille.Person

@RunWith(classOf[JUnitRunner])
class LambdaBarAndGrille extends FunSpec with ShouldMatchers {
  describe("generateGreetings") {
    it("should generate a list of greetings for people in the appropriate zip codes") {
      val expectedMessages = Vector("Hello, Mike, and welcome to the Lambda Bar And Grille!", "Hello, John, and welcome to the Lambda Bar And Grille!")
      val people = Vector(
          Person("Mike", Address(19123)),
          Person("John", Address(19103)),
          Person("Jill", Address(19098))
          )
      val computedMessages = generateGreetings(people)
      expectedMessages should equal(computedMessages)
    }
  }
}