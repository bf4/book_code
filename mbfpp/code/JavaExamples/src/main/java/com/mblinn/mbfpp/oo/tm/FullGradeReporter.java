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
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

public class FullGradeReporter extends GradeReporterTemplate {
	@Override
	public String numToLetter(Double grade) {
		if (grade <= 5.0 && grade > 4.0)
			return "A";
		else if (grade <= 4.0 && grade > 3.0)
			return "B";
		else if (grade <= 3.0 && grade > 2.0)
			return "C";
		else if (grade <= 2.0 && grade > 0.0)
			return "D";
		else if (grade == 0.0)
			return "F";
		else
			return "N/A";
	}


	@Override
	protected void printGradeReport(List<String> grades) {
		SortedMap<String, Integer> gradeCounts = new TreeMap<String, Integer>();

		for (String grade : grades) {
			Integer currentGradeCount = gradeCounts.get(grade);
			if (null == currentGradeCount)
				gradeCounts.put(grade, 1);
			else
				gradeCounts.put(grade, currentGradeCount + 1);
		}

		for (Map.Entry<String, Integer> gradeCount : gradeCounts.entrySet()) {
			StringBuffer bar = new StringBuffer();
			for (int i = 0; i < gradeCount.getValue(); i++)
				bar.append("*");
			System.out.printf("%s: %s\n", gradeCount.getKey(), bar);
		}
	}


	public static void main(String[] args) {
		GradeReporterTemplate gradeReporter = new FullGradeReporter();
		List<Double> grades = Arrays.asList(new Double[] { 5.0, 4.0, 4.4, 2.2, 3.3,
		    3.5 });
		gradeReporter.reportGrades(grades);
	}
}
