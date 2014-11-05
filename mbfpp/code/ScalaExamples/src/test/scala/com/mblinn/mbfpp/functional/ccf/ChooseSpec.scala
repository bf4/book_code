package com.mblinn.mbfpp.functional.ccf
import org.junit.runner.RunWith
import org.scalatest.matchers.ShouldMatchers
import org.scalatest.FunSpec
import org.scalatest.junit.JUnitRunner

import com.mblinn.mbfpp.functional.ccf.Choose._

@RunWith(classOf[JUnitRunner])
class ChooseSpec extends FunSpec with ShouldMatchers {

  describe("the choose examples") {

    it("should choose the appropriate function") {
      val f1 = () => "f1"
      val f2 = () => "f2"
      val f3 = () => "f3"
        
      choose(1, f1, f2, f3) should equal("f1")
      choose(2, f1, f2, f3) should equal("f2")
      choose(3, f1, f2, f3) should equal("f3")
     }
    
    it("should choose the appropriate expression"){
      val e1 = "f1"
      val e2 = "f2"
      val e3 = "f3"
        
      simplerChoose(1, e1, e2, e3) should equal("f1")
      simplerChoose(2, e1, e2, e3) should equal("f2")
      simplerChoose(3, e1, e2, e3) should equal("f3")
    }
  }
}