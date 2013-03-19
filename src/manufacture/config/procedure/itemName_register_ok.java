/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.config.procedure;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;

import include.nseer_cookie.exchange;
import include.nseer_db.*;

public class itemName_register_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 security_db = new nseer_db_backup1(dbApplication);

try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&security_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String type_ID=request.getParameter("type_id");
String type_name=request.getParameter("type_name");
String bodyc = new String(request.getParameter("describe1").getBytes("UTF-8"),"UTF-8");
String describe1=exchange.toHtml(bodyc);
String register_ID=request.getParameter("register_ID");
String sqll="select * from manufacture_config_public_char where kind='工序' and (type_name='"+type_name+"' or  type_ID='"+type_ID+"')";
ResultSet rs=manufacture_db.executeQuery(sqll);
if(rs.next()){

response.sendRedirect("manufacture/config/procedure/itemName_register_ok_a.jsp");
}else{
	String responsible_person="";
int n=0;
int m=0;
	StringTokenizer tokenTO6= new StringTokenizer(register_ID,", ");        
	while(tokenTO6.hasMoreTokens()) {
		String sql2="insert into hr_config_human_id_temp(human_ID) values('"+tokenTO6.nextToken()+"') ";

		security_db.executeUpdate(sql2);
		
		m++;
		
	}
	String sql2="select distinct human_ID from hr_config_human_id_temp";

ResultSet rs2=security_db.executeQuery(sql2);
rs2.last();


if(rs2.getRow()!=m){n++;}
sql2="delete from hr_config_human_id_temp";
		security_db.executeUpdate(sql2);
StringTokenizer tokenTO = new StringTokenizer(register_ID,", ");        
	while(tokenTO.hasMoreTokens()) {
		sql2="select * from security_users where human_ID='"+tokenTO.nextToken()+"'";
		rs2=security_db.executeQuery(sql2);
		if(rs2.next()){
			responsible_person+=rs2.getString("human_name")+", ";
		}else{
		n++;
		}
	}
if(n!=0){

response.sendRedirect("manufacture/config/procedure/itemName_register_ok_b.jsp");
}else{
      String sql = "insert into manufacture_config_public_char(kind,type_ID,type_name,describe1,register_ID) values('工序','"+type_ID+"','"+type_name+"','"+describe1+"','"+register_ID+"')" ;
    	manufacture_db.executeUpdate(sql) ;
		response.sendRedirect("manufacture/config/procedure/itemName_register_ok_c.jsp");
}
}
security_db.commit();
  manufacture_db.commit();
  security_db.close();
manufacture_db.close();
}else{
	response.sendRedirect("error_conn.htm");
    }

}
catch (Exception ex){
ex.printStackTrace();
}
}
}