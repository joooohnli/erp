/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.engage.pass;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*; 
import java.sql.*;
import java.io.*;
import include.nseer_db.*;
import include.nseer_cookie.counter;


public class query_ok extends HttpServlet{
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
counter count= new  counter(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String details_number=request.getParameter("details_number");
String register_time=request.getParameter("register_time") ;
String register=request.getParameter("register") ;
int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"hrFilecount");
count.write((String)dbSession.getAttribute("unit_db_name"),"hrFilecount",filenum);
String human_ID="HF"+"00"+"00"+"00"+filenum;
try{
String sql1="select * from hr_resume where details_number='"+details_number+"'";
ResultSet rs1=hr_db.executeQuery(sql1);
if(rs1.next()){
String sql = "insert into hr_file(human_ID,human_name,human_address,human_tel,human_home_tel,human_postcode,educated_degree,educated_years,educated_major,register,register_time,history_records,human_cellphone,idcard,religion,race,nationality,party,age,birthday,birthplace,sex,speciality,hobby,human_email,picture,attachment_name) values('"+human_ID+"','"+rs1.getString("human_name")+"','"+rs1.getString("human_address")+"','"+rs1.getString("human_tel")+"','"+rs1.getString("human_home_tel")+"','"+rs1.getString("human_postcode")+"','"+rs1.getString("educated_degree")+"','"+rs1.getString("educated_years")+"','"+rs1.getString("educated_major")+"','"+register+"','"+register_time+"','"+rs1.getString("history_records")+"','"+rs1.getString("human_cellphone")+"','"+rs1.getString("idcard")+"','"+rs1.getString("religion")+"','"+rs1.getString("race")+"','"+rs1.getString("nationality")+"','"+rs1.getString("party")+"','"+rs1.getString("age")+"','"+rs1.getString("birthday")+"','"+rs1.getString("birthplace")+"','"+rs1.getString("sex")+"','"+rs1.getString("speciality")+"','"+rs1.getString("hobby")+"','"+rs1.getString("human_email")+"','"+rs1.getString("picture")+"','"+rs1.getString("attachment_name")+"')" ;
	hr_db.executeUpdate(sql) ;
}
	String sql2="delete from resume where details_number='"+details_number+"'";
	hr_db.executeUpdate(sql2) ;
	hr_db.commit();
	hr_db.close();

response.sendRedirect("hr/engage/pass/query_ok_a.jsp");

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
