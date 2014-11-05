package com.mblinn.mbfpp.oo.tm
import scala.collection.immutable.SortedMap
import scala.collection.immutable.TreeMap

object GradeReporter {

  def makeGradeReporter(
    numToLetter: (Double) => String,
    printGradeReport: (Seq[String]) => Unit) = (grades: Seq[Double]) => {
      printGradeReport(grades.map(numToLetter))
  }

  def fullGradeConverter(grade: Double) = 
    if(grade <= 5.0 && grade > 4.0) "A"
    else if(grade <= 4.0 && grade > 3.0) "B"
    else if(grade <= 3.0 && grade > 2.0) "C"
    else if(grade <= 2.0 && grade > 0.0) "D"
    else if(grade == 0.0) "F"
    else "N/A"
  
  def printHistogram(grades: Seq[String]) = {
    val grouped = grades.groupBy(identity)
    val counts = grouped.map((kv) => (kv._1, kv._2.size)).toSeq.sorted
    for(count <- counts) {
      val stars = "*" * count._2
      println("%s: %s".format(count._1, stars))
    }
  }
  
  val sampleGrades = Vector(5.0, 4.0, 4.4, 2.2, 3.3, 3.5)
  
  val fullGradeReporter = makeGradeReporter(fullGradeConverter, printHistogram)
  
  def plusMinusGradeConverter(grade: Double) = 
    if(grade <= 5.0 && grade > 4.7) "A"
      else if(grade <= 4.7 && grade > 4.3) "A-"
	  else if(grade <= 4.3 && grade > 4.0) "B+"
	  else if(grade <= 4.0 && grade > 3.7) "B"
	  else if(grade <= 3.7 && grade > 3.3) "B-"
	  else if(grade <= 3.3 && grade > 3.0) "C+"
	  else if(grade <= 3.0 && grade > 2.7) "C"
	  else if(grade <= 2.7 && grade > 2.3) "C-"
	  else if(grade <= 2.3 && grade > 0.0) "D"
	  else if(grade == 0.0) "F"
	  else "N/A"
	    
  def printAllGrades(grades: Seq[String]) = 
    for(grade <- grades) println("Grade is: " + grade)
    
  val plusMinusGradeReporter = 
    makeGradeReporter(plusMinusGradeConverter, printAllGrades)
}