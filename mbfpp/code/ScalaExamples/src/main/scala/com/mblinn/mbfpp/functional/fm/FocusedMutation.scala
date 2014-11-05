package com.mblinn.mbfpp.functional.fm

import scala.util.Random
import scala.collection.immutable.Stream
import scala.collection.mutable.ArrayBuffer
import java.util.ArrayList
import java.util.concurrent.TimeUnit
import scala.collection._

object Examples {

  case class Purchase(storeNumber: Int, customerNumber: Int, itemNumber: Int)

  val r = new Random
  def makeTestPurchase = Purchase(r.nextInt(100), r.nextInt(1000), r.nextInt(500))
  def infiniteTestPurchases: Stream[Purchase] =
    makeTestPurchase #:: infiniteTestPurchases

  val oneHundredThousand = 100000
  val fiveHundredThousand = 500000
  
  def immutableSequenceEventProcessing(count: Int) = {
    val testPurchases = infiniteTestPurchases.take(count)
    var mapOfPurchases = immutable.Map[Int, List[Purchase]]()

    for (purchase <- testPurchases)
      mapOfPurchases.get(purchase.storeNumber) match {
        case None => mapOfPurchases =
          mapOfPurchases + (purchase.storeNumber -> List(purchase))
        case Some(existing: List[Purchase]) => mapOfPurchases =
          mapOfPurchases + (purchase.storeNumber -> (purchase :: existing))
      }
  }

  def immutableSequenceEventProcessingFoldl(count: Int) = {
    val testPurchases = infiniteTestPurchases.take(count)
    var mapOfPurchases = immutable.Map[Int, List[Purchase]]()

    for (purchase <- testPurchases)
      mapOfPurchases.get(purchase.storeNumber) match {
        case None => mapOfPurchases =
          mapOfPurchases + (purchase.storeNumber -> List(purchase))
        case Some(existing: List[Purchase]) => mapOfPurchases =
          mapOfPurchases + (purchase.storeNumber -> (purchase :: existing))
      }
  }

  
  def mutableSequenceEventProcessing(count: Int) = {
    val testPurchases = infiniteTestPurchases.take(count)
    val mapOfPurchases = mutable.Map[Int, List[Purchase]]()

    for (purchase <- testPurchases)
      mapOfPurchases.get(purchase.storeNumber) match {
        case None => mapOfPurchases.put(purchase.storeNumber, List(purchase))
        case Some(existing: List[Purchase]) => 
          mapOfPurchases.put(purchase.storeNumber, (purchase :: existing))
      }

    mapOfPurchases.toMap
  }

  def time[R](block: => R): R = {
    val start = System.nanoTime
    val result = block
    val end = System.nanoTime
    val elapsedTimeMs = (end - start) * 0.000001
    println("Elapsed time: %.3f msecs".format(elapsedTimeMs))
    result
  }

  def timeRuns[R](block: => R, count: Int) =
    for (_ <- Range(0, count)) time { block }

  def testImmutable(count: Int): IndexedSeq[Int] = {
    var v = Vector[Int]()
    for (c <- Range(0, count))
      v = v :+ c
    v
  }

  def testMutable(count: Int): IndexedSeq[Int] = {
    val s = ArrayBuffer[Int](count)
    for (c <- Range(0, count))
      s.append(c)
    s.toIndexedSeq
  }

  val oneMillion = 1000000

  def testMutableNoConversion(count: Int): IndexedSeq[Int] = {
    val s = ArrayBuffer[Int](count)
    for (c <- Range(0, count))
      s.append(c)
    s
  }
}