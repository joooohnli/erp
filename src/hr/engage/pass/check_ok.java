/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.engage.pass;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*; 
import java.sql.*;
import java.util.*;
import java.io.*;
import include.nseer_cookie.* ;
import include.nseer_db.*;
import validata.ValidataTag;

public class check_ok extends HttpServlet{
//创建方法
ServletContext application;

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
counter count=new counter(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String details_number=request.getParameter("details_number");
String sql8="select * from hr_resume where details_number='"+details_number+"' and interview_tag='3' and pass_check_tag='1'";
ResultSet rs8 = hr_db.executeQuery(sql8) ;
	if(rs8.next()){
String pass_check_time=request.getParameter("pass_check_time") ;
String pass_checker=request.getParameter("pass_checker") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
try{
String sql = "update hr_resume set pass_check_tag='2',pass_checker='"+pass_checker+"',pass_check_time='"+pass_check_time+"' where details_number='"+details_number+"'" ;
	hr_db.executeUpdate(sql) ;
	String sql1="update hr_interview set remark='"+remark+"' where details_number='"+details_number+"'";
	hr_db.executeUpdate(sql1) ;
String human_ID=NseerId.getId("hr/file",(String)dbSession.getAttribute("unit_db_name"));
	String sql2="select * from hr_resume where details_number='"+details_number+"'";
	ResultSet rs=hr_db.executeQuery(sql2);
	if(rs.next()){
	String sql3 = "insert into hr_file(chain_id,chain_name,human_major_first_kind_ID,human_major_first_kind_name,human_major_second_kind_ID,human_major_second_kind_name,human_ID,human_name,human_address,human_tel,human_home_tel,human_postcode,salary_standard_ID,salary_standard_name,salary_sum,educated_degree,educated_years,educated_major,register,register_time,history_records,remark,human_cellphone,idcard,religion,race,nationality,party,age,birthday,birthplace,sex,speciality,hobby,human_email,picture,attachment_name) values ('','','"+rs.getString("human_major_first_kind_ID")+"','"+rs.getString("human_major_first_kind_name")+"','"+rs.getString("human_major_second_kind_ID")+"','"+rs.getString("human_major_second_kind_name")+"','"+human_ID+"','"+rs.getString("human_name")+"','"+rs.getString("human_address")+"','"+rs.getString("human_tel")+"','"+rs.getString("human_home_tel")+"','"+rs.getString("human_postcode")+"','未定义','未定义','0','"+rs.getString("educated_degree")+"','"+rs.getString("educated_years")+"','"+rs.getString("educated_major")+"','"+rs.getString("register")+"','"+rs.getString("register_time")+"','"+rs.getString("history_records")+"','"+rs.getString("remark")+"','"+rs.getString("human_cellphone")+"','"+rs.getString("idcard")+"','"+rs.getString("religion")+"','"+rs.getString("race")+"','"+rs.getString("nationality")+"','"+rs.getString("party")+"','"+rs.getString("age")+"','"+rs.getString("birthday")+"','"+rs.getString("birthplace")+"','"+rs.getString("sex")+"','"+rs.getString("speciality")+"','"+rs.getString("hobby")+"','"+rs.getString("human_email")+"','"+rs.getString("picture")+"','"+rs.getString("attachment_name")+"')";
	hr_db.executeUpdate(sql3) ;
	}
	List rsList = GetWorkflow.getList(hr_db, "hr_config_workflow", "01");	
	if(rsList.size()==0){
		sql="update hr_file set check_tag='1' where human_ID='"+human_ID+"'";
		hr_db.executeUpdate(sql) ;
	}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into hr_workflow(config_id,object_ID,type_id,describe1,describe2) values ('"+elem[0]+"','"+human_ID+"','01','"+elem[1]+"','"+elem[2]+"')" ;
		hr_db.executeUpdate(sql);
		}
	}
response.sendRedirect("hr/engage/pass/check_ok_a.jsp");
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
response.sendRedirect("hr/engage/pass/check_ok_b.jsp");
}
hr_db.commit();
hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}