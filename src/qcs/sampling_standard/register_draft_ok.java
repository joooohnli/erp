/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package qcs.sampling_standard;

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
String standard_id=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));

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
String standard_name = mySmartUpload.getRequest().getParameter("standard_name");
String method_name = mySmartUpload.getRequest().getParameter("method_name");
String designer = mySmartUpload.getRequest().getParameter("designer");
String register = mySmartUpload.getRequest().getParameter("register");
String register_ID = mySmartUpload.getRequest().getParameter("register_ID");
String register_time = mySmartUpload.getRequest().getParameter("register_time");
String bodyab = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyab);
String level_id = mySmartUpload.getRequest().getParameter("level_id");
if(level_id==null) level_id="";
String class_id = mySmartUpload.getRequest().getParameter("class_id");
if(class_id==null) class_id="";
String aql_id = mySmartUpload.getRequest().getParameter("aql_id");
if(aql_id==null) aql_id="";


	String sqla = "insert into qcs_sampling_standard(standard_id,standard_name,register_ID,register,register_time,sampling_method,designer,quality_level,mil_std,aql,remark,check_tag";
	String sqlb = ") values ('"+standard_id+"','"+standard_name+"','"+register_ID+"','"+register+"','"+register_time+"','"+method_name+"','"+designer+"','"+level_id+"','"+class_id+"','"+aql_id+"','"+remark+"','5'" ;
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	int p=i+1;
	sqla=sqla+",attachment"+p;
	sqlb=sqlb+",'"+file_name[i]+"'";
}
String sql=sqla+sqlb+")";
	qcs_db.executeUpdate(sql) ;
String[] batch = mySmartUpload.getRequest().getParameterValues("batch");
String[] sample = mySmartUpload.getRequest().getParameterValues("sample");
String[] formula = mySmartUpload.getRequest().getParameterValues("formula");
String[] accept = mySmartUpload.getRequest().getParameterValues("accept");
String[] reject = mySmartUpload.getRequest().getParameterValues("reject");
String[] sample_max = mySmartUpload.getRequest().getParameterValues("sample_max");
String sample_max_temp="";
String formula_temp="";
for(int i=0;i<batch.length;i++){
	sample_max_temp=sample_max!=null?sample_max[i]:"";
	formula_temp=formula!=null?formula[i]:"";
	sql="insert into qcs_sampling_standard_details(standard_id,standard_name,details_number,batch,sampling_amount,sampling_formula,sample_code,accept_amount,reject_amount) values('"+standard_id+"','"+standard_name+"','"+i+"','"+batch[i]+"','"+sample[i]+"','"+formula_temp+"','"+sample_max_temp+"','"+accept[i]+"','"+reject[i]+"')";
	qcs_db.executeUpdate(sql) ;
}
response.sendRedirect("qcs/sampling_standard/register_draft_ok.jsp?finished_tag=0");

qcs_db.commit();
qcs_db.close();
}
catch(Exception ex){
	response.sendRedirect("qcs/sampling_standard/register_draft_ok.jsp?finished_tag=1");
}
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
