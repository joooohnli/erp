/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package oa.publicize;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import include.nseer_db.*;
import include.nseer_cookie.*;
import java.io.*;
import com.jspsmart.upload.*;
import java.util.*;
import include.nseer_cookie.Divide1;

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
nseer_db_backup1 oa_db = new nseer_db_backup1(dbApplication);
if(oa_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String publicize_ID =request.getParameter("publicize_ID");
mySmartUpload.initialize(pageContext);
String file_type=getFileLength.getFileType((String)session.getAttribute("unit_db_name"));
long d=getFileLength.getFileLength((String)session.getAttribute("unit_db_name"));
mySmartUpload.setMaxFileSize(d);
mySmartUpload.setAllowedFilesList(file_type);
try{
mySmartUpload.upload();
String[] file_name=new String[mySmartUpload.getFiles().getCount()];
String[] not_change=new String[mySmartUpload.getFiles().getCount()];


String fileKind_chain=mySmartUpload.getRequest().getParameter("fileKind_chain");
String chain_id=Divide1.getId(fileKind_chain);
String chain_name=Divide1.getName(fileKind_chain);

String sql1="select * from oa_publicize where publicize_ID='"+publicize_ID+"' and check_tag='1'";
ResultSet rs=oa_db.executeQuery(sql1);
if(!rs.next()){
	
	response.sendRedirect("oa/publicize/change_ok_a.jsp?publicize_ID="+publicize_ID+"");
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
	int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"documentAttachmentcount");
	count.write((String)dbSession.getAttribute("unit_db_name"),"documentAttachmentcount",filenum);
	file_name[i]=filenum+file.getFileName();
	file.saveAs(path+"oa\\file_attachments\\" + filenum+file.getFileName());
}
String changer = mySmartUpload.getRequest().getParameter("changer");
String changer_ID = mySmartUpload.getRequest().getParameter("changer_ID");
String change_time = mySmartUpload.getRequest().getParameter("change_time");
String content = mySmartUpload.getRequest().getParameter("content");
String bodyab = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyab);
String lately_change_time=mySmartUpload.getRequest().getParameter("lately_change_time") ;
String file_change_amount=mySmartUpload.getRequest().getParameter("change_amount") ;
int change_amount=Integer.parseInt(file_change_amount)+1;
String sql3="select * from oa_publicize where publicize_ID='"+publicize_ID+"'";
	ResultSet rs3=oa_db.executeQuery(sql3);
	if(rs3.next()){
		String sql4="insert into oa_publicize_dig(publicize_ID,subject,type,chain_id,chain_name,CONTENT,attachment1,attachment2,remark,register,register_ID,CHECKER,CHECKER_ID,CHANGER,CHANGER_ID,register_TIME,CHECK_TIME,CHANGE_TIME,LATELY_CHANGE_TIME,change_amount,CHECK_TAG) values('"+rs3.getString("publicize_ID")+"','"+rs3.getString("subject")+"','"+rs3.getString("type")+"','"+rs3.getString("chain_id")+"','"+rs3.getString("chain_name")+"','"+rs3.getString("CONTENT")+"','"+rs3.getString("attachment1")+"','"+rs3.getString("attachment2")+"','"+rs3.getString("remark")+"','"+rs3.getString("register")+"','"+rs3.getString("register_ID")+"','"+rs3.getString("CHECKER")+"','"+rs3.getString("CHECKER_ID")+"','"+rs3.getString("CHANGER")+"','"+rs3.getString("CHANGER_ID")+"','"+rs3.getString("register_TIME")+"','"+rs3.getString("CHECK_TIME")+"','"+rs3.getString("CHANGE_TIME")+"','"+rs3.getString("LATELY_CHANGE_TIME")+"','"+rs3.getString("change_amount")+"','"+rs3.getString("CHECK_TAG")+"')";
		oa_db.executeUpdate(sql4) ;
	}

List rsList = GetWorkflow.getList(oa_db, "oa_config_workflow", "02");
	String[] elem=new String[3];
	if(rsList.size()==0){

	String sqla = "update oa_publicize set changer='"+changer+"',changer_ID='"+changer_ID+"',change_time='"+change_time+"',content='"+content+"',remark='"+remark+"',lately_change_time='"+lately_change_time+"',change_amount='"+change_amount+"',chain_id='"+chain_id+"',chain_name='"+chain_name+"',check_tag='1'";
	String sqlb = " where publicize_ID='"+publicize_ID+"'" ;
if(attachment!=null){
for(int i=0;i<attachment.length;i++){
	sqla=sqla+","+attachment[i]+"=''";
	java.io.File file=new java.io.File(path+"oa\\file_attachments\\"+delete_file_name[i]);
	file.delete();
}
}
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	if(not_change[i]!=null&&not_change[i].equals("yes")) continue;
	int p=i+1;
	sqla=sqla+",attachment"+p+"='"+file_name[i]+"'";
}
String sql=sqla+sqlb;
	oa_db.executeUpdate(sql) ;
	}else{
String sql2="delete from oa_workflow where object_ID='"+publicize_ID+"' and type_id='02'";
		oa_db.executeUpdate(sql2) ;
		
String sqla = "update oa_publicize set changer='"+changer+"',changer_ID='"+changer_ID+"',change_time='"+change_time+"',content='"+content+"',remark='"+remark+"',lately_change_time='"+lately_change_time+"',change_amount='"+change_amount+"',chain_id='"+chain_id+"',chain_name='"+chain_name+"',check_tag='0'";
	String sqlb = " where publicize_ID='"+publicize_ID+"'" ;
if(attachment!=null){
for(int i=0;i<attachment.length;i++){
	sqla=sqla+","+attachment[i]+"=''";
	java.io.File file=new java.io.File(path+"oa\\file_attachments\\"+delete_file_name[i]);
	file.delete();
}
}
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	if(not_change[i]!=null&&not_change[i].equals("yes")) continue;
	int p=i+1;
	sqla=sqla+",attachment"+p+"='"+file_name[i]+"'";
}
String sql=sqla+sqlb;
	oa_db.executeUpdate(sql) ;

		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql2 = "insert into oa_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+publicize_ID+"','"+elem[1]+"','"+elem[2]+"','02')" ;
		oa_db.executeUpdate(sql2) ;
		}
	}

response.sendRedirect("oa/publicize/change_ok_b.jsp");
}
}catch(Exception ex){
response.sendRedirect("oa/publicize/change_ok_c.jsp?publicize_ID="+publicize_ID);
}
oa_db.commit();
oa_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}