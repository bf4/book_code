package com.mblinn.mbfpp.functional.tr
import org.junit.runner.RunWith
import org.scalatest.matchers.ShouldMatchers
import org.scalatest.FunSpec
import org.scalatest.junit.JUnitRunner
import com.mblinn.mbfpp.functional.tr.Names._

@RunWith(classOf[JUnitRunner])
class NamesSpec extends FunSpec with ShouldMatchers {

  describe("makePeople"){
    it("should make people from two lists of names."){
      makePeople(List("firstone", "firsttwo"), List("lastone", "lasttwo")) should equal(
        List(Person("firstone", "lastone"), Person("firsttwo", "lasttwo")))
    }
  }
}