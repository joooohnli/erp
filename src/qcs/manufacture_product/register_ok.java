/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package qcs.manufacture_product;

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
String[] item = mySmartUpload.getRequest().getParameterValues("item");
if(item!=null){
String[] file_name=new String[mySmartUpload.getFiles().getCount()];
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
String time=formatter.format(now);
String qcs_id=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));

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
String apply_id = mySmartUpload.getRequest().getParameter("apply_id");
String product_id = mySmartUpload.getRequest().getParameter("product_id");
String product_name = mySmartUpload.getRequest().getParameter("product_name");
String qcs_amount = mySmartUpload.getRequest().getParameter("qcs_amount");
String qcs_time = mySmartUpload.getRequest().getParameter("qcs_time");
String quality_way = mySmartUpload.getRequest().getParameter("quality_way");
String quality_solution = mySmartUpload.getRequest().getParameter("quality_solution");
String sampling_standard = mySmartUpload.getRequest().getParameter("sampling_standard");
String sampling_amount = mySmartUpload.getRequest().getParameter("sampling_amount");
String accept = mySmartUpload.getRequest().getParameter("accept");
String reject = mySmartUpload.getRequest().getParameter("reject");
String qualified = mySmartUpload.getRequest().getParameter("qualified");
String unqualified = mySmartUpload.getRequest().getParameter("unqualified");
String qcs_result = mySmartUpload.getRequest().getParameter("qcs_result");
String register = mySmartUpload.getRequest().getParameter("register");
String register_time = mySmartUpload.getRequest().getParameter("register_time");
String bodyab = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyab);
	String sqla = "insert into qcs_manufacture_product(qcs_id,apply_id,product_id,product_name,qcs_amount,qcs_time,quality_way,quality_solution,sampling_standard,sampling_amount,accept,reject,qualified,unqualified,qcs_result,register,register_time,remark";
	String sqlb = ") values ('"+qcs_id+"','"+apply_id+"','"+product_id+"','"+product_name+"','"+qcs_amount+"','"+qcs_time+"','"+quality_way+"','"+quality_solution+"','"+sampling_standard+"','"+sampling_amount+"','"+accept+"','"+reject+"','"+qualified+"','"+unqualified+"','"+qcs_result+"','"+register+"','"+register_time+"','"+remark+"'" ;
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	int p=i+1;
	sqla=sqla+",attachment"+p;
	sqlb=sqlb+",'"+file_name[i]+"'";
}
String sql=sqla+sqlb+")";
	qcs_db.executeUpdate(sql) ;

String[] default_basis = mySmartUpload.getRequest().getParameterValues("default_basis");
String[] ready_basis = mySmartUpload.getRequest().getParameterValues("ready_basis");
String[] quality_method = mySmartUpload.getRequest().getParameterValues("quality_method");
String[] analyse_method = mySmartUpload.getRequest().getParameterValues("analyse_method");
String[] standard_value = mySmartUpload.getRequest().getParameterValues("standard_value");
String[] standard_max = mySmartUpload.getRequest().getParameterValues("standard_max");
String[] standard_min = mySmartUpload.getRequest().getParameterValues("standard_min");
String[] quality_value = mySmartUpload.getRequest().getParameterValues("quality_value");
String[] sampling_amount_d = mySmartUpload.getRequest().getParameterValues("sampling_amount_d");
String[] qualified_d = mySmartUpload.getRequest().getParameterValues("qualified_d");
String[] unqualified_d = mySmartUpload.getRequest().getParameterValues("unqualified_d");
String[] quality_result = mySmartUpload.getRequest().getParameterValues("quality_result");
String[] unqualified_reason = mySmartUpload.getRequest().getParameterValues("unqualified_reason");
for(int i=0;i<item.length;i++){
	if(!item[i].equals("")){
	sql="insert into qcs_manufacture_product_details(qcs_id,item,default_basis,ready_basis,quality_method,analyse_method,standard_value,standard_max,standard_min,quality_value,sampling_amount_d,qualified_d,unqualified_d,quality_result,unqualified_reason,details_number) values('"+qcs_id+"','"+item[i]+"','"+default_basis[i]+"','"+ready_basis[i]+"','"+quality_method[i]+"','"+analyse_method[i]+"','"+standard_value[i]+"','"+standard_max[i]+"','"+standard_min[i]+"','"+quality_value[i]+"','"+sampling_amount_d[i]+"','"+qualified_d[i]+"','"+unqualified_d[i]+"','"+quality_result[i]+"','"+unqualified_reason[i]+"','"+i+"')";
	qcs_db.executeUpdate(sql);
}
sql = "update qcs_apply_details set qcs_tag='1' where apply_id='"+apply_id+"'";
qcs_db.executeUpdate(sql);
}
List rsList = GetWorkflow.getList(qcs_db, "qcs_config_workflow", "09");
if(rsList.size()==0){
	sql="update qcs_manufacture_product set check_tag='1' where qcs_id='"+qcs_id+"'";
	qcs_db.executeUpdate(sql);
}else{
	Iterator ite=rsList.iterator();
	while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into qcs_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+qcs_id+"','"+elem[1]+"','"+elem[2]+"')" ;
		qcs_db.executeUpdate(sql);
	}
}
response.sendRedirect("qcs/manufacture_product/register_ok.jsp?finished_tag=0");
qcs_db.commit();
qcs_db.close();
}else{
	 response.sendRedirect("qcs/manufacture_product/register_ok.jsp?finished_tag=1");
	}
}catch(Exception ex){
	response.sendRedirect("qcs/manufacture_product/register_ok.jsp?finished_tag=2");
}
 
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
