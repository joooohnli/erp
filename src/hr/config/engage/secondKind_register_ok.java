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
import java.util.*;
import java.io.* ;
import include.nseer_db.*;


public class secondKind_register_ok extends HttpServlet{
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
String first_kind_ID="";
String first_kind_name="";
String first_kind=request.getParameter("first_kind");
StringTokenizer tokenTO = new StringTokenizer(first_kind,"/");        
	while(tokenTO.hasMoreTokens()) {
        first_kind_ID = tokenTO.nextToken();
		first_kind_name = tokenTO.nextToken();
		}
String second_kind_name=request.getParameter("second_kind_name");
String sqll="select * from hr_config_question_second_kind where first_kind_ID='"+first_kind_ID+"' and first_kind_name='"+first_kind_name+"' and second_kind_name='"+second_kind_name+"'";
ResultSet rs=hr_db.executeQuery(sqll);
if(rs.next()){


	response.sendRedirect("hr/config/engage/secondKind_register_ok_b.jsp");

}else{
	String second_kind_ID="";
	String sql2="select * from hr_config_question_second_kind where first_kind_ID='"+first_kind_ID+"' and first_kind_name='"+first_kind_name+"' order by second_kind_ID desc";
	ResultSet rs2=hr_db.executeQuery(sql2);
	if(rs2.next()){
	String aaa=rs2.getString("second_kind_ID");
	if(aaa.equals(" ")){
	aaa=rs2.getString("second_kind_ID");
	}else{
	aaa=rs2.getString("second_kind_ID");
	}
	int code1=Integer.parseInt(aaa);
	code1=code1-1;
	second_kind_ID=((code1+100)+"").substring(1);
	int code2=code1+1;
	code1=code1+2;
	String sql3="update hr_config_question_second_kind set second_kind_ID='"+code1+"' where first_kind_ID='"+first_kind_ID+"' and first_kind_name='"+first_kind_name+"' and  second_kind_ID='"+code2+"'";
	hr_db.executeUpdate(sql3) ;
	}
      String sql = "insert into hr_config_question_second_kind(first_kind_ID,first_kind_name,second_kind_ID,second_kind_name) values('"+first_kind_ID+"','"+first_kind_name+"','"+second_kind_ID+"','"+second_kind_name+"')" ;
    	hr_db.executeUpdate(sql) ;
		

response.sendRedirect("hr/config/engage/secondKind_register_ok_a.jsp");

}
hr_db.commit();
hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}