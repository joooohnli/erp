/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package qcs.item;

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
String config_id=request.getParameter("config_id");
String item_id = mySmartUpload.getRequest().getParameter("item_id");
String sql6="select id from qcs_workflow where object_ID='"+item_id+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=qcs_db.executeQuery(sql6);
if(!rs6.next()){
String sql1="select attachment1 from qcs_item where item_id='"+item_id+"' and check_tag='0'";
ResultSet rs=qcs_db.executeQuery(sql1);
if(!rs.next()){
	
	response.sendRedirect("qcs/item/check_ok.jsp?finished_tag=0");
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

String item_name = mySmartUpload.getRequest().getParameter("item_name");
String analyse_method = mySmartUpload.getRequest().getParameter("analyse_method");
String default_basis = mySmartUpload.getRequest().getParameter("default_basis");
String ready_basis = mySmartUpload.getRequest().getParameter("ready_basis");
String quality_method = mySmartUpload.getRequest().getParameter("quality_method");
String quality_equipment = mySmartUpload.getRequest().getParameter("quality_equipment");
String sampling_standard = mySmartUpload.getRequest().getParameter("sampling_standard");
String defect_class = mySmartUpload.getRequest().getParameter("defect_class");
String important = mySmartUpload.getRequest().getParameter("important");
String designer = mySmartUpload.getRequest().getParameter("designer");
String checker = mySmartUpload.getRequest().getParameter("checker");
String checker_id = mySmartUpload.getRequest().getParameter("checker_id");
String check_time = mySmartUpload.getRequest().getParameter("check_time");
String QV_hidden = mySmartUpload.getRequest().getParameter("QV_hidden");
String bodyab = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyab);
String sqla = "update qcs_item set item_name='"+item_name+"',checker_id='"+checker_id+"',checker='"+checker+"',check_time='"+check_time+"',analyse_method='"+analyse_method+"',designer='"+designer+"',default_basis='"+default_basis+"',ready_basis='"+ready_basis+"',quality_method='"+quality_method+"',quality_equipment='"+quality_equipment+"',sampling_standard='"+sampling_standard+"',defect_class='"+defect_class+"',important='"+important+"',quality_value='"+QV_hidden+"',remark='"+remark+"'";
	String sqlb = " where item_id='"+item_id+"'" ;
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
sql = "update qcs_workflow set checker='"+checker+"',checker_ID='"+checker_id+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+item_id+"' and config_id='"+config_id+"'" ;
qcs_db.executeUpdate(sql);
sql="select id from qcs_workflow where object_ID='"+item_id+"' and check_tag='0'";
ResultSet rset=qcs_db.executeQuery(sql);
if(!rset.next()){
	sql="update qcs_item set check_tag='1' where item_id='"+item_id+"' and check_tag='0'";
	qcs_db.executeUpdate(sql);
}
response.sendRedirect("qcs/item/check_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("qcs/item/check_ok.jsp?finished_tag=2");
}
qcs_db.commit();
qcs_db.close();
}
catch(Exception ex){
	ex.printStackTrace();
	response.sendRedirect("qcs/item/check_ok.jsp?finished_tag=3");
}
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
