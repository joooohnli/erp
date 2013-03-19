/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package oa.messager;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import include.nseer_db.*;
import java.io.*;
import java.text.*;
import com.jspsmart.upload.*;
import include.nseer_cookie.counter;

public class register_batch_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


try{
//实例化
response.setContentType("text/html;charset=UTF-8");
HttpSession session=request.getSession();
counter count=new counter(dbApplication);
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
SmartUpload mySmartUpload=new SmartUpload();
mySmartUpload.setCharset("UTF-8");
nseer_db_backup1 oa_db = new nseer_db_backup1(dbApplication);
if(oa_db.conn((String)dbSession.getAttribute("unit_db_name"))){

mySmartUpload.initialize(pageContext);
mySmartUpload.upload();
String file_name="";
int n=0;
	com.jspsmart.upload.SmartFile file = mySmartUpload.getFiles().getFile(0);
	if (!file.isMissing()){
	if(file.getFileName().indexOf(".txt")==file.getFileName().length()-4){
	int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"oaAttachmentcount");
	count.write((String)dbSession.getAttribute("unit_db_name"),"oaAttachmentcount",filenum);
	file_name=path+"oa/file_attachments/" + filenum+file.getFileName();
	file.saveAs(path+"oa/file_attachments/" + filenum+file.getFileName());
String messager_type = mySmartUpload.getRequest().getParameter("messager_type");
String tool_type = mySmartUpload.getRequest().getParameter("tool_type");
String register_ID=(String)session.getAttribute("human_IDD");
String register=(String)session.getAttribute("realeditorc");
java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
RandomAccessFile filee = new RandomAccessFile(file_name, "r");
long filePointer = 0; 
long length = filee.length(); 
while (filePointer < length) {
	String mk = filee.readLine(); 
	byte []  bbbbb=mk.getBytes("8859_1"); 
	String content = new String(bbbbb, "UTF-8"); 

	String sql="select * from oa_messager where content='"+content+"' and type='"+tool_type+"'";
			ResultSet rs=oa_db.executeQuery(sql);
			if(!rs.next()){
				String sql1 = "insert into oa_messager(register,register_ID,register_time,type,tool_type,content) values('"+register+"','"+register_ID+"','"+time+"','"+messager_type+"','"+tool_type+"','"+content+"')";
				oa_db.executeUpdate(sql1);
			}
	filePointer = filee.getFilePointer(); 
	}
	
response.sendRedirect("oa/messager/register_batch_ok_b.jsp");
}else{
	response.sendRedirect("oa/messager/register_batch_ok_a.jsp");
}
}else{
	response.sendRedirect("oa/messager/register_batch_ok_c.jsp");
}
oa_db.commit();
oa_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}