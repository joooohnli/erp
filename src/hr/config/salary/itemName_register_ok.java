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

public class itemName_register_ok extends HttpServlet{
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
nseer_db_backup1 hrdb = new nseer_db_backup1(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hrdb.conn((String)dbSession.getAttribute("unit_db_name"))){


String type_name=request.getParameter("type_name");
String sqll="select * from hr_config_public_char where kind='薪酬项目' and type_name='"+type_name+"'";
ResultSet rs=hr_db.executeQuery(sqll);
if(rs.next()){
response.sendRedirect("hr/config/salary/itemName_register_ok_a.jsp");


}else{
    String sql = "insert into hr_config_public_char(kind,type_name) values('薪酬项目','"+type_name+"')" ;
    hr_db.executeUpdate(sql) ;
	String sql2="select * from hr_salary_standard";
	ResultSet rs2=hrdb.executeQuery(sql2) ;
	while(rs2.next()){
		String sql3="select * from hr_salary_standard_details where standard_ID='"+rs2.getString("standard_ID")+"' order by details_number desc";
		ResultSet rs3=hr_db.executeQuery(sql3) ;
		if(rs3.next()){
			int details_number=rs3.getInt("details_number")+1;
			String sql4="insert into hr_salary_standard_details(standard_ID,standard_name,details_number,item_name,salary) values('"+rs2.getString("standard_ID")+"','"+rs2.getString("standard_name")+"','"+details_number+"','"+type_name+"','0')";
			hr_db.executeUpdate(sql4) ;
		}
	}


response.sendRedirect("hr/config/salary/itemName_register_ok_b.jsp");

}
hr_db.commit();
hrdb.commit();
hrdb.close();
hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}

