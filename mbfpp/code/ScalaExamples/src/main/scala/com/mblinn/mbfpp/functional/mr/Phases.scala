package com.mblinn.mbfpp.functional.mr
import scala.util.control.TailCalls._

object Phases {
  class Transition
  case object Ionization extends Transition
  case object Deionization extends Transition
  case object Vaporization extends Transition
  case object Condensation extends Transition
  case object Freezing extends Transition
  case object Melting extends Transition
  case object Sublimation extends Transition
  case object Deposition extends Transition
  
  def plasma(transitions: List[Transition]): TailRec[Boolean] = transitions match {
    case Nil => done(true)
    case Deionization :: restTransitions => tailcall(vapor(restTransitions))
    case _ => done(false)
  }
  def vapor(transitions: List[Transition]): TailRec[Boolean] = transitions match {
    case Nil => done(true)
    case Condensation :: restTransitions => tailcall(liquid(restTransitions))
    case Deposition :: restTransitions => tailcall(solid(restTransitions))
    case Ionization :: restTransitions => tailcall(plasma(restTransitions))
    case _ => done(false)
  }

  def liquid(transitions: List[Transition]): TailRec[Boolean] = transitions match {
    case Nil => done(true)
    case Vaporization :: restTransitions => tailcall(vapor(restTransitions)) 
    case Freezing :: restTransitions => tailcall(solid(restTransitions))
    case _ => done(false)
  }

  def solid(transitions: List[Transition]): TailRec[Boolean] = transitions match {
    case Nil => done(true)
    case Melting :: restTransitions => tailcall(liquid(restTransitions))
    case Sublimation :: restTransitions => tailcall(vapor(restTransitions))
    case _ => done(false)
  }

  val validSequence = List(Melting, Vaporization, Ionization, Deionization)
  
  val invalidSequence = List(Vaporization, Freezing)
}