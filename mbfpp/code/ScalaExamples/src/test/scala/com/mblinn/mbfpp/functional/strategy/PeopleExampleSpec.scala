package com.mblinn.mbfpp.functional.strategy
import org.scalatest.matchers.ShouldMatchers
import org.scalatest.FunSpec
import org.junit.runner.RunWith
import org.scalatest.junit.JUnitRunner
import com.mblinn.mbfpp.oo.strategy.PeopleExample._

@RunWith(classOf[JUnitRunner])
class PeopleExampleSpec extends FunSpec with ShouldMatchers  {

  describe("isFirstNameValid"){
    it("should consider any person with a first name valid"){
      isFirstNameValid(Person(Some("Mike"), None, None)) should equal (true)
      isFirstNameValid(Person(Some("Mike"), Some("Peter"), None)) should equal (true)
      isFirstNameValid(Person(Some("Mike"), Some("Peter"), Some("Linn"))) should equal (true)
    }
    
    it("should consider any person without a first name invalid"){
      isFirstNameValid(Person(None, None, None)) should equal (false)
      isFirstNameValid(Person(None, Some("Peter"), None)) should equal (false)
      isFirstNameValid(Person(None, Some("Peter"), Some("Linn"))) should equal (false)
    }
  }
  
  describe("isFullNameValid"){
    it("considers a person valid only if it has all three names"){
      isFullNameValid(Person(None, None, None)) should equal (false)
      isFullNameValid(Person(Some("Mike"), None, None)) should equal (false)
      isFullNameValid(Person(Some("Mike"), Some("Peter"), None)) should equal (false)
      isFullNameValid(Person(Some("Mike"), Some("Peter"), Some("Linn"))) should equal (true)
    }
  }
  
  describe("personCollector"){
    it("collects valid people and returns the set of valid people its seen so far"){
      val collectPerson = personCollector((person: Person) => true)
      val p1 = Person(Some("fn1"), Some("mn1"), Some("ln1"))
      val p2 = Person(Some("fn2"), Some("mn2"), Some("ln2"))
      var expected = Vector(p1)
      collectPerson(p1) should equal (expected)
      expected = expected :+ p2
      collectPerson(p2) should equal(expected)
    }
  }
}