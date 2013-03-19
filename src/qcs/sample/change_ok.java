/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package qcs.sample;

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

public class change_ok extends HttpServlet{

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
String sqla="";
String sample_id = mySmartUpload.getRequest().getParameter("sample_id");
String apply_id = mySmartUpload.getRequest().getParameter("apply_id");
String view_cycle = mySmartUpload.getRequest().getParameter("view_cycle");
String product_id = mySmartUpload.getRequest().getParameter("product_id");
String product_name = mySmartUpload.getRequest().getParameter("product_name");
String quality_type = mySmartUpload.getRequest().getParameter("quality_type");
String last_view_time = mySmartUpload.getRequest().getParameter("last_view_time");
String solution = mySmartUpload.getRequest().getParameter("quality_solution");
String view_time = mySmartUpload.getRequest().getParameter("view_time");
String register = mySmartUpload.getRequest().getParameter("register");
String register_time = mySmartUpload.getRequest().getParameter("register_time");
String bodyab = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyab);
if(solution==null||solution.equals("")){
	response.sendRedirect("qcs/sample/change_ok.jsp?finished_tag=2");
}
	sqla = "insert into qcs_sample_view(sample_id,last_view_time,apply_id,view_cycle,product_id,product_name,quality_type,solution,view_time,register,register_time,remark";
	String sqlb = ") values ('"+sample_id+"','"+last_view_time+"','"+apply_id+"','"+view_cycle+"','"+product_id+"','"+product_name+"','"+quality_type+"','"+solution+"','"+view_time+"','"+register+"','"+register_time+"','"+remark+"'" ;
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	int p=i+1;
	sqla=sqla+",attachment"+p;
	sqlb=sqlb+",'"+file_name[i]+"'";
}
String sql=sqla+sqlb+")";
qcs_db.executeUpdate(sql);
String[] item = mySmartUpload.getRequest().getParameterValues("item");
String[] quality_method = mySmartUpload.getRequest().getParameterValues("quality_method");
String[] standard_value = mySmartUpload.getRequest().getParameterValues("standard_value");
String[] standard_max = mySmartUpload.getRequest().getParameterValues("standard_max");
String[] standard_min = mySmartUpload.getRequest().getParameterValues("standard_min");
String[] view_value = mySmartUpload.getRequest().getParameterValues("view_value");
String[] view_result = mySmartUpload.getRequest().getParameterValues("view_result");
for(int i=0;i<item.length;i++){
	if(!item[i].equals("")){
	sql="insert into qcs_sample_view_details(sample_id,view_time,item,quality_method,standard_value,standard_max,standard_min,view_value,view_result,details_number) values('"+sample_id+"','"+view_time+"','"+item[i]+"','"+quality_method[i]+"','"+standard_value[i]+"','"+standard_max[i]+"','"+standard_min[i]+"','"+view_value[i]+"','"+view_result[i]+"','"+i+"')";
	qcs_db.executeUpdate(sql);
}
	sql="update qcs_sample set lately_view_time='"+view_time+"' where sample_id='"+sample_id+"'";
	qcs_db.executeUpdate(sql);
}
response.sendRedirect("qcs/sample/change_ok.jsp?finished_tag=0");
qcs_db.commit();
qcs_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	response.sendRedirect("qcs/sample/change_ok.jsp?finished_tag=1");
}
 
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
