/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package oa.messager;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import include.nseer_db.*;
import java.io.*;
import java.util.*;
import include.nseer_cookie.*;

public class register_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


try{
//实例化

HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
nseer_db_backup1 oa_db = new nseer_db_backup1(dbApplication);
if(oa_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String messager_type = request.getParameter("messager_type");
String tool_type = request.getParameter("tool_type");
String register = request.getParameter("register");
String register_ID = request.getParameter("register_ID");
String register_time = request.getParameter("register_time");
String contents = exchange.toHtmlFCK(request.getParameter("content"));

	StringTokenizer tokenTO1 = new StringTokenizer(contents,", ");        
            while(tokenTO1.hasMoreTokens()) {
			String content=tokenTO1.nextToken();
			if(content.indexOf(">")!=-1){
				content=content.substring(content.indexOf(">")+1);
			}
			if(content.indexOf("<")!=-1){
				content=content.substring(0,content.indexOf("<"));
			}
			String sql="select * from oa_messager where content='"+content+"'";
			ResultSet rs=oa_db.executeQuery(sql);
			if(!rs.next()){
				String sql1 = "insert into oa_messager(register,register_ID,register_time,type,tool_type,content) values('"+register+"','"+register_ID+"','"+register_time+"','"+messager_type+"','"+tool_type+"','"+content+"')";
				oa_db.executeUpdate(sql1);
			}
		}
		oa_db.commit();
	oa_db.close();
response.sendRedirect("oa/messager/register_ok_b.jsp");
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){ex.printStackTrace();}
}
}