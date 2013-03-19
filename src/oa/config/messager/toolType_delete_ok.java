/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package oa.config.messager;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class toolType_delete_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{

ServletContext application;
HttpSession session= request.getSession(true);

nseer_db_backup1 oa_db = new nseer_db_backup1(dbApplication);
if(oa_db.conn((String)dbSession.getAttribute("unit_db_name"))){

int i;
int intRowCount;
String sqll = "select * from oa_config_public_char where kind='群发工具分类' order by type_ID" ;
ResultSet rs=oa_db.executeQuery(sqll) ;
rs.last();
intRowCount=rs.getRow();
String[] del=new String[intRowCount];
del=(String[])session.getAttribute("del");
if(del!=null){
for(i=1;i<=intRowCount;i++){
try{
	if(del[i-1]!=null){
	String sql = "delete from oa_config_public_char where id='"+del[i-1]+"'" ;
    oa_db.executeUpdate(sql) ;
	}
	}
	catch (Exception ex) {
		ex.printStackTrace();
	}
	}
}
oa_db.commit();
oa_db.close();
response.sendRedirect("oa/config/messager/toolType.jsp");


}else{
	response.sendRedirect("error_conn.htm");
}
}
	catch (Exception ex) {
		ex.printStackTrace();
	}
}
}