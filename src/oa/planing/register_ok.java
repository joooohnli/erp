/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package oa.planing;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import include.nseer_db.*;
import include.nseer_cookie.*;

import java.io.*;
import java.util.*;

import com.jspsmart.upload.*;
import include.nseer_cookie.Divide1;


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
nseer_db_backup1 oa_db = new nseer_db_backup1(dbApplication);
if(oa_db.conn((String)dbSession.getAttribute("unit_db_name"))){
mySmartUpload.initialize(pageContext);
String file_type=getFileLength.getFileType((String)session.getAttribute("unit_db_name"));
long d=getFileLength.getFileLength((String)session.getAttribute("unit_db_name"));
mySmartUpload.setMaxFileSize(d);
mySmartUpload.setAllowedFilesList(file_type);
String meeting_subject = request.getParameter("meeting_subject");
try{
mySmartUpload.upload();
String[] file_name=new String[mySmartUpload.getFiles().getCount()];
String begin_time = mySmartUpload.getRequest().getParameter("begin_time");
int filenum1=count.read((String)dbSession.getAttribute("unit_db_name"),"oaPlaningcount");
String planing_ID=begin_time+"-"+filenum1;
count.write((String)dbSession.getAttribute("unit_db_name"),"oaPlaningcount",filenum1);
String sql1="select * from oa_planing where planing_ID='"+planing_ID+"'";
ResultSet rs=oa_db.executeQuery(sql1);
if(rs.next()){
	response.sendRedirect("oa/planing/register_ok_a.jsp");
}else{
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	com.jspsmart.upload.SmartFile file = mySmartUpload.getFiles().getFile(i);
	if (file.isMissing()){
		file_name[i]="";
		continue;
	}
	int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"oaAttachmentcount");
	count.write((String)dbSession.getAttribute("unit_db_name"),"oaAttachmentcount",filenum);
	file_name[i]=filenum+file.getFileName();
	file.saveAs(path+"oa/file_attachments/" + filenum+file.getFileName());
}
String subject = mySmartUpload.getRequest().getParameter("subject");
String id = mySmartUpload.getRequest().getParameter("id");
String planing_type = mySmartUpload.getRequest().getParameter("planing_type");
String human_name="";
String human_ID="";
String end_time = mySmartUpload.getRequest().getParameter("end_time");


String select4 = mySmartUpload.getRequest().getParameter("select4");
String register = mySmartUpload.getRequest().getParameter("register");
String register_ID = mySmartUpload.getRequest().getParameter("register_ID");
String register_time = mySmartUpload.getRequest().getParameter("register_time");
String human=mySmartUpload.getRequest().getParameter("human");
String content = mySmartUpload.getRequest().getParameter("content");

String fileKind_chain=mySmartUpload.getRequest().getParameter("fileKind_chain");
String chain_id=Divide1.getId(fileKind_chain);
String chain_name=Divide1.getName(fileKind_chain);


if(human!=null&&!human.equals("")){
	StringTokenizer tokenTO1 = new StringTokenizer(human,"/");        
            while(tokenTO1.hasMoreTokens()) {
                human_ID = tokenTO1.nextToken();
				human_name = tokenTO1.nextToken();
		}
		String sql2="select * from hr_file where human_ID='"+human_ID+"'";
		ResultSet rs2=oa_db.executeQuery(sql2);
		if(rs2.next()){
			chain_id=rs2.getString("chain_id");
			chain_name=rs2.getString("chain_name");
			
		}
}	
	String sqla = "insert into oa_planing(register,register_ID,register_time,planing_ID,subject,meeting_subject,type,begin_time,end_time,content,chain_id,chain_name,human_ID,human_name";
	String sqlb = ") values ('"+register+"','"+register_ID+"','"+register_time+"','"+planing_ID+"','"+subject+"','"+meeting_subject+"','"+planing_type+"','"+begin_time+"','"+end_time+"','"+content+"','"+chain_id+"','"+chain_name+"','"+human_ID+"','"+human_name+"'" ;
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	int p=i+1;
	sqla=sqla+",attachment"+p;
	sqlb=sqlb+",'"+file_name[i]+"'";
}
String sql=sqla+sqlb+")";
	oa_db.executeUpdate(sql) ;
	String sql2="delete from oa_planing where id='"+id+"'";
	oa_db.executeUpdate(sql2) ;

List rsList = GetWorkflow.getList(oa_db, "oa_config_workflow", "01");	
   if(rsList.size()==0){


sql2="update oa_planing set check_tag='1' where planing_ID='"+planing_ID+"'";
oa_db.executeUpdate(sql2) ;
}else{


Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into oa_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+planing_ID+"','"+elem[1]+"','"+elem[2]+"','01')" ;
		oa_db.executeUpdate(sql);
}
}

response.sendRedirect("oa/planing/register_ok_b.jsp");
}
}catch(Exception ex){
	response.sendRedirect("oa/planing/register_ok_c.jsp?meeting_subject="+meeting_subject);
	}

oa_db.commit();
oa_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){ex.printStackTrace();}
}
}