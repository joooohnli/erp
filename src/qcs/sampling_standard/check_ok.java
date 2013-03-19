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

public class check_ok extends HttpServlet{

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
String[] not_change=new String[mySmartUpload.getFiles().getCount()];
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
String time=formatter.format(now);
String config_id = request.getParameter("config_id");
String standard_id = mySmartUpload.getRequest().getParameter("standard_id");
String sql6="select id from qcs_workflow where object_ID='"+standard_id+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=qcs_db.executeQuery(sql6);
if(!rs6.next()){
String sql1="select attachment1 from qcs_sampling_standard where standard_id='"+standard_id+"' and check_tag='0'";
ResultSet rs=qcs_db.executeQuery(sql1);
if(!rs.next()){
	
	response.sendRedirect("qcs/sampling_standard/check_ok.jsp?finished_tag=0");
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
		int q=i+1;
		String field_name="attachment"+q;
		if(!rs.getString(field_name).equals("")) not_change[i]="yes";
		continue;
	}
	int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"qcsAttachmentcount");
	count.write((String)dbSession.getAttribute("unit_db_name"),"qcsAttachmentcount",filenum);
	file_name[i]=filenum+file.getFileName();
	file.saveAs(path+"qcs/file_attachments/" + filenum+file.getFileName());
}

String standard_name = mySmartUpload.getRequest().getParameter("standard_name");
String method_name = mySmartUpload.getRequest().getParameter("method_name");
String designer = mySmartUpload.getRequest().getParameter("designer");
String checker = mySmartUpload.getRequest().getParameter("checker");
String checker_id = mySmartUpload.getRequest().getParameter("checker_id");
String check_time = mySmartUpload.getRequest().getParameter("check_time");
String bodyab = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyab);
String level_id = mySmartUpload.getRequest().getParameter("level_id");
if(level_id==null) level_id="";
String class_id = mySmartUpload.getRequest().getParameter("class_id");
if(class_id==null) class_id="";
String aql_id = mySmartUpload.getRequest().getParameter("aql_id");
if(aql_id==null) aql_id="";


	String sqla = "update qcs_sampling_standard set standard_name='"+standard_name+"',checker_id='"+checker_id+"',checker='"+checker+"',check_time='"+check_time+"',sampling_method='"+method_name+"',designer='"+designer+"',quality_level='"+level_id+"',mil_std='"+class_id+"',aql='"+aql_id+"',remark='"+remark+"'";
	String sqlb = " where standard_id='"+standard_id+"'" ;
	if(attachment!=null){
		for(int i=0;i<attachment.length;i++){
			sqla=sqla+","+attachment[i]+"=''";
			java.io.File file=new java.io.File(path+"qcs/file_attachments/"+delete_file_name[i]);
			file.delete();
		}
		}
		for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
			if(not_change[i]!=null&&not_change[i].equals("yes")) continue;
			int p=i+1;
			sqla=sqla+",attachment"+p+"='"+file_name[i]+"'";
		}
String sql=sqla+sqlb;
	qcs_db.executeUpdate(sql) ;
String[] batch = mySmartUpload.getRequest().getParameterValues("batch");
String[] sample = mySmartUpload.getRequest().getParameterValues("sample");
String[] formula = mySmartUpload.getRequest().getParameterValues("formula");
String[] accept = mySmartUpload.getRequest().getParameterValues("accept");
String[] reject = mySmartUpload.getRequest().getParameterValues("reject");
String[] sample_max = mySmartUpload.getRequest().getParameterValues("sample_max");
String sample_max_temp="";
String formula_temp="";
sql="delete from qcs_sampling_standard_details where standard_id='"+standard_id+"'";
qcs_db.executeUpdate(sql);
for(int i=0;i<batch.length;i++){
	sample_max_temp=sample_max!=null?sample_max[i]:"";
	formula_temp=formula!=null?formula[i]:"";
	sql="insert into qcs_sampling_standard_details(standard_id,standard_name,details_number,batch,sampling_amount,sampling_formula,sample_code,accept_amount,reject_amount) values('"+standard_id+"','"+standard_name+"','"+i+"','"+batch[i]+"','"+sample[i]+"','"+formula_temp+"','"+sample_max_temp+"','"+accept[i]+"','"+reject[i]+"')";
	qcs_db.executeUpdate(sql);
}

    sql = "update qcs_workflow set checker='"+checker+"',checker_ID='"+checker_id+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+standard_id+"' and config_id='"+config_id+"'" ;
	qcs_db.executeUpdate(sql);
	sql="select id from qcs_workflow where object_ID='"+standard_id+"' and check_tag='0'";
	ResultSet rset=qcs_db.executeQuery(sql);
	if(!rset.next()){
	sql="update qcs_sampling_standard set check_tag='1' where standard_id='"+standard_id+"' and check_tag='0'";
	qcs_db.executeUpdate(sql);
	}
response.sendRedirect("qcs/sampling_standard/check_ok.jsp?finished_tag=2");
}
}else{
response.sendRedirect("qcs/sampling_standard/check_ok.jsp?finished_tag=4");
}
qcs_db.commit();
qcs_db.close();
}
catch(Exception ex){
	ex.printStackTrace();
	response.sendRedirect("qcs/sampling_standard/check_ok.jsp?finished_tag=3");
}
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
