/***
 * Excerpted from "Using JRuby",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
***/
package book.embed;

import java.util.Arrays;
import java.util.List;
import org.jruby.embed.ScriptingContainer;

public class Historian6 {
    public static void main(String[] args) {
        ScriptingContainer container = new ScriptingContainer();
        container.setLoadPaths(Arrays.asList("lib"));
        container.runScriptlet("require 'archive6'");

        Object archive = container.runScriptlet("Archive.new");

        List<GitDiff> files = (List<GitDiff>)
            container.callMethod(archive,
                                 "history",
                                 new Revisions(args[0], args[1]));

        for (GitDiff file: files) {
            System.out.println("FILE: " + file.getPath());
            System.out.println(file.getPatch());
        }
    }
}
