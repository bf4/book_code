/***
 * Excerpted from "Using JRuby",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
***/
package book.embed;

import java.lang.NoSuchMethodException;

import java.util.List;

import javax.script.Invocable;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;

public class Historian8 {
    public static void main(String[] args)
        throws ScriptException, NoSuchMethodException {

        ScriptEngineManager manager = new ScriptEngineManager();
        ScriptEngine engine = manager.getEngineByName("jruby");
        Invocable invocable = (Invocable)engine;

        engine.eval("$LOAD_PATH << 'lib'");
        engine.eval("require 'archive8'");

        Object archive = engine.eval("Archive.new");

        List<GitDiff> diffs = (List<GitDiff>)
            invocable.invokeMethod(archive,
                                   "history",
                                   new Revisions(args[0], args[1]));

        for (GitDiff diff : diffs) {
            System.out.println("FILE: " + diff.getPath());
            System.out.println(diff.getPatch());
        }
    }
}
