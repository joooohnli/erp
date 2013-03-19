/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.training;

import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

public class register_draft_ok extends HttpServlet{
//创建方法
ServletContext application;
HttpSession session;


public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{

HttpSession session=request.getSession();
PrintWriter out=response.getWriter();

nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String major_first_kind_ID="";
String major_first_kind_name="";
String major_second_kind_ID="";
String major_second_kind_name="";
String major_first_kind=request.getParameter("human_major_first_kind");
StringTokenizer tokenTO4 = new StringTokenizer(major_first_kind,"/");        
	while(tokenTO4.hasMoreTokens()) {
        major_first_kind_ID = tokenTO4.nextToken();
		major_first_kind_name = tokenTO4.nextToken();
		}
String major_second_kind=request.getParameter("human_major_second_kind");
StringTokenizer tokenTO5 = new StringTokenizer(major_second_kind,"/");        
	while(tokenTO5.hasMoreTokens()) {
        major_second_kind_ID = tokenTO5.nextToken();
		major_second_kind_name = tokenTO5.nextToken();
		}
String human_ID=request.getParameter("human_ID");
String human_name=request.getParameter("human_name");
String training_item=request.getParameter("training_item") ;
String training_hour=request.getParameter("training_hour") ;
String training_result_degree=request.getParameter("training_result_degree") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String chain_name=request.getParameter("chain_name");
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
int training_time=1;
try{
	String sql="select training_time from hr_training where human_ID='"+human_ID+"' order by training_time desc";
	ResultSet m_rs=hr_db.executeQuery(sql);
	if(m_rs.next()){
		training_time=m_rs.getInt("training_time")+1;
	}
	sql = "insert into hr_training(chain_name,human_major_first_kind_ID,human_major_first_kind_name,human_major_second_kind_ID,human_major_second_kind_name,human_ID,human_name,training_item,training_hour,training_result_degree,register,register_time,remark,training_time,check_tag) values ('"+chain_name+"','"+major_first_kind_ID+"','"+major_first_kind_name+"','"+major_second_kind_ID+"','"+major_second_kind_name+"','"+human_ID+"','"+human_name+"','"+training_item+"','"+training_hour+"','"+training_result_degree+"','"+register+"','"+register_time+"','"+remark+"','"+training_time+"','5')" ;
	hr_db.executeUpdate(sql) ;
	sql="update hr_file set training_check_tag='1' where human_ID='"+human_ID+"'";
	hr_db.executeUpdate(sql);
	
response.sendRedirect("hr/training/register_draft_ok.jsp?finished_tag=0");

}
catch (Exception ex){
out.println("error"+ex);
}
hr_db.commit();
hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}