/***
 * Excerpted from "Functional Programming Patterns",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mbfpp for more book information.
***/
package com.mblinn.mbfpp.oo.tm;

import java.util.Arrays;
import java.util.List;

public class PlusMinusGradeReporter extends GradeReporterTemplate {
	@Override
	protected String numToLetter(Double grade) {
		if (grade <= 5.0 && grade > 4.7)
			return "A";
		else if (grade <= 4.7 && grade > 4.3)
			return "A-";
		else if (grade <= 4.3 && grade > 4.0)
			return "B+";
		else if (grade <= 4.0 && grade > 3.7)
			return "B";
		else if (grade <= 3.7 && grade > 3.3)
			return "B-";
		else if (grade <= 3.3 && grade > 3.0)
			return "C+";
		else if (grade <= 3.0 && grade > 2.7)
			return "C";
		else if (grade <= 2.7 && grade > 2.3)
			return "C-";
		else if (grade <= 2.3 && grade > 0.0)
			return "D";
		else if (grade == 0.0)
			return "F";
		else
			return "N/A";
	}


	@Override
	protected void printGradeReport(List<String> grades) {
		for (String grade : grades) {
			System.out.println("Grade is: " + grade);
		}
	}


	public static void main(String[] args) {
		GradeReporterTemplate gradeReporter = new PlusMinusGradeReporter();
		List<Double> grades = Arrays.asList(new Double[] { 5.0, 4.0, 4.4, 2.2, 3.3,
		    3.5 });
		gradeReporter.reportGrades(grades);
	}
}
