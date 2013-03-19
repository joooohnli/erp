 /*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.engage.resume;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*; 
import java.sql.* ;
import java.util.*;
import java.io.*;
import include.nseer_db.*;
import java.text.*;

import include.nseer_cookie.NseerId;
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;


public class register_picture extends HttpServlet{
//创建方法
ServletContext application;
HttpSession session;


public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
counter count=new counter(dbApplication);
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
try{
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String major_first_kind_ID="";
String major_first_kind_name="";
String major_second_kind_ID="";
String major_second_kind_name="";
String major_first_kind=request.getParameter("select4");
StringTokenizer tokenTO4 = new StringTokenizer(major_first_kind,"/");        
	while(tokenTO4.hasMoreTokens()) {
        major_first_kind_ID = tokenTO4.nextToken();
		major_first_kind_name = tokenTO4.nextToken();
		}
String major_second_kind=request.getParameter("select5");
StringTokenizer tokenTO5 = new StringTokenizer(major_second_kind,"/");        
	while(tokenTO5.hasMoreTokens()) {
        major_second_kind_ID = tokenTO5.nextToken();
		major_second_kind_name = tokenTO5.nextToken();
		}
String human_name=request.getParameter("human_name") ;

String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);

String details_number=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));

String human_address=request.getParameter("human_address") ;
String demand_salary_standard1=request.getParameter("demand_salary_standard");
String demand_salary_standard="";
if(!demand_salary_standard1.equals("")){
StringTokenizer tokenTO6 = new StringTokenizer(demand_salary_standard1,",");
	while(tokenTO6.hasMoreTokens()) {
        demand_salary_standard+=tokenTO6.nextToken();
		}
}else{
   demand_salary_standard="0.0";
}
String human_tel=request.getParameter("human_tel") ;
String human_home_tel=request.getParameter("human_home_tel") ;
String human_postcode=request.getParameter("human_postcode") ;
String human_cellphone=request.getParameter("human_cellphone") ;
String idcard=request.getParameter("idcard") ;
String college=request.getParameter("college") ;
String religion=request.getParameter("religion") ;
String party=request.getParameter("party") ;
String race=request.getParameter("race") ;
String nationality=request.getParameter("nationality") ;
String age=request.getParameter("age") ;
String engage_type=request.getParameter("engage_type") ;
String sex=request.getParameter("sex") ;
String speciality=request.getParameter("speciality") ;
String hobby=request.getParameter("hobby") ;
String birthday=request.getParameter("birthday") ;
String birthplace=request.getParameter("birthplace") ;
String human_email=request.getParameter("human_email") ;
String educated_degree=request.getParameter("educated_degree") ;
String educated_years=request.getParameter("educated_years") ;
String educated_major=request.getParameter("educated_major") ;
String register_time=request.getParameter("register_time") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String bodya = new String(request.getParameter("history_records").getBytes("UTF-8"),"UTF-8");
String history_records=exchange.toHtml(bodya);
if(birthday.equals("")) birthday="1800-01-01";
	String sql = "insert into hr_resume(details_number,human_major_first_kind_ID,human_major_first_kind_name,human_major_second_kind_ID,human_major_second_kind_name,human_name,human_address,human_tel,human_home_tel,human_postcode,demand_salary_standard,educated_degree,educated_years,educated_major,register_time,history_records,remark,human_cellphone,idcard,college,religion,race,nationality,party,age,birthday,birthplace,sex,speciality,hobby,human_email,engage_type) values ('"+details_number+"','"+major_first_kind_ID+"','"+major_first_kind_name+"','"+major_second_kind_ID+"','"+major_second_kind_name+"','"+human_name+"','"+human_address+"','"+human_tel+"','"+human_home_tel+"','"+human_postcode+"','"+demand_salary_standard+"','"+educated_degree+"','"+educated_years+"','"+educated_major+"','"+register_time+"','"+history_records+"','"+remark+"','"+human_cellphone+"','"+idcard+"','"+college+"','"+religion+"','"+race+"','"+nationality+"','"+party+"','"+age+"','"+birthday+"','"+birthplace+"','"+sex+"','"+speciality+"','"+hobby+"','"+human_email+"','"+engage_type+"')" ;
	hr_db.executeUpdate(sql) ;
	hr_db.commit();
	hr_db.close();
	response.sendRedirect("hr/engage/resume/register_choose_picture.jsp?details_number="+details_number+"");
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}