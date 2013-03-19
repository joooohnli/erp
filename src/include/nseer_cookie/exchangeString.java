/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.nseer_cookie;

import java.util.StringTokenizer;

public class exchangeString {

	public String[] ex(String[] ss, String code) {
		String[] s = new String[ss.length];
		for (int i = 0; i < ss.length; i++) {
			s[i] = "";
			StringTokenizer tokenTO = new StringTokenizer(ss[i], code);
			while (tokenTO.hasMoreTokens()) {
				String ss1 = tokenTO.nextToken();
				s[i] = s[i] + ss1;
			}
		}
		return s;
	}

	public static void main(String[] args) {
		exchangeString ex = new exchangeString();
		String[] b = { "12,345", "1,2,34,6" };
		String[] a = ex.ex(b, ",");
		for (int i = 0; i < a.length; i++) {
			System.out.println(a[i] + "\n");
		}
	}
}