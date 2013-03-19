/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package oa.config.press;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import include.nseer_db.*;
import include.nseer_cookie.counter;


public class type_register_ok extends HttpServlet{
ServletContext application;


public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
HttpSession session=request.getSession();

nseer_db_backup1 oa_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 security_db = new nseer_db_backup1(dbApplication);
if(oa_db.conn((String)dbSession.getAttribute("unit_db_name"))&&security_db.conn((String)dbSession.getAttribute("unit_db_name"))){


counter count= new  counter(dbApplication);

String register_ID=(String)session.getAttribute("human_IDD");
String type_name=request.getParameter("type_name");
String sqll="select * from oa_config_public_char where type_name='"+type_name+"'";
ResultSet rs=oa_db.executeQuery(sqll);
if(rs.next()){
	response.sendRedirect("oa/config/press/type_register_ok_a.jsp");

	}else{

String describe1=request.getParameter("describe1");

	String responsible_person="";
int m=0;
	StringTokenizer tokenTO7 = new StringTokenizer(describe1,", ");        
	while(tokenTO7.hasMoreTokens()) {
		String sql1="insert into oa_config_human_ID_temp(human_ID,register_ID) values('"+tokenTO7.nextToken()+"','"+register_ID+"') ";

		oa_db.executeUpdate(sql1);
		
		m++;
		
	}
	String sql5="select distinct human_ID from oa_config_human_ID_temp where register_ID='"+register_ID+"'";

ResultSet rs5=oa_db.executeQuery(sql5);
rs5.last();

int n=0;
if(rs5.getRow()!=m){n++;}
String sql6="delete from oa_config_human_ID_temp where register_ID='"+register_ID+"'";
		oa_db.executeUpdate(sql6);

StringTokenizer tokenTO8 = new StringTokenizer(describe1,", ");        
	while(tokenTO8.hasMoreTokens()) {
		String sql2="select * from security_users where human_ID='"+tokenTO8.nextToken()+"'";
		ResultSet rs2=security_db.executeQuery(sql2);
		if(rs2.next()){
			responsible_person+=rs2.getString("human_name")+", ";
		}else{
		n++;
		}
	}
	StringTokenizer tokenTO9 = new StringTokenizer(describe1,", ");        
	while(tokenTO9.hasMoreTokens()) {
		String sql3="select * from security_users where human_ID='"+tokenTO9.nextToken()+"'";
		ResultSet rs3=security_db.executeQuery(sql3);
		if(!rs3.next()){
			
		n++;
		}
	}
if(n!=0){

response.sendRedirect("oa/config/press/type_register_ok_b.jsp");

}else{
      String sql = "insert into oa_config_public_char(kind,type_name,describe1,describe2) values('公共关系分类','"+type_name+"','"+describe1+"','"+responsible_person+"')" ;
    	oa_db.executeUpdate(sql) ;

response.sendRedirect("oa/config/press/type_register_ok_c.jsp");
}
}
oa_db.commit();
security_db.commit();
security_db.close();
oa_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
ex.printStackTrace();
}
}
}
