/***
 * Excerpted from "Using JRuby",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
***/
package book.embed;

import java.lang.ClassNotFoundException;
import java.lang.IllegalAccessException;
import java.lang.NoSuchMethodException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.List;
import org.jruby.embed.ScriptingContainer;

public class Historian9 {
    public static void main(String[] args)
        throws ClassNotFoundException, NoSuchMethodException,
               IllegalAccessException, InvocationTargetException {
        ScriptingContainer container = new ScriptingContainer();
        container.setLoadPaths(Arrays.asList("lib"));
        container.runScriptlet("require 'archive9'");

        Object archive = container.runScriptlet("Archive.new");

        List files = (List)
            container.callMethod(archive,
                                 "history",
                                 new Revisions(args[0], args[1]));

        Method getPath  = null;
        Method getPatch = null;

        for (Object file: files) {
            if (getPath == null || getPatch == null) {
                Class gitDiff = file.getClass();
                getPath  = gitDiff.getMethod("path");
                getPatch = gitDiff.getMethod("patch");
            }

            System.out.println("FILE: " + getPath.invoke(file));
            System.out.println(getPatch.invoke(file));
        }
    }
}
