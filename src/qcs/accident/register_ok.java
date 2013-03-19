/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package qcs.accident;

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
try{
mySmartUpload.upload();
String[] file_name=new String[mySmartUpload.getFiles().getCount()];
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
String time=formatter.format(now);
String accident_id=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));

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
String accident_time = mySmartUpload.getRequest().getParameter("accident_time");
String accident_name = mySmartUpload.getRequest().getParameter("accident_name");
String product_id = mySmartUpload.getRequest().getParameter("product_id");
String product_name = mySmartUpload.getRequest().getParameter("product_name");
String bodya = new String(mySmartUpload.getRequest().getParameter("accident_outlines").getBytes("UTF-8"),"UTF-8");
String accident_outlines=exchange.toHtml(bodya);
String body1 = new String(mySmartUpload.getRequest().getParameter("explanation").getBytes("UTF-8"),"UTF-8");
String explanation=exchange.toHtml(body1);
String body2 = new String(mySmartUpload.getRequest().getParameter("survey_result").getBytes("UTF-8"),"UTF-8");
String survey_result=exchange.toHtml(body2);
String body3 = new String(mySmartUpload.getRequest().getParameter("scene_measure").getBytes("UTF-8"),"UTF-8");
String scene_measure=exchange.toHtml(body3);
String bodyb = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
String register = mySmartUpload.getRequest().getParameter("register");
String register_id = mySmartUpload.getRequest().getParameter("register_id");
String register_time = mySmartUpload.getRequest().getParameter("register_time");
String sqla = "insert into qcs_accident(accident_id,accident_time,accident_name,product_id,product_name,accident_outlines,explanation,survey_result,scene_measure,register_id,register,register_time,remark";
	String sqlb = ") values ('"+accident_id+"','"+accident_time+"','"+accident_name+"','"+product_id+"','"+product_name+"','"+accident_outlines+"','"+explanation+"','"+survey_result+"','"+scene_measure+"','"+register_id+"','"+register+"','"+register_time+"','"+remark+"'";
	
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	int p=i+1;
	sqla=sqla+",attachment"+p;
	sqlb=sqlb+",'"+file_name[i]+"'";
}
String sql=sqla+sqlb+")";
	qcs_db.executeUpdate(sql) ;


List rsList = GetWorkflow.getList(qcs_db, "qcs_config_workflow", "14");
if(rsList.size()==0){
	sql="update qcs_accident set check_tag='1' where accident_id='"+accident_id+"'";
	qcs_db.executeUpdate(sql);
}else{
	Iterator ite=rsList.iterator();
	while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into qcs_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+accident_id+"','"+elem[1]+"','"+elem[2]+"')" ;
		qcs_db.executeUpdate(sql);
	}
}
	response.sendRedirect("qcs/accident/register_ok.jsp?finished_tag=0");

qcs_db.commit();
qcs_db.close();
}catch(Exception ex){
	response.sendRedirect("qcs/accident/register_ok_a.jsp");
	}
}else{
	response.sendRedirect("error_conn.htm");}
}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
