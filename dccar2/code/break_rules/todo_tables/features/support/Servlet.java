/***
 * Excerpted from "Build Awesome Command-Line Applications in Ruby 2",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dccar2 for more book information.
***/
package com.example.web.app.wtf.is.going.on;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.GenericServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyServlet extends GenericServlet 
{
    public void service(HttpServletRequest request, HttpServletResponse response) 
        throws IOException, ServletException 
    {
        response.getWriter().println("<h1>Hi!</h1>");
        if (getUser().getName().getFirst() != null) 
        {
            response.getWriter().println("Hi, " + getUser().getName().getFirst());
        }
        else 
        {
            response.getWriter().println("Greetings Mr. " + getUser().getName().getLast());
        }
    }
}


