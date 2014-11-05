package com.mblinn.mbfpp.functional.dsl
import scala.io.Source
import java.lang.Process
import scala.collection.JavaConversions._
import scala.language.postfixOps

object Example {
  case class CommandResult(status: Int, output: String, error: String)

  class Command(commandParts: List[String]) {
    def run() = {
      val processBuilder = new ProcessBuilder(commandParts)
      val process = processBuilder.start()
      val status = process.waitFor()
      val outputAsString =
        Source.fromInputStream(process.getInputStream()).mkString("")
      val errorAsString =
        Source.fromInputStream(process.getErrorStream()).mkString("")
      CommandResult(status, outputAsString, errorAsString)
    }
  }

  object Command {
    def apply(commandString: String) = new Command(commandString.split("\\s").toList)
  }

  implicit class CommandString(commandString: String) {
    def run() = Command(commandString).run
  }
}

object ExtendedExample {
  case class CommandResult(status: Int, output: String, error: String)

  class Command(commandParts: List[String]) {
    def run = {
      val processBuilder = new ProcessBuilder(commandParts)
      val process = processBuilder.start()
      val status = process.waitFor()
      val outputAsString = Source.fromInputStream(process.getInputStream()).mkString("");
      val errorAsString = Source.fromInputStream(process.getErrorStream()).mkString("");
      CommandResult(status, outputAsString, errorAsString)
    }

  }

  implicit class CommandVector(existingCommands: Vector[String]) {
    def run = {
      val pipedCommands = existingCommands.mkString(" | ")
      Command("/bin/sh", "-c", pipedCommands).run
    }
    def pipe(nextCommand: String): Vector[String] = {
      existingCommands :+ nextCommand
    }
  }
  object Command {
    def apply(commandString: String) = new Command(commandString.split("\\s").toList)
    def apply(commandParts: String*) = new Command(commandParts.toList)
  }

  implicit class CommandString(firstCommandString: String) {
    def run = Command(firstCommandString).run
    def pipe(secondCommandString: String) =
      Vector(firstCommandString, secondCommandString)
  }
}
