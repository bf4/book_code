/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package test.book.glass;

import java.io.IOException;
import java.io.StringWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public final class ViewUtils
{
  public static String render(ServletContext ctx, String template, Object data)
      throws IOException, ServletException
  {
    Configuration config = new Configuration();
    config.setServletContextForTemplateLoading(ctx, "WEB-INF/views");
    config.setDefaultEncoding("UTF-8");
    Template ftl = config.getTemplate(template);
    try {
      // use the data to render the template to the servlet output
      StringWriter writer = new StringWriter();
      ftl.process(data, writer);
      return writer.toString();
    }
    catch (TemplateException e) {
      throw new ServletException("Problem while processing template", e);
    }
  }

  public static int getPage( HttpServletRequest req )
  {
    String pageStr = req.getParameter("page");
    int pageNum = 1;
    try {
      pageNum = Integer.parseInt( pageStr );
    } catch(NumberFormatException e) {
    }
    return pageNum;
  }

  public static String extractFromPath( HttpServletRequest req )
  {
    String nickname = req.getPathInfo();
    if( nickname == null ) nickname = "";
    return nickname.substring( nickname.indexOf('/') + 1 );
  }
}
