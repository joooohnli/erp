/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package security.license;
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class delete_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 security_db = new nseer_db_backup1(dbApplication);
try{
if(security_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String human_ID=request.getParameter("human_ID");
String id=request.getParameter("id");
	String sql1 = "delete from security_license where id='"+id+"'" ;
	security_db.executeUpdate(sql1) ;
int amount=0;
	String sql="select count(*) from document_main";
		ResultSet rs=security_db.executeQuery(sql);
	if(rs.next())
	{  amount=rs.getInt("count(*)");
	}
	String[] str=new String[amount];
	int n=0;
	sql="select * from document_main";
	rs=security_db.executeQuery(sql);
	while(rs.next())
	{  str[n]=rs.getString("reason");
	n++;
	}
for(int i=0;i<str.length;i++){	
	String table1=str[i]+"_allright";
	sql="delete from "+table1+" where human_ID='"+human_ID+"'";
	security_db.executeUpdate(sql);
	table1=str[i]+"_view";
	sql="delete from "+table1+" where human_ID='"+human_ID+"'";
	security_db.executeUpdate(sql);
	}
sql="delete from security_workspace where human_ID='"+human_ID+"'";
	security_db.executeUpdate(sql);	
String sql2="update hr_file set license_tag='0' where human_ID='"+human_ID+"'";
security_db.executeUpdate(sql2);
  	response.sendRedirect("security/license/delete_list.jsp");
security_db.commit();
security_db.close();
}else{
	response.sendRedirect("error_conn.htm");
	}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}