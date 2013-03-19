/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.config.salary;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;  
import java.sql.*;
import java.io.*;
import include.nseer_db.*;

public class payType_change_ok extends HttpServlet{
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

nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String type_name=request.getParameter("type_name");
String sqll="select * from hr_config_public_char where kind='发放方式'";
ResultSet rs=hr_db.executeQuery(sqll);
if(rs.next()){
	String sql2="update hr_config_public_char set type_name='"+type_name+"' where kind='发放方式'";
	hr_db.executeUpdate(sql2);
	if(type_name.equals("按I级机构发放")){
		String sql3="update hr_config_file_first_kind set pay_salary_tag='0'";
		hr_db.executeUpdate(sql3);
	}
	

response.sendRedirect("hr/config/salary/payType_change_ok_a.jsp");


}else{
      String sql = "insert into hr_config_public_char(kind,type_name) values('发放方式','"+type_name+"')" ;
    	hr_db.executeUpdate(sql) ;
		if(type_name.equals("按I级机构发放")){
		String sql3="update hr_config_file_first_kind set pay_salary_tag='0'";
		hr_db.executeUpdate(sql3);
	}
		

response.sendRedirect("hr/config/salary/payType_change_ok_b.jsp");

}
hr_db.commit();
hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){}
}
}
