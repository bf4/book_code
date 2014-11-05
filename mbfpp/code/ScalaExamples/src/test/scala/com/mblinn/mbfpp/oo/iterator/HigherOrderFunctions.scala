package com.mblinn.mbfpp.oo.iterator
import org.junit.runner.RunWith
import org.scalatest.matchers.ShouldMatchers
import org.scalatest.FunSpec
import org.scalatest.junit.JUnitRunner

import com.mblinn.mbfpp.oo.iterator.HigherOrderFunctions._

@RunWith(classOf[JUnitRunner])
class HigherOrderFunctionSpecs extends FunSpec with ShouldMatchers {
  describe("sumSequence"){
    it("should sum a sequence"){
      sumSequence(Vector(42, 100, 58)) should equal(200)
    }
    it("should disallow summing an empty sequence"){
      evaluating { sumSequence(Vector[Int]()) } should produce[UnsupportedOperationException]
    }
  }
  
  describe("prependHello"){
    it("should prepend hello to a sequence"){
      prependHello(Vector[String]("Mike", "Joe", "John")) should equal(Vector("Hello, Mike", "Hello, Joe", "Hello, John"))
    }
    it("should return an empty sequence when passed an empty sequence"){
      prependHello(Vector[String]()) should equal(Vector[String]())
    }
  }
  
  describe("vowelsInWord"){
    it("should return a set of vowels in a given word"){
      vowelsInWord("asdfe") should equal(Set[Char]('a', 'e'))
    }
    it("should return the empty set if there are no vowels in the word"){
      vowelsInWord("cfg") should equal(Set[Char]())
    }
  }
}