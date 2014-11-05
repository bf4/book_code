package com.mblinn.mbfpp.oo.tinyweb.stepfour
class TinyWeb(controllers: Map[String, Controller], 
    filters: List[(HttpRequest) => HttpRequest]) {
  
  def handleRequest(httpRequest: HttpRequest): Option[HttpResponse] = {
    val composedFilter = filters.reverse.reduceLeft(
        (composed, next) => composed compose next)
    val filteredRequest = composedFilter(httpRequest)
    val controllerOption = controllers.get(filteredRequest.path)
    controllerOption map { controller => controller.handleRequest(filteredRequest) } 
  }
}