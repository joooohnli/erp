/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.config.account_init;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import java.io.*;
import java.text.*;
import include.nseer_db.*;

public class registerTime_ok extends HttpServlet {

	public synchronized void service(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		PageContext pageContext = _jspxFactory.getPageContext(this, request,
				response, "", true, 8192, true);
		ServletContext dbApplication = dbSession.getServletContext();
		nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
		try {

			if (finance_db
					.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String nyear = request.getParameter("nyear");
				String period1 = request.getParameter("period");
				String year = request.getParameter("year");
				String month = request.getParameter("month");
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				int i = 0;
				period1 = period1.substring(0, period1.length() - 1);				
				StringTokenizer tokenTO = new StringTokenizer(period1, "☉");
				String[] period = new String[tokenTO.countTokens()];
				while (tokenTO.hasMoreTokens()) {
					period[i] = tokenTO.nextToken();
					i++;
				}
				i = 1;
				String sql = "insert into finance_config_public_char(kind,type_name) values('账务初始时间','"
						+ nyear + "')";
				finance_db.executeUpdate(sql);
				int tag = 0;
				java.util.Date date = formatter.parse(nyear);
				long start_time=date.getTime();
				long time=0;
				for (int j = 0; j < 24; j += 2) {
					time=formatter.parse(period[j+1]).getTime();
					if (start_time > time) {
						tag = 1;
					} else {
						tag = 0;
					}
					sql = "insert into finance_account_period(account_period,start_time,end_time,account_finished_tag) values('"
							+ i
							+ "','"
							+ period[j]
							+ "','"
							+ period[j + 1]
							+ "','" + tag + "')";
					finance_db.executeUpdate(sql);
					i++;
				}
				response.sendRedirect("finance/config/account_init/registerTime_ok_a.jsp");
				finance_db.commit();
				finance_db.close();
			} else {
				response.sendRedirect("error_conn.htm");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}