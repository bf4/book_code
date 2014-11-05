package com.mblinn.mbfpp.functional.fb

object ScalaExamples {

  val appendA = (s: String) => s + "a"
  val appendB = (s: String) => s + "b"
  val appendC = (s: String) => s + "c"
  
  val appendCBA = appendA compose appendB compose appendC
  
  case class HttpRequest(
      headers: Map[String, String], 
      payload: String, 
      principal: Option[String] = None)
  
  def checkAuthorization(request: HttpRequest) = {
    val authHeader = request.headers.get("Authorization")
    val mockPrincipal = authHeader match {
      case Some(headerValue) => Some("AUser")
      case _ => None
    }
    request.copy(principal = mockPrincipal)
  }
  def logFingerprint(request: HttpRequest) = {
    val fingerprint = request.headers.getOrElse("X-RequestFingerprint", "")
    println("FINGERPRINT=" + fingerprint)
    request
  }
  
  def composeFilters(filters: Seq[Function1[HttpRequest, HttpRequest]]) =
    filters.reduce { 
      (allFilters, currentFilter) => allFilters compose currentFilter
    }

}