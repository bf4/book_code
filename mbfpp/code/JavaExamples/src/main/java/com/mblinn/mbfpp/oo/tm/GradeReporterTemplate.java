/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.mbfpp.oo.tm;

import java.util.ArrayList;
import java.util.List;

public abstract class GradeReporterTemplate {

	public void reportGrades(List<Double> grades) {
		List<String> convertedGrades = new ArrayList<String>();
		for (Double grade : grades) {
			convertedGrades.add(numToLetter(grade));
		}
		printGradeReport(convertedGrades);
	}

	protected abstract String numToLetter(Double grade);

	protected abstract void printGradeReport(List<String> grades);
}
