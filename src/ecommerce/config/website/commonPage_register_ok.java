/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.config.website;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import include.nseer_db.*;
import java.io.*;
import com.jspsmart.upload.*;
import include.nseer_cookie.getAttachmentLength;
import include.nseer_cookie.getAttachmentType;
import include.nseer_cookie.counter;
import include.nseer_cookie.addHref;

public class commonPage_register_ok extends HttpServlet{

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
nseer_db_backup1 ecommerce_db = new nseer_db_backup1(dbApplication);
if(ecommerce_db.conn((String)dbSession.getAttribute("unit_db_name"))){

getAttachmentLength getAttachmentLength=new getAttachmentLength();
getAttachmentType getAttachmentType=new getAttachmentType();
addHref addHref=new addHref(dbApplication);
double d=getAttachmentLength.getAttachmentLength((String)dbSession.getAttribute("unit_db_name"),"document_config_public_char");
String ee=getAttachmentType.getAttachmentType((String)dbSession.getAttribute("unit_db_name"),"document_config_public_char");
mySmartUpload.initialize(pageContext);
mySmartUpload.upload();
String[] file_name=new String[mySmartUpload.getFiles().getCount()];
int j=0;
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	com.jspsmart.upload.SmartFile file = mySmartUpload.getFiles().getFile(i);
	if (file.isMissing()){
		j++;
		continue;
	}
	java.io.File filea = new java.io.File(path+"ecommerce/commonPage_template/" +file.getFileName());
	if(file.getSize()>d||filea.exists()) j++;
}
if(j!=0){
	response.sendRedirect("ecommerce/config/website/commonPage_register_ok_a.jsp");
}else{
	com.jspsmart.upload.SmartFile file = mySmartUpload.getFiles().getFile(0);
	file_name[0]=file.getFileName();
	if(file.getFileName().indexOf(".jsp")!=(file.getFileName().length()-4)) j++;
	com.jspsmart.upload.SmartFile file1 = mySmartUpload.getFiles().getFile(1);
	if(file1.getFileName().indexOf(".gif")!=(file1.getFileName().length()-4)&&file1.getFileName().indexOf(".jpg")!=(file1.getFileName().length()-4)&&file1.getFileName().indexOf(".bmp")!=(file1.getFileName().length()-4)&&file1.getFileName().indexOf(".png")!=(file1.getFileName().length()-4)) j++;
String topic = mySmartUpload.getRequest().getParameter("topic");
String register = mySmartUpload.getRequest().getParameter("register");
String register_ID = mySmartUpload.getRequest().getParameter("register_ID");
String register_time = mySmartUpload.getRequest().getParameter("register_time");
if(j!=0){
	response.sendRedirect("ecommerce/config/website/commonPage_register_ok_c.jsp");
}else{
	file.saveAs(path+"portal/" +file.getFileName());
	file = mySmartUpload.getFiles().getFile(1);
	file_name[1]=file.getFileName();
	file.saveAs(path+"ecommerce/commonPage_template/"+file.getFileName());
String sql="insert into ecommerce_web_template_ii(topic,filename,attachment1,register,register_ID,register_time) values('"+topic+"','"+file_name[0]+"','"+file_name[1]+"','"+register+"','"+register_ID+"','"+register_time+"')";
ecommerce_db.executeUpdate(sql);
response.sendRedirect("ecommerce/config/website/commonPage_register_ok_b.jsp");
}
}
ecommerce_db.commit();
ecommerce_db.close();
	}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}