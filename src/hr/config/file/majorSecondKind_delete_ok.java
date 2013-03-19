/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.config.file;

import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

public class majorSecondKind_delete_ok extends HttpServlet{
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
int i;
int intRowCount;
String sqll = "select * from hr_config_major_second_kind" ;
ResultSet rs=hr_db.executeQuery(sqll) ;
rs.next();
rs.last();
intRowCount=rs.getRow();
String[] del=new String[intRowCount];
del=(String[])session.getAttribute("del");
String[] first_kind_ID=new String[intRowCount];
String[] first_kind_name=new String[intRowCount];
String[] second_kind_ID=new String[intRowCount];
String[] second_kind_name=new String[intRowCount];
String[] real_del=new String[intRowCount];
int m=0;
int n=0;
if(del!=null){
for(i=1;i<=intRowCount;i++){
try{
	if(del[i-1]!=null){
		real_del[n]=del[i-1];
		n++;
	String sql2="select * from hr_config_major_second_kind where id='"+del[i-1]+"'" ;
ResultSet rs2=hr_db.executeQuery(sql2) ;
if(rs2.next()){
	first_kind_ID[i-1]=rs2.getString("first_kind_ID");
	first_kind_name[i-1]=rs2.getString("first_kind_name");
	second_kind_ID[i-1]=rs2.getString("second_kind_ID");
	second_kind_name[i-1]=rs2.getString("second_kind_name");
}
	String sql3="select * from hr_file where human_major_first_kind_ID='"+first_kind_ID[i-1]+"' and human_major_second_kind_ID='"+second_kind_ID[i-1]+"'" ;
ResultSet rs3=hr_db.executeQuery(sql3) ;
if(!rs3.next()){
	String sql = "delete from hr_config_major_second_kind where id='"+del[i-1]+"'" ;
    hr_db.executeUpdate(sql) ;
	}else{
	second_kind_ID[m]=second_kind_ID[i-1];
	second_kind_name[m]=second_kind_name[i-1];
	m++;
}
	}
}
	catch (Exception ex) {
		out.println("error"+ex);
	}
	}
}

if(n==0){
	response.sendRedirect("hr/config/file/majorSecondKind.jsp");
}else{
if(m<n&&m!=0){

  session.setAttribute("second_kind_ID",second_kind_ID);
	session.setAttribute("second_kind_name",second_kind_name);
	session.setAttribute("second_kind_count",m+"");
	response.sendRedirect("hr/config/file/majorSecondKind_delete_ok_c.jsp");
}else if(m==n){

	response.sendRedirect("hr/config/file/majorSecondKind_delete_ok_a.jsp");

}else if(m==0){


response.sendRedirect("hr/config/file/majorSecondKind_delete_ok_b.jsp");

}
}
hr_db.commit();
hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}
