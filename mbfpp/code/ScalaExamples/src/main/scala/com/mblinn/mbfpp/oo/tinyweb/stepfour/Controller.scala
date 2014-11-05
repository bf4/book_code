package com.mblinn.mbfpp.oo.tinyweb.stepfour
import com.mblinn.oo.tinyweb.ControllerException
import com.mblinn.oo.tinyweb.RenderingException

trait Controller {
  def handleRequest(httpRequest: HttpRequest): HttpResponse
}

class FunctionController(view: View, doRequest: (HttpRequest) => 
  Map[String, List[String]] ) extends Controller {
  
  def handleRequest(request: HttpRequest): HttpResponse =  
    try {
      val model = doRequest(request)
      val responseBody = view.render(model)
      HttpResponse(responseBody, 200)
    } catch {
      case e: ControllerException => 
        HttpResponse("", e.getStatusCode)
      case e: RenderingException => 
        HttpResponse("Exception while rendering.", 500)
      case e: Exception => 
        HttpResponse("", 500)
    }

}