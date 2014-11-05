package com.mblinn.mbfpp.functional.mr
import scala.util.control.TailCalls._

object EvenOdd {

  def isOdd(n: Long): Boolean = if (n == 0) false else isEven(n - 1)

  def isEven(n: Long): Boolean = if (n == 0) true else isOdd(n - 1)

  def isOddTrampoline(n: Long): TailRec[Boolean] =
    if (n == 0) done(false) else tailcall(isEvenTrampoline(n - 1))

  def isEvenTrampoline(n: Long): TailRec[Boolean] =
    if (n == 0) done(true) else tailcall(isOddTrampoline(n - 1))
}