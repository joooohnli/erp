/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.website.link;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import include.nseer_db.*;
import java.io.*;
import java.util.*;
import java.text.*;
import com.jspsmart.upload.*;
import include.nseer_cookie.*;

public class register_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
//实例化
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
counter count=new counter(dbApplication);
SmartUpload mySmartUpload=new SmartUpload();
mySmartUpload.setCharset("UTF-8");
nseer_db_backup1 ecommerce_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 ecommerce_db1 = new nseer_db_backup1(dbApplication);
if(ecommerce_db.conn((String)dbSession.getAttribute("unit_db_name"))&&ecommerce_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
getAttachmentLength getAttachmentLength=new getAttachmentLength();
mySmartUpload.initialize(pageContext);
String file_type="jpg,gif,bmp";
long d=getFileLength.getFileLength((String)session.getAttribute("unit_db_name"));
mySmartUpload.setMaxFileSize(d);
mySmartUpload.setAllowedFilesList(file_type);
String news_ID=request.getParameter("news_ID");
try{
mySmartUpload.upload();
String[] file_name=new String[mySmartUpload.getFiles().getCount()];
String url = mySmartUpload.getRequest().getParameter("url");
String topic = mySmartUpload.getRequest().getParameter("topic");
String sql2="select * from ecommerce_link where url like '%"+url+"%'";
ResultSet rset1=ecommerce_db.executeQuery(sql2) ;
if(rset1.next()){
 response.sendRedirect("ecommerce/website/link/register_ok_c.jsp");
}else{
String register = mySmartUpload.getRequest().getParameter("register");
String register_ID = mySmartUpload.getRequest().getParameter("register_ID");
String register_time = mySmartUpload.getRequest().getParameter("register_time");
String content = new String(mySmartUpload.getRequest().getParameter("content").getBytes("UTF-8"),"UTF-8");
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	com.jspsmart.upload.SmartFile file = mySmartUpload.getFiles().getFile(i);
	if (file.isMissing()){
		file_name[i]="";
		continue;
	}
	int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"ecommerceAttachmentcount");
	count.write((String)dbSession.getAttribute("unit_db_name"),"ecommerceAttachmentcount",filenum);
	file_name[i]=filenum+file.getFileName();
	file.saveAs(path+"ecommerce/file_attachments/" + filenum+file.getFileName());
}
List rsList = (List)new java.util.ArrayList();
	String[] elem=new String[3];
	String sql="select id,describe1,describe2 from ecommerce_config_workflow where type_id='10'";
	ResultSet rset=ecommerce_db.executeQuery(sql);
	while(rset.next()){
		elem=new String[3];
		elem[0]=rset.getString("id");
		elem[1]=rset.getString("describe1");
		elem[2]=rset.getString("describe2");
		rsList.add(elem);
	}
	String link_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
	String sqla = "insert into ecommerce_link(register,register_ID,register_time,link_ID,topic,content,url";
	String sqlb = ") values ('"+register+"','"+register_ID+"','"+register_time+"','"+link_ID+"','"+topic+"','"+content+"','"+url+"'" ;
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	int p=i+1;
	sqla=sqla+",attachment"+p;
	sqlb=sqlb+",'"+file_name[i]+"'";
}
sql=sqla+sqlb+")";
ecommerce_db.executeUpdate(sql) ;
if(rsList.size()==0){
		sql="update ecommerce_link set check_tag='1',excel_tag='3' where link_ID='"+link_ID+"'";
		ecommerce_db.executeUpdate(sql) ;
}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into ecommerce_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+link_ID+"','"+elem[1]+"','"+elem[2]+"','10')" ;
        ecommerce_db.executeUpdate(sql) ;
		}
	}
response.sendRedirect("ecommerce/website/link/register_ok_b.jsp");	
}
	ecommerce_db.commit();
	ecommerce_db1.commit();
	ecommerce_db.close();
	ecommerce_db1.close();
}catch(Exception ex){
	response.sendRedirect("ecommerce/website/link/register_ok_a.jsp");
	}
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
	}
}
}