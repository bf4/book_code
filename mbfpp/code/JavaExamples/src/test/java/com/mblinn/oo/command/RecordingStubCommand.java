/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.oo.command;

import com.mblinn.mbfpp.oo.command.Command;

public class RecordingStubCommand implements Command {

	public boolean wasExecuted = false;
	
	@Override
	public void execute() {
		wasExecuted = true;
	}

}
