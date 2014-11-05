package com.mblinn.mbfpp.functional.fb
import org.scalatest.junit.JUnitRunner
import org.scalatest.FunSpec
import org.junit.runner.RunWith
import org.scalatest.matchers.ShouldMatchers
import com.mblinn.mbfpp.functional.fb.Selector._

@RunWith(classOf[JUnitRunner])
class SelectorSpec extends FunSpec with ShouldMatchers {

  describe("A Selector Builder") {
    it("should create a selector capable of extracting a key one layer deep") {
      val ds = Map('foo -> "foo")
      selector('foo)(ds) should equal(Some("foo"))
    }

    it("should create a selector capable of extracing a key several layers deep") {
      val ds = Map('foo -> Map('bar -> Map('baz -> "baz")))
      selector('foo, 'bar, 'baz)(ds) should equal(Some("baz"))
    }

    it("should create a selector that returns None if it does not match") {
      val ds = Map('foo -> Map('bar -> Map('baz -> "baz")))
      selector('foo, 'quz)(ds) should equal(None)
    }

    it("should create a selector that returns None if an intermedia part of the datastructure is not Map[Symbol, Any]") {
      val ds = Map('foo -> Vector('bar))
      selector('foo, 'bar)(ds) should equal(None)
    }

    it("should not allow an empty path") {
      evaluating { selector() } should produce[IllegalArgumentException]
    }
  }
}