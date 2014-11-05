package com.mblinn.mbfpp.oo.javabean

class Person(
    val firstName: String, 
    val middleName: String, 
    val lastName: String)

class PersonWithDefault(
    val firstName: String, 
    val middleName: String = "", 
    val lastName: String)

case class PersonCaseClass(
    firstName: String,
    middleName: String = "",
    lastName: String)
