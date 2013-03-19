/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.config.stock;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.counter;

public class address_change_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
counter count=new counter(dbApplication);

nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);

try{
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String stock_ID=request.getParameter("stock_ID");
String stock_name=request.getParameter("stock_name");
String responsible_person_ID=request.getParameter("responsible_person_ID");
if(responsible_person_ID.equals("")) responsible_person_ID="09020000000000100000";
String responsible_person="";
int n=0;
int m=0;
	StringTokenizer tokenTO6= new StringTokenizer(responsible_person_ID,", ");        
	while(tokenTO6.hasMoreTokens()) {
		String sql2="insert into hr_config_human_id_temp(human_ID) values('"+tokenTO6.nextToken()+"') ";

		stock_db.executeUpdate(sql2);
		
		m++;
		
	}
	String sql2="select distinct human_ID from hr_config_human_id_temp";

ResultSet rs2=stock_db.executeQuery(sql2);
rs2.last();


if(rs2.getRow()!=m){n++;}
sql2="delete from hr_config_human_id_temp";
		stock_db.executeUpdate(sql2);
StringTokenizer tokenTO = new StringTokenizer(responsible_person_ID,", ");        
	while(tokenTO.hasMoreTokens()) {
		sql2="select * from security_users where human_ID='"+tokenTO.nextToken()+"'";
		
		rs2=stock_db.executeQuery(sql2);
		if(rs2.next()){
			responsible_person+=rs2.getString("human_name")+", ";
		}else{
		n++;
		}
	}
	
if(n!=0){
response.sendRedirect("stock/config/stock/address_change_ok_a.jsp");
}else{
String sqll="select * from stock_config_public_char where stock_ID!='"+stock_ID+"' and stock_name='"+stock_name+"'";
ResultSet rs=stock_db.executeQuery(sqll);
if(rs.next()){
response.sendRedirect("stock/config/stock/address_change_ok_b.jsp");
}else{
      String sql = "update stock_config_public_char set stock_name='"+stock_name+"',responsible_person_ID='"+responsible_person_ID+"',responsible_person='"+responsible_person+"' where stock_ID='"+stock_ID+"'" ;
    	stock_db.executeUpdate(sql) ;
response.sendRedirect("stock/config/stock/address_change_ok_c.jsp");
}
}
stock_db.commit();
stock_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
	catch (Exception ex) {
		ex.printStackTrace();
	}
}
}