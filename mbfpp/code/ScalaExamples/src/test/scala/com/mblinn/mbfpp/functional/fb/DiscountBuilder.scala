package com.mblinn.mbfpp.functional.fb
import org.scalatest.junit.JUnitRunner
import org.scalatest.FunSpec
import com.mblinn.mbfpp.functional.fb.DiscountBuilder._
import org.junit.runner.RunWith
import org.scalatest.matchers.ShouldMatchers

@RunWith(classOf[JUnitRunner])
class DiscountBuilderSpec extends FunSpec with ShouldMatchers {

  describe("A Discount Calculator Builder") {

    it("should return a function that applies a zero percent discount") {
      discount(0)(100) should equal(100)
    }

    it("should return a function that applies a 100 percent discount") {
      discount(100)(100) should equal(0)
    }

    it("should return a function that applies discounts between 1 and 99") {
      for(percentage <- Range(1, 100)) {
        discount(percentage)(100) should equal(100 - (percentage * 100 * 0.01))
      }
    }

    it("should only allow discounts in the range between 0 and 100") {
      evaluating { discount(-1) } should produce [IllegalArgumentException]
      evaluating { discount(101) } should produce [IllegalArgumentException]
    }
  }
}