/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.config.engage;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.counter;


public class firstKind_register_ok extends HttpServlet{
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
counter count= new  counter(dbApplication);

String first_kind_ID=request.getParameter("first_kind_ID");
String first_kind_name=request.getParameter("first_kind_name");
String sqll="select * from hr_config_question_first_kind where first_kind_ID='"+first_kind_ID+"' or first_kind_name='"+first_kind_name+"'";
ResultSet rs=hr_db.executeQuery(sqll);
if(rs.next()){
	

response.sendRedirect("hr/config/engage/firstKind_register_ok_a.jsp");

}else{
 String sql = "insert into hr_config_question_first_kind(first_kind_ID,first_kind_name) values('"+first_kind_ID+"','"+first_kind_name+"')" ;
    	hr_db.executeUpdate(sql) ;
		String sql2="insert into hr_config_question_second_kind(first_kind_ID,first_kind_name,second_kind_ID) values('"+first_kind_ID+"','"+first_kind_name+"','2')";
	  hr_db.executeUpdate(sql2) ;
	  
int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"hrquestionfirstkindcount");

count.write((String)dbSession.getAttribute("unit_db_name"),"hrquestionfirstkindcount",filenum);


response.sendRedirect("hr/config/engage/firstKind_register_ok_b.jsp");

}
hr_db.commit();
hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}
