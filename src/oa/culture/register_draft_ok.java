/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package oa.culture;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import include.nseer_db.*;
import include.nseer_cookie.*;
import java.io.*;
import java.util.*;
import com.jspsmart.upload.*;


import include.nseer_cookie.counter;

public class register_draft_ok extends HttpServlet{

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

try{
mySmartUpload.upload();
String[] file_name=new String[mySmartUpload.getFiles().getCount()];

int filenum1=count.read((String)dbSession.getAttribute("unit_db_name"),"oaculturecount");
	String culture_ID=filenum1+"";
	count.write((String)dbSession.getAttribute("unit_db_name"),"oaculturecount",filenum1);
String sql1="select * from oa_culture where culture_ID='"+culture_ID+"'";
ResultSet rs=oa_db.executeQuery(sql1);
if(rs.next()){
	
	response.sendRedirect("oa/culture/register_draft_ok.jsp?finished_tag=0");
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
String subject = mySmartUpload.getRequest().getParameter("subject");
String culture_type = mySmartUpload.getRequest().getParameter("culture_type");
String kind_chain = mySmartUpload.getRequest().getParameter("fileKind_chain");
String chain_id=Divide1.getId(kind_chain);
String chain_name=Divide1.getName(kind_chain);

String register = mySmartUpload.getRequest().getParameter("register");
String register_ID = mySmartUpload.getRequest().getParameter("register_ID");
String register_time = mySmartUpload.getRequest().getParameter("register_time");

String content = mySmartUpload.getRequest().getParameter("content");
String bodyab = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyab);

	String sqla = "insert into oa_culture(register,register_ID,register_time,culture_ID,subject,type,content,chain_id,chain_name,remark,check_tag";
	String sqlb = ") values ('"+register+"','"+register_ID+"','"+register_time+"','"+culture_ID+"','"+subject+"','"+culture_type+"','"+content+"','"+chain_id+"','"+chain_name+"','"+remark+"','5'" ;
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	int p=i+1;
	sqla=sqla+",attachment"+p;
	sqlb=sqlb+",'"+file_name[i]+"'";
}
String sql=sqla+sqlb+")";
	oa_db.executeUpdate(sql) ;

response.sendRedirect("oa/culture/register_draft_ok.jsp?finished_tag=1");
}
oa_db.commit();
oa_db.close();
}catch(Exception ex){
	response.sendRedirect("oa/culture/register_draft_ok.jsp?finished_tag=2");
}
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){ex.printStackTrace();}
}
}