/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.news;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.*;
import validata.ValidataNumber;
import validata.ValidataTag;
import include.get_sql.getInsertSql;
import com.jspsmart.upload.*;

public class change_ok extends HttpServlet{

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
String news_ID=request.getParameter("news_ID");
try{
mySmartUpload.upload();

String filekind_chain=mySmartUpload.getRequest().getParameter("filekind_chain");
String chain_id=Divide1.getId(filekind_chain);
String chain_name=Divide1.getName(filekind_chain);

String content = new String(mySmartUpload.getRequest().getParameter("content").getBytes("UTF-8"),"UTF-8");
String changer_ID=mySmartUpload.getRequest().getParameter("changer_ID") ;
String changer=mySmartUpload.getRequest().getParameter("changer") ;
String change_time=mySmartUpload.getRequest().getParameter("change_time") ;

String[] file_name=new String[mySmartUpload.getFiles().getCount()];
String[] not_change=new String[mySmartUpload.getFiles().getCount()];
String lately_change_time=mySmartUpload.getRequest().getParameter("lately_change_time") ;
String file_change_amount=mySmartUpload.getRequest().getParameter("file_change_amount") ;
int change_amount=Integer.parseInt(file_change_amount)+1;

if(vt.validata((String)session.getAttribute("unit_db_name"),"ecommerce_news","news_ID",news_ID,"check_tag").equals("1")){

String sqloo= "select * from ecommerce_news where news_ID='"+news_ID+"'";
	 ResultSet rsoo = ecommerce_db.executeQuery(sqloo);
	 if(rsoo.next()){
	String sqll="insert into ecommerce_news_dig(chain_id,chain_name,news_ID,topic,content,attachment1,attachment2,attachment3,opinion,CHECK_TAG,FILE_CHANGE_AMOUNT,REGISTER,CHECKER,CHANGER,REGISTER_ID,CHECKER_ID,CHANGER_ID,REGISTER_TIME,CHECK_TIME,CHANGE_TIME,LATELY_CHANGE_TIME,EXCEL_TAG) values('"+rsoo.getString("chain_id")+"','"+rsoo.getString("chain_name")+"','"+rsoo.getString("news_ID")+"','"+rsoo.getString("topic")+"','"+rsoo.getString("content")+"','"+rsoo.getString("attachment1")+"','"+rsoo.getString("attachment2")+"','"+rsoo.getString("attachment3")+"','"+rsoo.getString("opinion")+"','"+rsoo.getString("CHECK_TAG")+"','"+rsoo.getString("FILE_CHANGE_AMOUNT")+"','"+rsoo.getString("REGISTER")+"','"+rsoo.getString("CHECKER")+"','"+rsoo.getString("CHANGER")+"','"+rsoo.getString("REGISTER_ID")+"','"+rsoo.getString("CHECKER_ID")+"','"+rsoo.getString("CHANGER_ID")+"','"+rsoo.getString("REGISTER_TIME")+"','"+rsoo.getString("CHECK_TIME")+"','"+rsoo.getString("CHANGE_TIME")+"','"+rsoo.getString("LATELY_CHANGE_TIME")+"','"+rsoo.getString("EXCEL_TAG")+"')";
		ecommerce_db.executeUpdate(sqll);
	 }
String sql1="select * from ecommerce_news where news_ID='"+news_ID+"'";
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
	String sqla = "update ecommerce_news set chain_id='"+chain_id+"',chain_name='"+chain_name+"',news_ID='"+news_ID+"',content='"+content+"',check_tag='0',excel_tag='0',changer_ID='"+changer_ID+"',changer='"+changer+"',change_time='"+change_time+"',lately_change_time='"+lately_change_time+"',file_change_amount='"+change_amount+"'";
	String sqlb = " where news_ID='"+news_ID+"'" ;
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
List rsList = GetWorkflow.getList(ecommerce_db, "ecommerce_config_workflow", "07");
	String[] elem=new String[3];
if(rsList.size()==0){
		sql="update ecommerce_news set check_tag='1' where news_ID='"+news_ID+"'";
		ecommerce_db.executeUpdate(sql);
	}else{
		sql="delete from ecommerce_workflow where object_ID='"+news_ID+"'";
		ecommerce_db.executeUpdate(sql) ;
		sql="update ecommerce_news set check_tag='0' where news_ID='"+news_ID+"'";
		ecommerce_db.executeUpdate(sql) ;
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into ecommerce_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+news_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		ecommerce_db.executeUpdate(sql) ;
		}
	}
	
response.sendRedirect("ecommerce/news/change_ok_a.jsp");

}else{
response.sendRedirect("ecommerce/news/change_ok_c.jsp");
}
ecommerce_db.commit();
ecommerce_db.close();

}catch(Exception ex){
response.sendRedirect("ecommerce/news/change_ok_b.jsp?news_ID="+news_ID+"");
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