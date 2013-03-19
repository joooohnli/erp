/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.major_change;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*; 

import java.sql.ResultSet;
import java.util.*;
import java.io.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.Divide1;
import include.nseer_db.*;
import include.nseer_cookie.*;

public class register_draft_ok extends HttpServlet{//创建方法
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
nseer_db_backup1 hr_db1 = new nseer_db_backup1(dbApplication);
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 crm_db1 = new nseer_db_backup1(dbApplication);
counter count=new  counter(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db1.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String major_first_kind_ID="";
String major_first_kind_name="";
String major_second_kind_ID="";
String major_second_kind_name="";
String salary_standard_ID="";
String salary_standard_name="";
String salary_sum="";
String new_major_first_kind_ID="";
String new_major_first_kind_name="";
String new_major_second_kind_ID="";
String new_major_second_kind_name="";
String new_salary_standard_ID="";
String new_salary_standard_name="";
String new_salary_sum="";

String major_first_kind=request.getParameter("human_major_first_kind");
if(major_first_kind.indexOf("//")==-1&&major_first_kind.indexOf("  /")==-1){
StringTokenizer tokenTO4 = new StringTokenizer(major_first_kind,"/");        
	while(tokenTO4.hasMoreTokens()) {
        major_first_kind_ID = tokenTO4.nextToken();
		major_first_kind_name = tokenTO4.nextToken();
		}
}
String major_second_kind=request.getParameter("human_major_second_kind");
if(major_second_kind.indexOf("//")==-1&&major_second_kind.indexOf("  /")==-1){
StringTokenizer tokenTO5 = new StringTokenizer(major_second_kind,"/");        
	while(tokenTO5.hasMoreTokens()) {
        major_second_kind_ID = tokenTO5.nextToken();
		major_second_kind_name = tokenTO5.nextToken();
		}
}
String major_type=request.getParameter("major_type") ;
String salary_standard=request.getParameter("salary_standard");
StringTokenizer tokenTO6 = new StringTokenizer(salary_standard,"/");        
	while(tokenTO6.hasMoreTokens()) {
        salary_standard_ID = tokenTO6.nextToken();
		salary_standard_name = tokenTO6.nextToken();
		salary_sum = tokenTO6.nextToken();
		}

String new_major_first_kind=request.getParameter("select4");
if(new_major_first_kind.indexOf("//")==-1&&new_major_first_kind.indexOf("/  /")==-1){
StringTokenizer tokenTO14 = new StringTokenizer(new_major_first_kind,"/");        
	while(tokenTO14.hasMoreTokens()) {
        new_major_first_kind_ID = tokenTO14.nextToken();
		new_major_first_kind_name = tokenTO14.nextToken();
		}
}
String new_major_second_kind=request.getParameter("select5");
if(new_major_second_kind.indexOf("//")==-1&&new_major_second_kind.indexOf("/  /")==-1){
StringTokenizer tokenTO15 = new StringTokenizer(new_major_second_kind,"/");        
	while(tokenTO15.hasMoreTokens()) {
        new_major_second_kind_ID = tokenTO15.nextToken();
		new_major_second_kind_name = tokenTO15.nextToken();
		}
}
String human_name=request.getParameter("human_name") ;
String human_ID=request.getParameter("human_ID") ;
String new_major_type=request.getParameter("new_major_type") ;
String new_salary_standard=request.getParameter("new_salary_standard");
StringTokenizer tokenTO16 = new StringTokenizer(new_salary_standard,"/");        
	while(tokenTO16.hasMoreTokens()) {
        new_salary_standard_ID = tokenTO16.nextToken();
		new_salary_standard_name = tokenTO16.nextToken();
		new_salary_sum = tokenTO16.nextToken();
		}
String kind_chain=request.getParameter("old_kind_chain");
String chain_id=Divide1.getId(kind_chain);
String chain_name=Divide1.getName(kind_chain);
String new_kind_chain=request.getParameter("kind_chain");
String new_chain_id=Divide1.getId(new_kind_chain);
String new_chain_name=Divide1.getName(new_kind_chain);
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String bodyc = new String(request.getParameter("remark1").getBytes("UTF-8"),"UTF-8");
String remark1=exchange.toHtml(bodyc);
int file_change_amount1=0;
int major_change_amount1=0;
int major_time=1;
try{
	String sql="select major_time from hr_major_change where human_ID='"+human_ID+"' order by major_time desc";
	ResultSet m_rs=hr_db.executeQuery(sql);
	if(m_rs.next()){
		major_time=m_rs.getInt("major_time")+1;
	}
	sql="select file_change_amount,major_change_amount from hr_file where human_ID='"+human_ID+"'";
	m_rs=hr_db.executeQuery(sql);
	if(m_rs.next()){
		file_change_amount1=m_rs.getInt("file_change_amount")+1;
		major_change_amount1=m_rs.getInt("major_change_amount")+1;
	}
	sql = "insert into hr_major_change(chain_id,chain_name,human_major_first_kind_ID,human_major_first_kind_name,human_major_second_kind_ID,human_major_second_kind_name,new_chain_id,new_chain_name,new_human_major_first_kind_ID,new_human_major_first_kind_name,new_human_major_second_kind_ID,new_human_major_second_kind_name,human_ID,human_name,major_type,salary_standard_ID,salary_standard_name,salary_sum,new_major_type,new_salary_standard_ID,new_salary_standard_name,new_salary_sum,register,register_time,remark1,major_time,check_tag) values ('"+chain_id+"','"+chain_name+"','"+major_first_kind_ID+"','"+major_first_kind_name+"','"+major_second_kind_ID+"','"+major_second_kind_name+"','"+new_chain_id+"','"+new_chain_name+"','"+new_major_first_kind_ID+"','"+new_major_first_kind_name+"','"+new_major_second_kind_ID+"','"+new_major_second_kind_name+"','"+human_ID+"','"+human_name+"','"+major_type+"','"+salary_standard_ID+"','"+salary_standard_name+"','"+salary_sum+"','"+new_major_type+"','"+new_salary_standard_ID+"','"+new_salary_standard_name+"','"+new_salary_sum+"','"+register+"','"+register_time+"','"+remark1+"','"+major_time+"','5')" ;
	hr_db.executeUpdate(sql) ;
	
	String sql1="update hr_file set major_change_tag='1' where human_ID='"+human_ID+"'";
	hr_db.executeUpdate(sql1);

	response.sendRedirect("hr/major_change/register_draft_ok.jsp?finished_tag=0");

}
catch (Exception ex){ex.printStackTrace();
}
 hr_db.commit();
  hr_db1.commit();
   crm_db.commit();
    crm_db1.commit();
	hr_db.close();
	hr_db1.close();
	crm_db.close();
	crm_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}