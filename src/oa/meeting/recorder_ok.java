/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package oa.meeting;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import com.jspsmart.upload.*;

import include.nseer_cookie.counter;
import include.nseer_cookie.*;

public class recorder_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


try{

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
String meeting_ID=request.getParameter("meeting_ID");
try{
mySmartUpload.upload();
String[] file_name=new String[mySmartUpload.getFiles().getCount()];

String meeting_subject=mySmartUpload.getRequest().getParameter("meeting_subject");
String dealwith_register=mySmartUpload.getRequest().getParameter("dealwith_register");
String dealwith_register_ID=mySmartUpload.getRequest().getParameter("dealwith_register_ID");
String ifplaning=mySmartUpload.getRequest().getParameter("ifplaning");
int n=0;
String sql2="select * from oa_meeting where meeting_ID='"+meeting_ID+"' and check_tag='1'";
ResultSet rs2=oa_db.executeQuery(sql2);
if(!rs2.next()){

	response.sendRedirect("oa/meeting/recorder_ok_a.jsp");
}else{
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	com.jspsmart.upload.SmartFile file = mySmartUpload.getFiles().getFile(i);
	if (file.isMissing()){
		file_name[i]="";
		continue;
	}
	int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"oaAttachmentcount");
	count.write((String)dbSession.getAttribute("unit_db_name"),"oaAttachmentcount",filenum);
	file_name[i]=filenum+file.getFileName();
	file.saveAs(path+"oa/file_attachments/" + filenum+file.getFileName());
}
String content = mySmartUpload.getRequest().getParameter("content");


	String sql1="update oa_meeting set dealwith_register='"+dealwith_register+"',dealwith_register_ID='"+dealwith_register_ID+"',content='"+content+"',attachment2='"+file_name[0]+"',ifplaning='"+ifplaning+"',check_tag='2' where meeting_ID='"+meeting_ID+"'";
	oa_db.executeUpdate(sql1);
	if(ifplaning.equals("0")){
		String sql3="insert into oa_planing(meeting_subject) values('"+meeting_subject+"')";
		oa_db.executeUpdate(sql3);
	}
	
response.sendRedirect("oa/meeting/recorder_ok_b.jsp");
}
	
	oa_db.commit();
	oa_db.close();
	}catch(Exception ex){
	response.sendRedirect("oa/meeting/recorder_ok_c.jsp?meeting_ID="+meeting_ID);
	}
	}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}