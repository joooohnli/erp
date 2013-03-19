/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.reports;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class tableb_save extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);

try{

if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
		String report_unit=request.getParameter("report_unit");
		String account_period=request.getParameter("account_period");
		String item_year30=request.getParameter("profit");       
		String sql1="delete from finance_report_02 where account_period='"+account_period+"'";
		finance_db.executeUpdate(sql1);
		String sql="insert into finance_report_02(report_unit,account_period,item_year30) values('"+report_unit+"','"+account_period+"','"+item_year30+"')";
		finance_db.executeUpdate(sql);
		finance_db.commit();
		finance_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}