/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.tree_index;

import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class businessComment {
	private String ab;
	private String aa;
	private String mo;
	private String path = "";
	private String value = "";
	private ServletContext context;
	private HttpSession session;
	private String unit_db_name;

	public void setPath(HttpServletRequest request) {
		session = request.getSession();
		context = session.getServletContext();
		String path1 = context.getRealPath("/");
		StringTokenizer tokenTO1 = new StringTokenizer(path1, "\\");
		while (tokenTO1.hasMoreTokens()) {
			path = path + tokenTO1.nextToken() + "/";
			unit_db_name = (String) session.getAttribute("unit_db_name");
			if (unit_db_name == null)
				unit_db_name = "ondemand1";
		}
	}

	public String getDbName() {
		return this.unit_db_name;
	}

	public HttpSession getSession() {
		return this.session;
	}

	public String businessComment(String url, String base, String table_name,
			String field_name, String field_name1) {
		BusFirst bf = new BusFirst();
		ab = bf.businessComment(url, base, table_name, field_name, field_name1,
				unit_db_name);
		return ab;
	}

	public String getLang(String tablename, String column) {
		BusSencond bs = new BusSencond();
		value = bs.getLang(tablename, column, unit_db_name, session, context);
		return value;
	}

	public String aformat(double sum) {
		String result = new java.text.DecimalFormat((String) context
				.getAttribute("nseerPrecision")).format(sum);
		return result;
	}

	public String qformat(double sum) {
		String result = new java.text.DecimalFormat((String) context
				.getAttribute("nseerAmountPrecision")).format(sum);
		return result;
	}

}
