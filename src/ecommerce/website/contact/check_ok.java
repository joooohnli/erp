/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.website.contact;
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.*;
import validata.ValidataNumber;
import validata.ValidataTag;
import include.get_sql.getInsertSql;
import com.jspsmart.upload.*;

public class check_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
try{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
ServletContext application;
HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
nseer_db_backup1 ecommerce_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();
counter count=new counter(dbApplication);
getInsertSql getInsertSql=new getInsertSql();
getAttachmentLength getAttachmentLength=new getAttachmentLength();
getAttachmentType getAttachmentType=new getAttachmentType();
SmartUpload mySmartUpload=new SmartUpload();
mySmartUpload.setCharset("UTF-8");
if(ecommerce_db.conn((String)dbSession.getAttribute("unit_db_name"))){

mySmartUpload.initialize(pageContext);
String file_type=getFileLength.getFileType((String)session.getAttribute("unit_db_name"));
long d=getFileLength.getFileLength((String)session.getAttribute("unit_db_name"));
mySmartUpload.setMaxFileSize(d);
mySmartUpload.setAllowedFilesList(file_type);
String contact_ID=request.getParameter("contact_ID");
String config_ID=request.getParameter("config_ID");

try{
mySmartUpload.upload();
String filekind_chain=mySmartUpload.getRequest().getParameter("filekind_chain");
String chain_id=Divide1.getId(filekind_chain);
String chain_name=Divide1.getName(filekind_chain);
String tel=mySmartUpload.getRequest().getParameter("tel") ;
String address=mySmartUpload.getRequest().getParameter("address") ;
String fax=mySmartUpload.getRequest().getParameter("fax") ;
String postcode=mySmartUpload.getRequest().getParameter("postcode") ;
String qq1=mySmartUpload.getRequest().getParameter("qq1") ;
String qq2=mySmartUpload.getRequest().getParameter("qq2") ;
String qq3=mySmartUpload.getRequest().getParameter("qq3") ;
String qq4=mySmartUpload.getRequest().getParameter("qq4") ;
String email=mySmartUpload.getRequest().getParameter("email") ;
String checker_ID=mySmartUpload.getRequest().getParameter("checker_ID") ;
String checker=mySmartUpload.getRequest().getParameter("checker") ;
String check_time=mySmartUpload.getRequest().getParameter("check_time") ;
String[] file_name=new String[mySmartUpload.getFiles().getCount()];
String[] not_change=new String[mySmartUpload.getFiles().getCount()];

String sql6="select id from ecommerce_workflow where object_ID='"+contact_ID+"' and ((check_tag='0' and config_ID<'"+config_ID+"') or (check_tag='1' and config_ID='"+config_ID+"'))";
ResultSet rs6=ecommerce_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)session.getAttribute("unit_db_name"),"ecommerce_contact","contact_ID",contact_ID,"check_tag").equals("0")){

String sql1="select * from ecommerce_contact where contact_ID='"+contact_ID+"'";
ResultSet rs=ecommerce_db.executeQuery(sql1);
rs.next();
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
	int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"ecommerceAttachmentcount");
	count.write((String)dbSession.getAttribute("unit_db_name"),"ecommerceAttachmentcount",filenum);
	file_name[i]=filenum+file.getFileName();
	file.saveAs(path+"ecommerce/file_attachments/" + filenum+file.getFileName());
}
	String sqla = "update ecommerce_contact set chain_id='"+chain_id+"',chain_name='"+chain_name+"',email='"+email+"',tel='"+tel+"',fax='"+fax+"',address='"+address+"',postcode='"+postcode+"',qq1='"+qq1+"',qq2='"+qq2+"',qq3='"+qq3+"',qq4='"+qq4+"',checker_ID='"+checker_ID+"',checker='"+checker+"',check_time='"+check_time+"'";
	String sqlb = " where contact_ID='"+contact_ID+"'" ;
if(attachment!=null){
for(int i=0;i<attachment.length;i++){
	sqla=sqla+","+attachment[i]+"=''";
	java.io.File file=new java.io.File(path+"ecommerce/file_attachments/"+delete_file_name[i]);
	file.delete();
}
}
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	if(not_change[i]!=null&&not_change[i].equals("yes")) continue;
	int p=i+1;
	sqla=sqla+",attachment"+p+"='"+file_name[i]+"'";
}
String sql=sqla+sqlb;
	ecommerce_db.executeUpdate(sql) ;


sql = "update ecommerce_workflow set check_tag='1',checker_ID='"+checker_ID+"',checker='"+checker+"',check_time='"+check_time+"' where object_ID='"+contact_ID+"' and config_id='"+config_ID+"'" ;
ecommerce_db.executeUpdate(sql) ;
	sql6="select * from ecommerce_workflow where object_ID='"+contact_ID+"' and check_tag='0'";
	rs6=ecommerce_db.executeQuery(sql6);
	if(!rs6.next()){
		sql = "update ecommerce_contact set check_tag='1',checker_ID='"+checker_ID+"',checker='"+checker+"',check_time='"+check_time+"' where contact_ID='"+contact_ID+"'";
		ecommerce_db.executeUpdate(sql) ;
	}

response.sendRedirect("ecommerce/website/contact/check_ok.jsp?finished_tag=0");

}else{
response.sendRedirect("ecommerce/website/contact/check_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("ecommerce/website/contact/check_ok.jsp?finished_tag=2");
}
ecommerce_db.commit();
ecommerce_db.close();

}catch(Exception ex){
	response.sendRedirect("ecommerce/website/contact/check_ok_a.jsp?contact_ID="+contact_ID);
}

}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}