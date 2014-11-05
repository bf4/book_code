package com.mblinn.mbfpp.functional.mr
import org.junit.runner.RunWith
import org.scalatest.matchers.ShouldMatchers
import org.scalatest.FunSpec
import org.scalatest.junit.JUnitRunner
import com.mblinn.mbfpp.functional.mr.EvenOdd._

@RunWith(classOf[JUnitRunner])
class EvenOddSpec extends FunSpec with ShouldMatchers {

  describe("The even and odd functions should determine even and odd.") {
    it("should calculate odd and even correctly") {
      isOdd(100) should equal(false)
      isEven(100) should equal(true)
      isOdd(101) should equal(true)
      isEven(101) should equal(false)
      isOddTrampoline(100).result should equal(false)
      isEvenTrampoline(100).result should equal(true)
      isOddTrampoline(101).result should equal(true)
      isEvenTrampoline(101).result should equal(false)
    }
  }

}