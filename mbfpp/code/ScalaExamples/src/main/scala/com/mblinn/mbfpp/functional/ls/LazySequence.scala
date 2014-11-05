package com.mblinn.mbfpp.functional.ls

import scala.collection.immutable.Stream._
import scala.util.Random

object LazySequence {

  val integers = Stream.from(0)

  val generate = new Random()
  val randoms = Stream.continually(generate.nextInt)

  def pagedSequence(pageNum: Int): Stream[String] =
    getPage(pageNum) match {
      case Some(page: String) => page #:: pagedSequence(pageNum + 1)
      case None => Stream.Empty
    }

  def getPage(page: Int) =
    page match {
      case 1 => Some("Page1")
      case 2 => Some("Page2")
      case 3 => Some("Page3")
      case _ => None
    }

  val holdsHead = {
    def pagedSequence(pageNum: Int): Stream[String] =
      getPage(pageNum) match {
        case Some(page: String) => {
          println("Realizing " + page)
          page #:: pagedSequence(pageNum + 1)
        }
        case None => Stream.Empty
      }
    pagedSequence(1)
  }

  def doesntHoldHead = {
    def pagedSequence(pageNum: Int): Stream[String] =
      getPage(pageNum) match {
        case Some(page: String) => {
          println("Realizing " + page)
          page #:: pagedSequence(pageNum + 1)
        }
        case None => Stream.Empty
      }
    pagedSequence(1)
  }

  val printHellos = Stream.continually(println("hello"))
  
  val aStream = "foo" #:: "bar" #:: Stream[String]()

}