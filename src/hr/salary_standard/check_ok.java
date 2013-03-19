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
import java.io.*;
import include.nseer_cookie.exchange;
import include.nseer_db.*;
import validata.ValidataNumber;
import validata.ValidataTag;

public class check_ok extends HttpServlet{
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
ValidataTag vt= new  ValidataTag();
ValidataNumber validata= new  ValidataNumber();

if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String standard_ID=request.getParameter("standard_ID");
String config_id=request.getParameter("config_id");
String sql6="select id from hr_workflow where object_ID='"+standard_ID+"' and type_id='02' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=hr_db.executeQuery(sql6);
if(!rs6.next()){
String standard_name=request.getParameter("standard_name");
String major_type=request.getParameter("major_type") ;
String designer=request.getParameter("designer") ;
String[] item_name=request.getParameterValues("item_name");
String[] salary=request.getParameterValues("salary");
String[] details_number=request.getParameterValues("details_number");
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String check_time=request.getParameter("check_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"hr_salary_standard","standard_ID",standard_ID,"check_tag").equals("0")){

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
	for(int i=0;i<item_name.length;i++){
	if(salary[i].equals("")) salary[i]="0";
		String salarying="";
		StringTokenizer tokenTO = new StringTokenizer(salary[i],",");        
		while(tokenTO.hasMoreTokens()) {
			salarying+=tokenTO.nextToken();
		}
		salary_sum+=Double.parseDouble(salarying);
		String sql4="update hr_salary_standard_details set standard_name='"+standard_name+"',salary='"+salarying+"' where standard_ID='"+standard_ID+"' and details_number='"+details_number[i]+"'";
		//out.println(sql4);
		hr_db.executeUpdate(sql4);
	}
	String sql2="update hr_salary_standard set standard_name='"+standard_name+"',major_type='"+major_type+"',designer='"+designer+"',checker='"+checker+"',check_time='"+check_time+"',salary_sum='"+salary_sum+"',remark='"+remark+"' where standard_ID='"+standard_ID+"'";
		hr_db.executeUpdate(sql2);
	String sql = "update hr_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+standard_ID+"' and config_id='"+config_id+"' and type_id='02'" ;
	hr_db.executeUpdate(sql);
	sql="select id from hr_workflow where object_ID='"+standard_ID+"' and check_tag='0' and type_id='02'";
	ResultSet rset=hr_db.executeQuery(sql);
	if(!rset.next()){
		sql="update hr_salary_standard set check_tag='1' where standard_ID='"+standard_ID+"'";
		hr_db.executeUpdate(sql);
		sql="update hr_file set salary_standard_name='"+standard_name+"',major_type='"+major_type+"',salary_sum='"+salary_sum+"' where salary_standard_ID='"+standard_ID+"'";
		hr_db.executeUpdate(sql);
	}
}
catch (Exception ex){
out.println("error"+ex);
}

response.sendRedirect("hr/salary_standard/check_ok_a.jsp");

}else{


response.sendRedirect("hr/salary_standard/check_ok_b.jsp?standard_ID="+standard_ID+"");


}}else{
		
	response.sendRedirect("hr/salary_standard/check_ok_c.jsp?standard_ID="+standard_ID+"");

}
}else{

response.sendRedirect("hr/salary_standard/check_ok_d.jsp");

}
}else{
response.sendRedirect("hr/file/check_ok.jsp?finished_tag=0");
}
hr_db.commit();
hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}