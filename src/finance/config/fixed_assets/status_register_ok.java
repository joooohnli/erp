/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.config.fixed_assets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;
import include.nseer_db.nseer_db_backup1;

public class status_register_ok extends HttpServlet{

ServletContext application;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
PrintWriter out=response.getWriter();
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
HttpSession session=request.getSession();

try{

if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
ResultSet rs=null;
String sql="";
String name=request.getParameter("name");
if(name.equals("")){
	out.println("状态名称不能为空");
}else{
String if_cal=request.getParameter("if_cal");
String used_tag=request.getParameter("used_tag");
String tag=request.getParameter("tag");
String id=request.getParameter("id");
if(tag.equals("0")){
sql = "select type_name from finance_config_public_char where type_name='"+name+"' and kind='使用状态'";
rs=finance_db.executeQuery(sql);
    if(rs.next()){
    	out.println("1");
    }else{
    	sql = "insert into finance_config_public_char(kind,type_name,describe1,describe2) values('使用状态','"+name+"','"+if_cal+"','"+used_tag+"')";
    	finance_db.executeUpdate(sql);
    	out.println("0");
    }
}else{
	sql = "select type_name from finance_config_public_char where type_name='"+name+"' and kind='使用状态' and id!="+id;
	rs=finance_db.executeQuery(sql);
	    if(rs.next()){
	    	out.println("1");
	    }else{
	sql = "update finance_config_public_char set kind='使用状态',type_name='"+name+"',describe1='"+if_cal+"',describe2='"+used_tag+"' where id="+id;
	finance_db.executeUpdate(sql);
	out.println("2");
	    }
}
    finance_db.commit();
	finance_db.close();
}
}else{
	response.sendRedirect("error_conn.htm");
}
}
	catch (Exception ex) {
		ex.printStackTrace();
	}
}
}