/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package security.license;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import validata.ValidataNumber;
import include.nseer_db.*;
import include.nseer_cookie.*;

public class register_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();

ValidataNumber validata=new ValidataNumber();
nseer_db_backup1 security_db = new nseer_db_backup1(dbApplication);

try{

if(security_db.conn((String)dbSession.getAttribute("unit_db_name"))){
Email mail=new Email();
String human_ID=request.getParameter("human_ID");
String human_name=request.getParameter("human_name");
String choose_value_group=request.getParameter("choose_value_group");
String register=request.getParameter("register");
String register_time=request.getParameter("register_time");
String expiry_period=request.getParameter("expiry_period");
String license_code=request.getParameter("license_code");
String unit_id=request.getParameter("unit_id");
String chain_name=request.getParameter("chain_name");
String human_major_first_kind_name=request.getParameter("human_major_first_kind_name");
String human_major_second_kind_name=request.getParameter("human_major_second_kind_name");
String[] email_box=request.getParameterValues("human_email");
String subject="ERP系统用户注册信息";
String content="使用单位简称："+unit_id+"<br>"+"姓名："+human_name+"<br>"+"员工档案编号："+human_ID+"<br>"+"所在机构："+chain_name+"<br>"+"职位分类："+human_major_first_kind_name+"<br>"+"职位名称："+human_major_second_kind_name+"<br>"+"许可证号码："+license_code+"<br>"+"有效期限："+expiry_period+"天"+"<br>"+"发放时间："+register_time;
if(validata.validata(expiry_period)){
if(!email_box[0].equals("")) mail.send(email_box,"smtp.sina.com.cn","yhuser@sina.com","123456",subject,content);
String sql3="select id from security_license where human_ID='"+human_ID+"' and enrollment_tag='0'";
ResultSet rs3=security_db.executeQuery(sql3);
if(rs3.next()){
		String sql1="update security_license set expiry_period='"+expiry_period+"' where human_ID='"+human_ID+"'";
		security_db.executeUpdate(sql1);		
String sql2="update hr_file set license_tag='1' where human_ID='"+human_ID+"'";
security_db.executeUpdate(sql2);
session.setAttribute("register_time",register_time);
session.setAttribute("expiry_period",expiry_period);
session.setAttribute("license_code",license_code);
  	response.sendRedirect("security/license/register_ok_a.jsp?human_ID="+human_ID+"");
	}else{
	
response.sendRedirect("security/license/register_ok_b.jsp");
} 
}else{
response.sendRedirect("security/license/register_ok_c.jsp?human_ID="+human_ID+"&&choose_value_group="+toUtf8String.utf8String(exchange.toURL(choose_value_group))+"");
	}
	security_db.commit();
	security_db.close();
}else{
	response.sendRedirect("error_conn.htm");
	}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}