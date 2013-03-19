/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package oa.planing;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import include.nseer_db.*;
import include.nseer_cookie.*;
import java.io.*;
import com.jspsmart.upload.*;


import include.nseer_cookie.counter;

public class exec_ok extends HttpServlet{

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
mySmartUpload.initialize(pageContext);
String file_type=getFileLength.getFileType((String)session.getAttribute("unit_db_name"));
long d=getFileLength.getFileLength((String)session.getAttribute("unit_db_name"));
mySmartUpload.setMaxFileSize(d);
mySmartUpload.setAllowedFilesList(file_type);
String planing_ID=request.getParameter("planing_ID");
try{
mySmartUpload.upload();
String[] file_name=new String[mySmartUpload.getFiles().getCount()];
String[] not_change=new String[mySmartUpload.getFiles().getCount()];
String sql1="select * from oa_planing where planing_ID='"+planing_ID+"' and check_tag='1'";
ResultSet rs=oa_db.executeQuery(sql1);
if(!rs.next()){
	
	response.sendRedirect("oa/planing/exec_ok_a.jsp?planing_ID="+planing_ID+"");
}else{
String[] attachment=mySmartUpload.getRequest().getParameterValues("attachment");
String[] delete_file_name=new String[0];
	if(attachment!=null){
delete_file_name=new String[attachment.length];
for(int i=0;i<attachment.length;i++){
	delete_file_name[i]=rs.getString(attachment[i]);
}
	}
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	com.jspsmart.upload.SmartFile file = mySmartUpload.getFiles().getFile(i);
	if (file.isMissing()){
		file_name[i]="";
		int q=i+2;
		String field_name="attachment"+q;
		if(!rs.getString(field_name).equals("")) not_change[i]="yes";
		continue;
	}
	int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"documentAttachmentcount");
	count.write((String)dbSession.getAttribute("unit_db_name"),"documentAttachmentcount",filenum);
	file_name[i]=filenum+file.getFileName();
	file.saveAs(path+"oa/file_attachments/" + filenum+file.getFileName());
}
String execer = mySmartUpload.getRequest().getParameter("execer");
String execer_ID = mySmartUpload.getRequest().getParameter("execer_ID");
String exec_time = mySmartUpload.getRequest().getParameter("exec_time");
String iffinish = mySmartUpload.getRequest().getParameter("iffinish");
String exec = mySmartUpload.getRequest().getParameter("exec");
	String sqla = "update oa_planing set execer='"+execer+"',execer_ID='"+execer_ID+"',exec_time='"+exec_time+"',exec='"+exec+"'";
	String sqlb = " where planing_ID='"+planing_ID+"'" ;
if(attachment!=null){
for(int i=0;i<attachment.length;i++){
	sqla=sqla+","+attachment[i]+"=''";
	java.io.File file=new java.io.File(path+"oa/file_attachments/"+delete_file_name[i]);
	file.delete();
}
}
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	if(not_change[i]!=null&&not_change[i].equals("yes")) continue;
	int p=i+2;
	sqla=sqla+",attachment"+p+"='"+file_name[i]+"'";
}
String sql=sqla+sqlb;
	oa_db.executeUpdate(sql) ;
if(iffinish.equals("0")){
	String sql2="update oa_planing set check_tag='8' where planing_ID='"+planing_ID+"'";
	oa_db.executeUpdate(sql2) ;
	
response.sendRedirect("oa/planing/exec_ok_b.jsp");
}else{
	
response.sendRedirect("oa/planing/exec_ok_c.jsp");
}
}	
}catch(Exception ex){
	response.sendRedirect("oa/planing/exec_ok_d.jsp?planing_ID="+planing_ID);
	}
oa_db.commit();
oa_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}