/***
 * Excerpted from "Using JRuby",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
***/

import org.jruby.embed.ScriptingContainer;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestResult;

public class TestUnitSuite implements Test {
    private void runTestCasesIn(ScriptingContainer runtime, TestResult result) {
        Object junit_adapter = runtime.runScriptlet("JUnitAdapter");
        Object instance = runtime.callMethod(junit_adapter, "new", result);
        runtime.callMethod(instance, "run_tests");
    }

    public int countTestCases() {
        return -1;
    }

    public void run(TestResult result) {
        ScriptingContainer runtime = new ScriptingContainer();
        runtime.runScriptlet("require 'test_unit_junit'");

        Object junit_class    = runtime.runScriptlet("JUnitAdapter");
        Object junit_instance = runtime.callMethod(junit_class, "new", result);
        runtime.callMethod(junit_instance, "run_tests");
    }

    public static Test suite() {
        return new TestUnitSuite();
    }
}
