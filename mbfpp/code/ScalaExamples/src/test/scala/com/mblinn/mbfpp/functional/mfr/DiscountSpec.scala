package com.mblinn.mbfpp.functional.mfr
import org.scalatest.junit.JUnitRunner
import org.scalatest.matchers.ShouldMatchers
import org.scalatest.FunSpec
import com.mblinn.mbfpp.functional.mfr.Discount._
import org.scalatest.junit.JUnitRunner
import org.junit.runner.RunWith

@RunWith(classOf[JUnitRunner])
class DiscountSpec extends FunSpec with ShouldMatchers {

  describe("The discount functions.") {
    it("should throw an exception on an empty sequence") {
      evaluating { calculateDiscount(Vector()) } should produce[UnsupportedOperationException]
    }

    it("should calculate a discount of 10 percent on items 20 dollars or greater.") {
      calculateDiscount(Vector(20.0, 4.5, 50.0, 15.75, 30.0, 3.50)) should equal(10)
      calculateDiscount(Vector(4.5, 15.75, 3.50)) should equal(0)
    }

    it("calculate discount and calculate discount named fn should work the same.") {
      calculateDiscount(Vector(20.0, 4.5, 50.0, 15.75, 30.0, 3.50)) should equal(calculateDiscountNamedFn(Vector(20.0, 4.5, 50.0, 15.75, 30.0, 3.50)))
      calculateDiscount(Vector(4.5, 15.75, 3.50)) should equal(calculateDiscountNamedFn(Vector(4.5, 15.75, 3.50)))
    }
  }

}