/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package oa.intrmessage;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import include.nseer_db.*;
import include.nseer_cookie.*;
import java.io.*;
import com.jspsmart.upload.*;
import include.nseer_cookie.getAttachmentLength;
import include.nseer_cookie.getAttachmentType;
import include.nseer_cookie.counter;

public class register_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


try{
//实例化

HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
counter count=new counter(dbApplication);
SmartUpload mySmartUpload=new SmartUpload();
mySmartUpload.setCharset("UTF-8");
nseer_db_backup1 oa_db = new nseer_db_backup1(dbApplication);
if(oa_db.conn((String)dbSession.getAttribute("unit_db_name"))){

getAttachmentLength getAttachmentLength=new getAttachmentLength();
getAttachmentType getAttachmentType=new getAttachmentType();
double d=getAttachmentLength.getAttachmentLength((String)dbSession.getAttribute("unit_db_name"),"document_config_public_char");
String ee=getAttachmentType.getAttachmentType((String)dbSession.getAttribute("unit_db_name"),"document_config_public_char");
mySmartUpload.initialize(pageContext);
mySmartUpload.upload();
String[] file_name=new String[mySmartUpload.getFiles().getCount()];
int j=0;

int filenum1=count.read((String)dbSession.getAttribute("unit_db_name"),"oaIntrmessagecount");
	String intrmessage_ID=filenum1+"";
	count.write((String)dbSession.getAttribute("unit_db_name"),"oaIntrmessagecount",filenum1);
String sql1="select * from oa_intrmessage where intrmessage_ID='"+intrmessage_ID+"'";
ResultSet rs=oa_db.executeQuery(sql1);
if(j!=0||rs.next()){
	
	response.sendRedirect("oa/intrmessage/register_ok_a.jsp");
}else{
String subject = mySmartUpload.getRequest().getParameter("subject");
String intrmessage_type = mySmartUpload.getRequest().getParameter("intrmessage_type");
String register = mySmartUpload.getRequest().getParameter("register");
String register_ID = mySmartUpload.getRequest().getParameter("register_ID");
String register_time = mySmartUpload.getRequest().getParameter("register_time");
String bulletin = mySmartUpload.getRequest().getParameter("bulletin");
String content = exchange.toHtmlFCK(mySmartUpload.getRequest().getParameter("content"));
String bodyab = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyab);
if(j!=0){
	
	response.sendRedirect("oa/intrmessage/register_ok_c.jsp");
}else{
	
	String sqla = "insert into oa_intrmessage(register,register_ID,register_time,intrmessage_ID,subject,type,content,remark";
	String sqlb = ") values ('"+register+"','"+register_ID+"','"+register_time+"','"+intrmessage_ID+"','"+subject+"','"+intrmessage_type+"','"+content+"','"+remark+"'" ;
String sql=sqla+sqlb+")";
	oa_db.executeUpdate(sql) ;
	if(bulletin!=null){
		String ds="";
String sql2="select * from oa_config_public_char where kind='数据源'";
ResultSet rs2= oa_db.executeQuery(sql2) ;
if(rs2.next()){
	ds=rs2.getString("type_name");
}
	}
	
response.sendRedirect("oa/intrmessage/register_ok_b.jsp");
}
}
oa_db.commit();
oa_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}