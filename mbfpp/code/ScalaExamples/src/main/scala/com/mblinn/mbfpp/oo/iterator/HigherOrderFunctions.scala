package com.mblinn.mbfpp.oo.iterator

object HigherOrderFunctions {

  def sumSequence(sequence : Seq[Int]) =
    if(sequence.isEmpty) 0 else sequence.reduce((acc, curr) => acc + curr)
  
  def prependHello(names : Seq[String]) =
    names.map((name) => "Hello, " + name)
    
  val isVowel = Set('a', 'e', 'i', 'o', 'u')
  def vowelsInWord(word: String) = word.filter(isVowel).toSet
    
}