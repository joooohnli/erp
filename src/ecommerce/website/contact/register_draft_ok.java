/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.website.contact;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import java.text.*;
import include.nseer_cookie.*;
import include.nseer_db.*;
import com.jspsmart.upload.*;
import include.nseer_cookie.getAttachmentLength;

public class register_draft_ok extends HttpServlet{//创建方法
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
String path=dbApplication.getRealPath("/");
try{
HttpSession session=request.getSession();
counter count=new counter(dbApplication);
PrintWriter out=response.getWriter();
String mod=request.getRequestURI();
SmartUpload mySmartUpload=new SmartUpload();
mySmartUpload.setCharset("UTF-8");
getAttachmentLength getAttachmentLength=new getAttachmentLength();
nseer_db_backup1 ecommerce_db = new nseer_db_backup1(dbApplication);
if(ecommerce_db.conn((String)dbSession.getAttribute("unit_db_name"))){
mySmartUpload.initialize(pageContext);
String file_type=getFileLength.getFileType((String)session.getAttribute("unit_db_name"));
long d=getFileLength.getFileLength((String)session.getAttribute("unit_db_name"));
mySmartUpload.setMaxFileSize(d);
mySmartUpload.setAllowedFilesList(file_type);
try{
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
mySmartUpload.upload();
String[] file_name=new String[mySmartUpload.getFiles().getCount()];
String filekind_chain=mySmartUpload.getRequest().getParameter("filekind_chain");
String chain_id=Divide1.getId(filekind_chain);
String chain_name=Divide1.getName(filekind_chain);
String sql2="select * from ecommerce_contact where chain_id='"+chain_id+"'";
ResultSet rs2=ecommerce_db.executeQuery(sql2) ;
if(!rs2.next()){
String tel=mySmartUpload.getRequest().getParameter("tel") ;
String address=mySmartUpload.getRequest().getParameter("address") ;
String fax=mySmartUpload.getRequest().getParameter("fax") ;
String postcode=mySmartUpload.getRequest().getParameter("postcode") ;
String register=mySmartUpload.getRequest().getParameter("register") ;
String qq1=mySmartUpload.getRequest().getParameter("qq1") ;
String qq2=mySmartUpload.getRequest().getParameter("qq2") ;
String qq3=mySmartUpload.getRequest().getParameter("qq3") ;
String qq4=mySmartUpload.getRequest().getParameter("qq4") ;
String email=mySmartUpload.getRequest().getParameter("email") ;
String register_time=mySmartUpload.getRequest().getParameter("register_time") ;
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	com.jspsmart.upload.SmartFile file = mySmartUpload.getFiles().getFile(i);
	if (file.isMissing()){
		file_name[i]="";
		continue;
	}
	int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"ecommerceAttachmentcount");
	count.write((String)dbSession.getAttribute("unit_db_name"),"ecommerceAttachmentcount",filenum);
	file_name[i]=filenum+file.getFileName();
	file.saveAs(path+"ecommerce\\file_attachments\\" + filenum+file.getFileName());
}
try{
	String contact_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
	String sqla = "insert into ecommerce_contact(contact_ID,chain_id,chain_name,address,tel,fax,postcode,register,register_time,email,qq1,qq2,qq3,qq4,check_tag";
	String sqlb=") values ('"+contact_ID+"','"+chain_id+"','"+chain_name+"','"+address+"','"+tel+"','"+fax+"','"+postcode+"','"+register+"','"+register_time+"','"+email+"','"+qq1+"','"+qq2+"','"+qq3+"','"+qq4+"','5'" ;
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	int p=i+1;
	sqla=sqla+",attachment"+p;
	sqlb=sqlb+",'"+file_name[i]+"'";
}
String sql=sqla+sqlb+")";
	ecommerce_db.executeUpdate(sql) ;
response.sendRedirect("ecommerce/website/contact/register_draft_ok.jsp?finished_tag=1");
}
catch (Exception ex){
	ex.printStackTrace();
}
}else{
response.sendRedirect("ecommerce/website/contact/register_draft_ok.jsp?finished_tag=2");
}
 ecommerce_db.commit();
 ecommerce_db.close();
}catch(Exception ex){
	response.sendRedirect("ecommerce/website/contact/register_ok_a.jsp");
}
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
	}
}
}