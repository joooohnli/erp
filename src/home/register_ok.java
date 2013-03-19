/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package home;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import include.nseer_db.*;
import java.io.*;
import java.util.*;
import java.text.*;
import javax.mail.internet.*;
import javax.mail.*;

public class register_ok extends HttpServlet{
ServletContext application;
nseer_db_backup erp_db = null;
public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

request.setCharacterEncoding("UTF-8");
	try{
//实例化

String rand=(String)dbSession.getAttribute("rand");
String input_check=request.getParameter("input_check");
String unit_id=request.getParameter("unit_id");
erp_db = new nseer_db_backup(dbApplication);
if(erp_db.conn("mysql")){
String sql5="select * from unit_info where unit_id='"+unit_id+"'";
ResultSet rs5=erp_db.executeQuery(sql5);
if (rand.equals(input_check)&&!rs5.next()) 
{

HttpSession session=request.getSession();


java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String unit_name=request.getParameter("unit_name");

String name=unit_id+"_admin";
  String contact_person=request.getParameter("contact_person");
  String business_license=request.getParameter("business_license");
  String tel=request.getParameter("tel");
  String cell=request.getParameter("cell");
  String address=request.getParameter("address");
  String postcode=request.getParameter("postcode");
  String email=request.getParameter("email");
  String field_type=request.getParameter("field_type");
  String ip=request.getRemoteAddr();
  int db_number=0;
  String unit_db_name="";
  String sql3="select * from unit_info where active_tag='3' order by id";
  ResultSet rset3=erp_db.executeQuery(sql3) ;
  if(rset3.next()){
	  unit_db_name=rset3.getString("unit_db_name");
	String sql4="update unit_info set unit_name='"+unit_name+"',unit_id='"+unit_id+"',contact_person='"+contact_person+"',business_license='"+business_license+"',tel='"+tel+"',cell='"+cell+"',address='"+address+"',postcode='"+postcode+"',email='"+email+"',field_type='"+field_type+"',register_time='"+time+"',ip='"+ip+"',active_tag='0' where id='"+rset3.getString("id")+"'";
	erp_db.executeUpdate(sql4) ;
  }else{
	String sqll="select * from unit_info order by id desc";
	ResultSet rset=erp_db.executeQuery(sqll) ;
if(rset.next()){
	db_number=Integer.parseInt(rset.getString("unit_db_name").substring(8))+1;
	unit_db_name="ondemand"+db_number;
	String sql = "insert into unit_info(unit_name,unit_id,contact_person,business_license,tel,cell,address,postcode,email,field_type,register_time,ip,unit_db_name) values ('"+unit_name+"','"+unit_id+"','"+contact_person+"','"+business_license+"','"+tel+"','"+cell+"','"+address+"','"+postcode+"','"+email+"','"+field_type+"','"+time+"','"+ip+"','"+unit_db_name+"')" ;
	erp_db.executeUpdate(sql) ;
}
  }
	String[] str={"1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","p","q","r","s","t","u","v","w","x","y","z"};
	String passwd="";
	for(int i=0;i<8;i++){
        double r=Math.random();
        int k=(int)(r*33);
		passwd=passwd+str[k];
}
	nseer_db_backup db = new nseer_db_backup(dbApplication);
	if(db.conn(unit_db_name)){
	String sql2="update security_users set human_name='"+name+"',name='"+name+"',passwd='"+passwd+"' where human_ID='09020000000000100000'";
	db.executeUpdate(sql2);
	sql2="update hr_file set human_name='"+name+"' where human_ID='09020000000000100000'";
	db.executeUpdate(sql2);
	sql2="update security_license set human_name='"+name+"' where human_ID='09020000000000100000'";
	db.executeUpdate(sql2);
	db.close();
	
	erp_db.close();
try{
Properties props=new Properties();
props.put("mail.smtp.host","smtp.188.com");
props.put("mail.smtp.auth","true");
Session s=Session.getInstance(props);
s.setDebug(true);

MimeMessage message=new MimeMessage(s);
InternetAddress from=new InternetAddress("nseerjava@188.com");
message.setFrom(from);
InternetAddress to=new InternetAddress(email);
message.setRecipient(Message.RecipientType.TO,to);
message.setSubject("请获取开源ERP管理员用户名和密码");	message.setText("您好，恩信科技已收到您的注册信息。您使用恩信科技开源ERP软件的管理员的用户名是"+name+"，密码是"+passwd);
message.setSentDate(new java.util.Date());
message.saveChanges();
Transport transport=s.getTransport("smtp");
transport.connect("smtp.188.com","nseerjava","nseerglobal");
transport.sendMessage(message,message.getAllRecipients());
transport.close();
}catch(MessagingException e){
	e.printStackTrace();
}
 response.sendRedirect("home/register_ok.jsp?name="+name+"&passwd="+passwd);
	}else{
 response.sendRedirect("home/register_ok_b.jsp?name="+name);
	}
}
else
{
 response.sendRedirect("home/error.jsp");
}
}
else
{
 response.sendRedirect("/error_conn.jsp");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}