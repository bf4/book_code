package com.mblinn.mbfpp.functional.mr
import com.mblinn.mbfpp.functional.mr.Phases._
import org.scalatest.matchers.ShouldMatchers
import org.scalatest.FunSpec
import org.junit.runner.RunWith
import org.scalatest.junit.JUnitRunner

@RunWith(classOf[JUnitRunner])
class PhasesSpec extends FunSpec with ShouldMatchers {
  describe("A phases state machine"){
    it("should treat liquid-solid-liquid-vapor-plasma-liquid as valid"){
      val sequence = List(Freezing, Melting, Vaporization, Ionization, Deionization)
      liquid(sequence).result should equal(true)
    }
    it("should treat liquid-plasma as invalid"){
      liquid(List(Ionization)).result should equal(false)
    }
    it("should treat the empty sequence as valid"){
      liquid(List()).result should equal(true)
    }
  }
}