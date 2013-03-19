/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package qcs.complain;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.text.SimpleDateFormat;

import include.nseer_db.*;
import include.nseer_cookie.*;

import java.io.*;
import java.util.*;

import com.jspsmart.upload.*;


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
nseer_db_backup1 qcs_db = new nseer_db_backup1(dbApplication);
if(qcs_db.conn((String)dbSession.getAttribute("unit_db_name"))){
mySmartUpload.initialize(pageContext);
String file_type=getFileLength.getFileType((String)session.getAttribute("unit_db_name"));
long d=getFileLength.getFileLength((String)session.getAttribute("unit_db_name"));
mySmartUpload.setMaxFileSize(d);
mySmartUpload.setAllowedFilesList(file_type);
String complain_id=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
try{
mySmartUpload.upload();
String[] file_name=new String[mySmartUpload.getFiles().getCount()];
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
String time=formatter.format(now);

for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	com.jspsmart.upload.SmartFile file = mySmartUpload.getFiles().getFile(i);
	if (file.isMissing()){
		file_name[i]="";
		continue;
	}
	int filenum1=count.read((String)dbSession.getAttribute("unit_db_name"),"qcsAttachmentcount");
	count.write((String)dbSession.getAttribute("unit_db_name"),"qcsAttachmentcount",filenum1);
	file_name[i]=filenum1+file.getFileName();
	file.saveAs(path+"qcs/file_attachments/" + filenum1+file.getFileName());
}
String complain_time = mySmartUpload.getRequest().getParameter("complain_time");
String product_id = mySmartUpload.getRequest().getParameter("product_id");
String product_name = mySmartUpload.getRequest().getParameter("product_name");
String complainant = mySmartUpload.getRequest().getParameter("complainant");
String company = mySmartUpload.getRequest().getParameter("company");
String address = mySmartUpload.getRequest().getParameter("address");
String tel = mySmartUpload.getRequest().getParameter("tel");
String cellphone = mySmartUpload.getRequest().getParameter("cellphone");
String email = mySmartUpload.getRequest().getParameter("email");
String complain_way = mySmartUpload.getRequest().getParameter("complain_way");
String complain_type = mySmartUpload.getRequest().getParameter("complain_type");
String register = mySmartUpload.getRequest().getParameter("register");
String register_id = mySmartUpload.getRequest().getParameter("register_id");
String register_time = mySmartUpload.getRequest().getParameter("register_time");
String bodya = new String(mySmartUpload.getRequest().getParameter("content").getBytes("UTF-8"),"UTF-8");
String content=exchange.toHtml(bodya);
String bodyb = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
	String sqla = "insert into qcs_complain(complain_id,complain_time,product_id,product_name,complainant,company,address,tel,cellphone,email,complain_way,complain_type,register_id,register,register_time,content,remark";
	String sqlb = ") values ('"+complain_id+"','"+complain_time+"','"+product_id+"','"+product_name+"','"+complainant+"','"+company+"','"+address+"','"+tel+"','"+cellphone+"','"+email+"','"+complain_way+"','"+complain_type+"','"+register_id+"','"+register+"','"+register_time+"','"+content+"','"+remark+"'";
	
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	int p=i+1;
	sqla=sqla+",attachment"+p;
	sqlb=sqlb+",'"+file_name[i]+"'";
}
String sql=sqla+sqlb+")";
	qcs_db.executeUpdate(sql) ;

qcs_db.commit();
qcs_db.close();

response.sendRedirect("qcs/complain/register_ok.jsp?finished_tag=0");
}catch(Exception ex){
	response.sendRedirect("qcs/complain/register_ok_a.jsp");
	}
}else{
	response.sendRedirect("error_conn.htm");}
}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
