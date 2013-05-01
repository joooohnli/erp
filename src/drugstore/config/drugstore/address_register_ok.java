/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package drugstore.config.drugstore;
  
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.counter;

public class address_register_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
counter count=new counter(dbApplication);
nseer_db_backup1 drugstore_db = new nseer_db_backup1(dbApplication);
try{
if(drugstore_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String drugstore_ID=request.getParameter("drugstore_ID");
String drugstore_name=request.getParameter("drugstore_name");
String responsible_person_ID=request.getParameter("responsible_person_ID");
if(responsible_person_ID.equals("")) responsible_person_ID="09020000000000100000";
String responsible_person="";
int n=0;
int m=0;
	StringTokenizer tokenTO6= new StringTokenizer(responsible_person_ID,", ");        
	while(tokenTO6.hasMoreTokens()) {
		String sql2="insert into hr_config_human_id_temp(human_ID) values('"+tokenTO6.nextToken()+"') ";
		drugstore_db.executeUpdate(sql2);		
		m++;		
	}
String sql2="select distinct human_ID from hr_config_human_id_temp";
ResultSet rs2=drugstore_db.executeQuery(sql2);
rs2.last();
if(rs2.getRow()!=m){n++;}
sql2="delete from hr_config_human_id_temp";
		drugstore_db.executeUpdate(sql2);
StringTokenizer tokenTO = new StringTokenizer(responsible_person_ID,", ");        
	while(tokenTO.hasMoreTokens()) {
		sql2="select * from security_users where human_ID='"+tokenTO.nextToken()+"'";		
		rs2=drugstore_db.executeQuery(sql2);
		if(rs2.next()){
			responsible_person+=rs2.getString("human_name")+", ";
		}else{
		n++;
		}
	}
if(n!=0){
response.sendRedirect("drugstore/drugstore/property/address_register_ok_a.jsp");
}else{
      String sqll="select * from drugstore_config_public_char where drugstore_ID='"+drugstore_ID+"' or drugstore_name='"+drugstore_name+"'";
ResultSet rs=drugstore_db.executeQuery(sqll);
if(rs.next()){
response.sendRedirect("drugstore/drugstore/property/address_register_ok_b.jsp");
}else{
String sql = "insert into drugstore_config_public_char(drugstore_ID,drugstore_name,responsible_person_ID,responsible_person,describe1) values('"+drugstore_ID+"','"+drugstore_name+"','"+responsible_person_ID+"','"+responsible_person+"','库房')" ;
drugstore_db.executeUpdate(sql) ;
int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"drugstoredrugstorecount");
count.write((String)dbSession.getAttribute("unit_db_name"),"drugstoredrugstorecount",filenum);
response.sendRedirect("drugstore/drugstore/property/address_register_ok_c.jsp");
}
}
drugstore_db.commit();
drugstore_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
	catch (Exception ex) {
		ex.printStackTrace();
	}
}
}