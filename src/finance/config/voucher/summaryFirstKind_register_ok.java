/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.config.voucher;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;

import include.nseer_db.*;

public class summaryFirstKind_register_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
PrintWriter out=response.getWriter();
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
try{
if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String nick_name=request.getParameter("nick_name");
String summary=request.getParameter("summary");

String sql="select nick_name from finance_config_summary where nick_name='"+nick_name+"'";
ResultSet rs=finance_db.executeQuery(sql);
		if(rs.next()){
			out.println("1");
		}else{
			sql = "insert into finance_config_summary(nick_name,name) values('"+nick_name+"','"+summary+"')";
			finance_db.executeUpdate(sql);
			out.println("0");
		}

finance_db.commit();
finance_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
	catch (Exception ex) {
		ex.printStackTrace();
	}
}
}