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

public class executeMethod_register_ok extends HttpServlet{
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

String type_name=request.getParameter("type_name");
String sqll="select * from fund_config_public_char where kind='收付款方式' and type_name='"+type_name+"'";
ResultSet rs=fund_db.executeQuery(sqll);
if(rs.next()){

	response.sendRedirect("fund/config/fund/executeMethod_register_ok_a.jsp");

	}else{
      String sql = "insert into fund_config_public_char(kind,type_name) values('收付款方式','"+type_name+"')" ;
    	fund_db.executeUpdate(sql) ;
		

response.sendRedirect("fund/config/fund/executeMethod_register_ok_b.jsp");

}
fund_db.commit();
fund_db.close();

}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}