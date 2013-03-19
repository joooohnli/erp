/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package security.recovery;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.data_backup.MysqlStore;
import include.nseer_db.*;

public class recovery_ok extends HttpServlet{

public void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();

MysqlStore mysql=new MysqlStore();

try{
String database_group="";
nseer_db_backup mysql_db=new nseer_db_backup(dbApplication);
if(mysql_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String sql1="show databases";
ResultSet rs=mysql_db.executeQuery(sql1);
while(rs.next()){
	database_group+=rs.getString("database")+",";
}
mysql_db.close();
	String[] str={(String)dbSession.getAttribute("unit_db_name")};
for(int i=0;i<str.length;i++){
	if(database_group.indexOf(str[i])!=-1){
		nseer_db_backup db=new nseer_db_backup(dbApplication);
	if(db.conn(str[i])){
	String sql="drop database "+str[i]+"";
	db.executeUpdate(sql);
	
	}
	db.close();
	}	
}
String file=(String)session.getAttribute("file");
mysql.recovery(file);
response.sendRedirect("security/recovery/recovery_ok_a.jsp");

}else{
	response.sendRedirect("error_conn.htm");
	}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}