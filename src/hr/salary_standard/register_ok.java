/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.salary_standard;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*; 

import java.sql.ResultSet;
import java.util.*;
import java.io.* ;
import include.nseer_cookie.*;
import include.nseer_db.*;
import validata.ValidataNumber;

public class register_ok extends HttpServlet{
//创建方法
ServletContext application;
HttpSession session;


public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
counter count = new counter(dbApplication);
try{
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
HttpSession session=request.getSession();
PrintWriter out=response.getWriter();
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
ValidataNumber validata= new  ValidataNumber();

String standard_ID=request.getParameter("standard_ID");
String standard_name=request.getParameter("standard_name");
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String major_type=request.getParameter("major_type") ;
String designer=request.getParameter("designer") ;
String[] item_name=request.getParameterValues("item_name");
String[] salary=request.getParameterValues("salary");
String[] details_number=request.getParameterValues("details_number");
int p=0;
for(int i=0;i<item_name.length;i++){
	if(!salary[i].equals("")){
		StringTokenizer tokenTO4 = new StringTokenizer(salary[i],",");        
		String salary1="";
		while(tokenTO4.hasMoreTokens()) {
			salary1+= tokenTO4.nextToken();
		}
			if(!validata.validata(salary1)){
			p++;
			}
	}
}
if(p==0){
int n=0;
double salary_sum=0.0d;
for(int i=0;i<item_name.length;i++){
	if(!salary[i].equals("")){
		StringTokenizer tokenTO4 = new StringTokenizer(salary[i],",");        
		String salary1="";
		while(tokenTO4.hasMoreTokens()) {
			salary1+= tokenTO4.nextToken();
			if(salary1.indexOf("-")!=-1){
			n++;
			}
		}
	}
}
if(n==0){
try{
	String sql1="delete from hr_salary_standard where standard_ID='"+standard_ID+"'";
	hr_db.executeUpdate(sql1);
	String sql3="delete from hr_salary_standard_details where standard_ID='"+standard_ID+"'";
	hr_db.executeUpdate(sql3);
	for(int i=0;i<item_name.length;i++){
	if(salary[i].equals("")) salary[i]="0";
		String salarying="";
		StringTokenizer tokenTO = new StringTokenizer(salary[i],",");        
		while(tokenTO.hasMoreTokens()) {
			salarying+=tokenTO.nextToken();
		}
		salary_sum+=Double.parseDouble(salarying);
		String sql4="insert into hr_salary_standard_details(standard_ID,standard_name,details_number,item_name,salary) values('"+standard_ID+"','"+standard_name+"','"+details_number[i]+"','"+item_name[i]+"','"+salarying+"')";
	
		hr_db.executeUpdate(sql4);
	}
	String mod=request.getRequestURI();
	count.writeTime((String)dbSession.getAttribute("unit_db_name"),mod);
	String sql2="insert into hr_salary_standard(standard_ID,standard_name,major_type,designer,register,register_time,salary_sum) values('"+standard_ID+"','"+standard_name+"','"+major_type+"','"+designer+"','"+register+"','"+register_time+"','"+salary_sum+"')";
		hr_db.executeUpdate(sql2);
		
		
		List rsList = GetWorkflow.getList(hr_db, "hr_config_workflow", "02");	
		
	if(rsList.size()==0){
		String sql="update hr_salary_standard set check_tag='1' where standard_ID='"+standard_ID+"'";
		hr_db.executeUpdate(sql);
	}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		String sql = "insert into hr_workflow(config_id,object_ID,type_id,describe1,describe2) values ('"+elem[0]+"','"+standard_ID+"','02','"+elem[1]+"','"+elem[2]+"')" ;
		hr_db.executeUpdate(sql);
		}
	}
}catch (Exception ex){
out.println("error"+ex);
}
response.sendRedirect("hr/salary_standard/register_ok_a.jsp");
}else{


response.sendRedirect("hr/salary_standard/register_ok_b.jsp");


}}else{
		
response.sendRedirect("hr/salary_standard/register_ok_c.jsp");

}
hr_db.commit();
hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}

