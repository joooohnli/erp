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

import include.nseer_db.nseer_db_backup1;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.StringTokenizer;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

public class calWay_delete_ok extends HttpServlet{

ServletContext application;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
PrintWriter out=response.getWriter();
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
String sql="";
ResultSet rs=null;
int count=0;
int count1=0;
String temp="";
try{
if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String id_group=request.getParameter("id_group");
if(!id_group.equals("")){
	if(id_group.indexOf("⊙")!=-1){
StringTokenizer tk=new StringTokenizer(id_group,"⊙");
while(tk.hasMoreTokens()){
	  temp=tk.nextToken();
	  sql = "select id from finance_config_calway where used_tag='0' and id="+temp;
	  rs=finance_db.executeQuery(sql);
if(rs.next()){	 
  sql = "delete from finance_config_calway where used_tag='0' and id="+temp;
  finance_db.executeUpdate(sql);
  count++;
}
count1++;
}

	}else{
		  sql = "select id from finance_config_calway where used_tag='0' and id="+id_group;
		  rs=finance_db.executeQuery(sql);
	if(rs.next()){	 
	  sql = "delete from finance_config_calway where used_tag='0' and id="+id_group;
	  finance_db.executeUpdate(sql);
	  count++;
	}
	count1++;
	}	
	if(count==count1) out.println("0");
	if(count<count1&&count>0)  out.println("1");
	if(count==0)  out.println("2");
	    finance_db.commit();
		finance_db.close();
}else{out.println("3");}
}else{
	response.sendRedirect("error_conn.htm");
}
}
	catch (Exception ex) {
		ex.printStackTrace();
	}
}
}