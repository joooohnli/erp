/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package fund.config.fund;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.io.*;
import include.nseer_db.*;

public class currencyType_register_ok extends HttpServlet{
//创建方法

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


try{

HttpSession session=request.getSession();
PrintWriter out=response.getWriter();
nseer_db_backup1 fund_db = new nseer_db_backup1(dbApplication);

if(fund_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String currency_ID=request.getParameter("currency_ID");
String currency_name=request.getParameter("currency_name");
String personal_unit=request.getParameter("personal_unit");
String sqll="select * from fund_config_fund_currency where currency_ID='"+currency_ID+"' or currency_name='"+currency_name+"'";
ResultSet rs=fund_db.executeQuery(sqll);
if(rs.next()){

	response.sendRedirect("fund/config/fund/currencyType_register_ok_a.jsp");

}else{
      String sql = "insert into fund_config_fund_currency(currency_ID,currency_name,personal_unit) values('"+currency_ID+"','"+currency_name+"','"+personal_unit+"')" ;
    	fund_db.executeUpdate(sql) ;
		

	
 response.sendRedirect("fund/config/fund/currencyType_register_ok_b.jsp");

	
	}
	fund_db.commit();
	fund_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}