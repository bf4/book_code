package com.mblinn.mbfpp.oo.tinyweb.steptwo

import com.mblinn.oo.tinyweb.HttpRequest
import com.mblinn.oo.tinyweb.HttpResponse
import com.mblinn.oo.tinyweb.ControllerException
import com.mblinn.oo.tinyweb.RenderingException

trait Controller {
  def handleRequest(httpRequest: HttpRequest): HttpResponse
}

class FunctionController(view: View, doRequest: (HttpRequest) => 
  Map[String, List[String]] ) extends Controller {
  
  def handleRequest(request: HttpRequest): HttpResponse = {
    var responseCode = 200;
    var responseBody = "";
    
    try {
      val model = doRequest(request)
      responseBody = view.render(model)
    } catch {
      case e: ControllerException => 
        responseCode = e.getStatusCode()
      case e: RenderingException =>
        responseCode = 500
        responseBody = "Exception while rendering."
      case e: Exception =>
        responseCode = 500
    }
    
    HttpResponse.Builder.newBuilder()
		    .body(responseBody).responseCode(responseCode).build()
  }
}