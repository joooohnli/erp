/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package qcs.solution;
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
String[] item = mySmartUpload.getRequest().getParameterValues("item");
if(item!=null){
String[] file_name=new String[mySmartUpload.getFiles().getCount()];
String[] not_change=new String[mySmartUpload.getFiles().getCount()];
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
String time=formatter.format(now);
String solution_id = mySmartUpload.getRequest().getParameter("solution_id");
String config_id = request.getParameter("config_id");
String sql6="select id from qcs_workflow where object_ID='"+solution_id+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=qcs_db.executeQuery(sql6);
if(!rs6.next()){
String sql1="select attachment1 from qcs_solution where solution_id='"+solution_id+"' and check_tag='0'";
ResultSet rs=qcs_db.executeQuery(sql1);
if(!rs.next()){
	
	response.sendRedirect("qcs/solution/check_ok.jsp?finished_tag=0");
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
String solution_name = mySmartUpload.getRequest().getParameter("solution_name");
String product_id = mySmartUpload.getRequest().getParameter("product_id");
String product_name = mySmartUpload.getRequest().getParameter("product_name");
String designer = mySmartUpload.getRequest().getParameter("designer");
String checker = mySmartUpload.getRequest().getParameter("checker");
String checker_id = mySmartUpload.getRequest().getParameter("checker_id");
String check_time = mySmartUpload.getRequest().getParameter("check_time");
String quality_standard = mySmartUpload.getRequest().getParameter("quality_standard");
String quality_standard_id = quality_standard.split("/")[0];
String quality_standard_name = quality_standard.split("/")[1];
String bodyab = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyab);
	String sqla = "update qcs_solution set solution_name='"+solution_name+"',quality_standard_id='"+quality_standard_id+"',quality_standard_name='"+quality_standard_name+"',product_id='"+product_id+"',product_name='"+product_name+"',designer='"+designer+"',checker='"+checker+"',checker_id='"+checker_id+"',check_time='"+check_time+"',remark='"+remark+"'";
	String sqlb = " where solution_id='"+solution_id+"'" ;
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
	
sql="delete from qcs_solution_details where solution_id='"+solution_id+"'";
qcs_db.executeUpdate(sql);

String[] analyse_method = mySmartUpload.getRequest().getParameterValues("analyse_method");
String[] default_basis = mySmartUpload.getRequest().getParameterValues("default_basis");
String[] ready_basis = mySmartUpload.getRequest().getParameterValues("ready_basis");
String[] quality_method = mySmartUpload.getRequest().getParameterValues("quality_method");
String[] standard_value = mySmartUpload.getRequest().getParameterValues("standard_value");
String[] standard_max = mySmartUpload.getRequest().getParameterValues("standard_max");
String[] standard_min = mySmartUpload.getRequest().getParameterValues("standard_min");
for(int i=0;i<item.length;i++){
	if(!item[i].equals("")){
	sql="insert into qcs_solution_details(solution_id,solution_name,details_number,item,analyse_method,default_basis,ready_basis,quality_method,standard_value,standard_max,standard_min) values('"+solution_id+"','"+solution_name+"','"+i+"','"+item[i]+"','"+analyse_method[i]+"','"+default_basis[i]+"','"+ready_basis[i]+"','"+quality_method[i]+"','"+standard_value[i]+"','"+standard_max[i]+"','"+standard_min[i]+"')";
	qcs_db.executeUpdate(sql) ;
}
}
sql = "update qcs_workflow set checker='"+checker+"',checker_ID='"+checker_id+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+solution_id+"' and config_id='"+config_id+"'" ;
	qcs_db.executeUpdate(sql);
	sql="select id from qcs_workflow where object_ID='"+solution_id+"' and check_tag='0'";
	ResultSet rset=qcs_db.executeQuery(sql);
	if(!rset.next()){
	sql="update qcs_solution set check_tag='1' where solution_id='"+solution_id+"' and check_tag='0'";
	qcs_db.executeUpdate(sql);
	}
response.sendRedirect("qcs/solution/check_ok.jsp?finished_tag=2");
}
}else{
	response.sendRedirect("qcs/solution/check_ok.jsp?finished_tag=5");
}
}else{
	response.sendRedirect("qcs/solution/check_ok.jsp?finished_tag=4");
}
}
catch(Exception ex){
	ex.printStackTrace();
	response.sendRedirect("qcs/solution/check_ok.jsp?finished_tag=3");
}
qcs_db.commit();
qcs_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
