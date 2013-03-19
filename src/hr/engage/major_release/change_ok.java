/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.engage.major_release;

import include.nseer_cookie.Divide1;
import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

public class change_ok extends HttpServlet{
//创建方法
ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{

nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
HttpSession session=request.getSession();
PrintWriter out=response.getWriter();

if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String id=request.getParameter("id") ;
String changer=request.getParameter("changer") ;
String change_time=request.getParameter("change_time") ;
String human_amount=request.getParameter("human_amount") ;
String deadline=request.getParameter("deadline") ;
String bodyc = new String(request.getParameter("remark1").getBytes("UTF-8"),"UTF-8");
String remark1=exchange.toHtml(bodyc);
String bodyb = new String(request.getParameter("remark2").getBytes("UTF-8"),"UTF-8");
String remark2=exchange.toHtml(bodyb);
String kind_chain=request.getParameter("kind_chain");
String chain_id=Divide1.getId(kind_chain);
String chain_name=Divide1.getName(kind_chain);
try{
	String sql = "update hr_major_release set changer='"+changer+"',change_time='"+change_time+"',human_amount='"+human_amount+"',deadline='"+deadline+"',remark1='"+remark1+"',remark2='"+remark2+"',chain_id='"+chain_id+"',chain_name='"+chain_name+"' where id='"+id+"'" ;
	hr_db.executeUpdate(sql) ;
	hr_db.commit();
	hr_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}

response.sendRedirect("hr/engage/major_release/change_ok_a.jsp");
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}