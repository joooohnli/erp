/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.calculator;
//实际中运用的类
public class CCalculator {
	private String command=null;

	public CCalculator(String command) {
	  this.command=command;
	}

	public double value() {
	  command=new MidToPost(command).execute();
	  return (new SimpleCalculator(command).evaluate());
	}

	public static void main(String[] args) {
	  CCalculator calculator=new CCalculator("( 9.76  +   0.3 ） * 3.00 + 4 * 3 - （ 5 + 4 ) / 0.9");
	}
}
