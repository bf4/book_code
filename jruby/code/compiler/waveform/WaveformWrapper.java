/***
 * Excerpted from "Using JRuby",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
***/
import org.jruby.embed.ScriptingContainer;

public class WaveformWrapper {
    static ScriptingContainer rubyContainer;
    Object waveform;

    static {
        rubyContainer = new ScriptingContainer();
        rubyContainer.runScriptlet("require 'waveform'");
    }

    public WaveformWrapper(double[] points) {
        Object waveformClass = rubyContainer.runScriptlet("Waveform");
        waveform = rubyContainer.callMethod(waveformClass, "new", points);
    }

    public double rms() {
        return (Double)rubyContainer.callMethod(waveform, "rms");
    }
}
