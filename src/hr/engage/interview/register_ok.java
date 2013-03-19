/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.engage.interview;


import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;  
import java.util.*;
import java.io.*;
import include.nseer_cookie.exchange;
import include.nseer_db.*;
import include.nseer_cookie.counter;

public class register_ok extends HttpServlet{
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
counter count= new counter(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String major_first_kind_ID="";
String major_first_kind_name="";
String major_second_kind_ID="";
String major_second_kind_name="";
String major_first_kind=request.getParameter("select4");
StringTokenizer tokenTO4 = new StringTokenizer(major_first_kind,"/");        
	while(tokenTO4.hasMoreTokens()) {
        major_first_kind_ID = tokenTO4.nextToken();
		major_first_kind_name = tokenTO4.nextToken();
		}
String major_second_kind=request.getParameter("select5");
StringTokenizer tokenTO5 = new StringTokenizer(major_second_kind,"/");        
	while(tokenTO5.hasMoreTokens()) {
        major_second_kind_ID = tokenTO5.nextToken();
		major_second_kind_name = tokenTO5.nextToken();
		}
String details_number=request.getParameter("details_number") ;
String human_name=request.getParameter("human_name") ;
String image_degree=request.getParameter("image_degree") ;
String interview_amount=request.getParameter("interview_amount") ;
String native_language_degree=request.getParameter("native_language_degree") ;
String foreign_language_degree=request.getParameter("foreign_language_degree") ;
String response_speed_degree=request.getParameter("response_speed_degree") ;
String EQ_degree=request.getParameter("EQ_degree") ;
String IQ_degree=request.getParameter("IQ_degree") ;
String multi_quality_degree=request.getParameter("multi_quality_degree") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
try{
	String sql = "insert into hr_interview(details_number,human_name,human_major_first_kind_ID,human_major_first_kind_name,human_major_second_kind_ID,human_major_second_kind_name,image_degree,native_language_degree,foreign_language_degree,response_speed_degree,EQ_degree,IQ_degree,multi_quality_degree,register,register_time,interview_amount,remark) values ('"+details_number+"','"+human_name+"','"+major_first_kind_ID+"','"+major_first_kind_name+"','"+major_second_kind_ID+"','"+major_second_kind_name+"','"+image_degree+"','"+native_language_degree+"','"+foreign_language_degree+"','"+response_speed_degree+"','"+EQ_degree+"','"+IQ_degree+"','"+multi_quality_degree+"','"+register+"','"+register_time+"','"+interview_amount+"','"+remark+"')" ;
	hr_db.executeUpdate(sql) ;
	hr_db.commit();
	hr_db.close();


response.sendRedirect("hr/engage/interview/register_ok_a.jsp");
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}