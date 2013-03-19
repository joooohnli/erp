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

import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.NseerId;
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
import include.nseer_cookie.getFileLength;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import com.jspsmart.upload.SmartUpload;

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
String[] sample_lable = mySmartUpload.getRequest().getParameterValues("sample_lable");
if(sample_lable!=null){
String[] file_name=new String[mySmartUpload.getFiles().getCount()];
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
String time=formatter.format(now);
String sample_id=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));

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
String quality_type = mySmartUpload.getRequest().getParameter("quality_type");
String sampling_person = mySmartUpload.getRequest().getParameter("sampling_person");
String sampling_time = mySmartUpload.getRequest().getParameter("sampling_time");
String register = mySmartUpload.getRequest().getParameter("register");
String register_time = mySmartUpload.getRequest().getParameter("register_time");
String bodyab = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyab);
	String sqla = "insert into qcs_sample(sample_id,lately_view_time,quality_type,apply_id,sampling_person,sampling_time,register,register_time,remark";
	String sqlb = ") values ('"+sample_id+"','"+sampling_time+"','"+quality_type+"','"+apply_id+"','"+sampling_person+"','"+sampling_time+"','"+register+"','"+register_time+"','"+remark+"'" ;
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	int p=i+1;
	sqla=sqla+",attachment"+p;
	sqlb=sqlb+",'"+file_name[i]+"'";
}
String sql=sqla+sqlb+")";
	qcs_db.executeUpdate(sql);
String[] product_id = mySmartUpload.getRequest().getParameterValues("product_id");
String[] product_name = mySmartUpload.getRequest().getParameterValues("product_name");
String[] amount_unit = mySmartUpload.getRequest().getParameterValues("amount_unit");
String[] sumtotal = mySmartUpload.getRequest().getParameterValues("sumtotal");
String[] sampling_amount = mySmartUpload.getRequest().getParameterValues("sampling_amount");
String[] view_cycle = mySmartUpload.getRequest().getParameterValues("view_cycle");
String[] deposit_limit = mySmartUpload.getRequest().getParameterValues("deposit_limit");
String[] deposit_place = mySmartUpload.getRequest().getParameterValues("deposit_place");
for(int i=0;i<sample_lable.length;i++){
	if(!sample_lable[i].equals("")){
	sql="insert into qcs_sample_details(sample_id,sample_lable,product_id,product_name,amount_unit,sumtotal,sampling_amount,view_cycle,deposit_limit,deposit_place,details_number) values('"+sample_id+"','"+sample_lable[i]+"','"+product_id[i]+"','"+product_name[i]+"','"+amount_unit[i]+"','"+sumtotal[i]+"','"+sampling_amount[i]+"','"+view_cycle[i]+"','"+deposit_limit[i]+"','"+deposit_place[i]+"','"+i+"')";
	qcs_db.executeUpdate(sql);
}
}
List rsList = GetWorkflow.getList(qcs_db, "qcs_config_workflow", "13");
if(rsList.size()==0){
	sql="update qcs_sample set check_tag='1' where sample_id='"+sample_id+"'";
	qcs_db.executeUpdate(sql);
}else{
	Iterator ite=rsList.iterator();
	while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into qcs_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+sample_id+"','"+elem[1]+"','"+elem[2]+"')" ;
		qcs_db.executeUpdate(sql);
	}
}
response.sendRedirect("qcs/sample/register_ok.jsp?finished_tag=0");
qcs_db.commit();
qcs_db.close();
}else{
	response.sendRedirect("qcs/sample/register_ok.jsp?finished_tag=2");
}
}catch(Exception ex){
	response.sendRedirect("qcs/sample/register_ok.jsp?finished_tag=1");
}
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
