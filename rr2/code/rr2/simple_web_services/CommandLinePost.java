/***
 * Excerpted from "Rails Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
***/
import java.io.BufferedReader;
import java.net.URLConnection;
import java.net.URL;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
public class CommandLinePost {

  private static void usage()
  {
    System.err.println("usage: java CommandLinePost <url>");
    System.exit(1);
  }
  
  public static void main(String args[])        
  {
    if(args.length > 2)
        usage();
    String endPoint = args[0];
    try {
        String data = "<contact>" + 
                      "<name>Kurt Weill</name>" +
                      "<phone>501-555-2222</phone>" +
                      "</contact>";
        
        URL url = new URL(endPoint);
        URLConnection conn = url.openConnection();
        conn.setRequestProperty("Content-Type", "application/xml");
        conn.setDoOutput(true);
        OutputStreamWriter wr = 
               new OutputStreamWriter(conn.getOutputStream());
        wr.write(data);
        wr.flush();
        
        BufferedReader rd = 
            new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String line;
        while ((line = rd.readLine()) != null) {
            // Imagine this was putting the data back into a legacy
            // Java system.  For simplicity's sake, we'll just print
            // it here.
            System.out.println(line);
        }
        wr.close();
        rd.close();
    } catch (Exception e) {
        e.printStackTrace();
    }   
  }
}
