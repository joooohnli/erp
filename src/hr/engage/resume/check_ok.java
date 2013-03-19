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
import java.io.*;
import include.nseer_cookie.exchange;
import include.nseer_db.*;

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
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String details_number=request.getParameter("details_number") ;
String human_name=request.getParameter("human_name") ;
String human_address=request.getParameter("human_address") ;
//String human_title_class=request.getParameter("human_title_class") ;
String human_tel=request.getParameter("human_tel") ;
String human_home_tel=request.getParameter("human_home_tel");
String human_postcode=request.getParameter("human_postcode");
String human_cellphone=request.getParameter("human_cellphone");
String idcard=request.getParameter("idcard") ;
String religion=request.getParameter("religion") ;
String party=request.getParameter("party") ;
String college=request.getParameter("college") ;
String race=request.getParameter("race") ;
String nationality=request.getParameter("nationality") ;
String age=request.getParameter("age") ;
String sex=request.getParameter("sex") ;
String speciality=request.getParameter("speciality") ;
String hobby=request.getParameter("hobby") ;
String birthday=request.getParameter("birthday") ;
String demand_salary_standard=request.getParameter("demand_salary_standard") ;
String birthplace=request.getParameter("birthplace") ;
String human_email=request.getParameter("human_email") ;
String educated_degree=request.getParameter("educated_degree") ;
String educated_years=request.getParameter("educated_years") ;
String educated_major=request.getParameter("educated_major") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
String bodya = new String(request.getParameter("history_records").getBytes("UTF-8"),"UTF-8");
String history_records=exchange.toHtml(bodya);
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
String bodyc = new String(request.getParameter("remark1").getBytes("UTF-8"),"UTF-8");
String remark1=exchange.toHtml(bodyc);
if(birthday.equals("")) birthday="1800-01-01";
try{
	String sql = "update hr_resume set human_name='"+human_name+"',human_address='"+human_address+"',human_tel='"+human_tel+"',human_home_tel='"+human_home_tel+"',human_postcode='"+human_postcode+"',educated_degree='"+educated_degree+"',educated_years='"+educated_years+"',educated_major='"+educated_major+"',history_records='"+history_records+"',remark='"+remark+"',human_cellphone='"+human_cellphone+"',human_email='"+human_email+"',idcard='"+idcard+"',religion='"+religion+"',race='"+race+"',nationality='"+nationality+"',party='"+party+"',college='"+college+"',age='"+age+"',birthday='"+birthday+"',demand_salary_standard='"+demand_salary_standard+"',birthplace='"+birthplace+"',sex='"+sex+"',speciality='"+speciality+"',hobby='"+hobby+"',checker='"+checker+"',check_time='"+check_time+"',remark1='"+remark1+"',check_tag='1' where details_number='"+details_number+"'" ;
	hr_db.executeUpdate(sql) ;
	hr_db.commit();
	hr_db.close();


response.sendRedirect("hr/engage/resume/check_ok_a.jsp");
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}
