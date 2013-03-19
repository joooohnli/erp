/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package document.module.main;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import include.nseer_db.*;
import include.nseer_cookie.*;
import java.io.*;
import java.util.*;
import java.text.*;
import com.jspsmart.upload.*;
import validata.ValidataNumber;

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
nseer_db_backup1 document_db = new nseer_db_backup1(dbApplication);
if(document_db.conn((String)dbSession.getAttribute("unit_db_name"))){
adddHref adddHref=new adddHref(dbApplication);
analyseString ana=new analyseString();

mySmartUpload.initialize(pageContext);
String file_type=getFileLength.getFileType((String)session.getAttribute("unit_db_name"));
long d=getFileLength.getFileLength((String)session.getAttribute("unit_db_name"));
mySmartUpload.setMaxFileSize(d);
mySmartUpload.setAllowedFilesList(file_type);
try{
mySmartUpload.upload();
String[] file_name=new String[mySmartUpload.getFiles().getCount()];
int j=0;
String value=mySmartUpload.getRequest().getParameter("value");
String reason=mySmartUpload.getRequest().getParameter("reason");
String main_code=mySmartUpload.getRequest().getParameter("main_code");
String first_kind_ID_bi=value+"分析";
String first_kind_name_bi=reason;
String multilanguage=reason+"Tree";
String mains=reason;
String value1=reason+"/"+value;
String main_picture=mySmartUpload.getRequest().getParameter("main_picture");
String picture_name="";
String picture_ext="";
StringTokenizer tokenTO = new StringTokenizer(main_picture,".");
			while (tokenTO.hasMoreTokens()) {
				picture_name = tokenTO.nextToken();
				picture_ext = tokenTO.nextToken();
			}
String picture=reason+"."+picture_ext;
java.io.File file=new java.io.File(path+reason);
java.io.File file_bi=new java.io.File(path+"bi/"+reason);
java.io.File file_include=new java.io.File(path+reason+"/include");
java.io.File file_help=new java.io.File(path+reason+"/help");
java.io.File file_include_images=new java.io.File(path+reason+"/include/images");
java.io.File file1=new java.io.File(path+"WEB-INF/src/"+reason);
ValidataNumber validata=new ValidataNumber();

if(validata.validata(main_code)&&main_code.length()==2) {

String sqll="select * from document_main where kind='模块' and (value='"+value+"' or reason='"+reason+"' or main_code='"+main_code+"')";
ResultSet rs=document_db.executeQuery(sqll);
if(rs.next()||file.exists()||file1.exists()||!ana.common(reason)){
	response.sendRedirect("document/module/main/register_ok_a.jsp");
}else{
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	com.jspsmart.upload.SmartFile filea = mySmartUpload.getFiles().getFile(i);
	if (filea.isMissing()){
		file_name[i]="";
		continue;
	}
	int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"documentAttachmentcount");
	count.write((String)dbSession.getAttribute("unit_db_name"),"documentAttachmentcount",filenum);
	file_name[i]=filenum+filea.getFileName();
	filea.saveAs(path+"document\\file_attachments\\" + filenum+filea.getFileName());
}

String topic=mySmartUpload.getRequest().getParameter("topic");
if(topic.indexOf("***")!=-1) j++;
String topic1=topic;
topic=adddHref.adddHref((String)dbSession.getAttribute("unit_db_name"),topic);
if(topic.equals("falsefalse")) j++;
String bodyaa = new String(mySmartUpload.getRequest().getParameter("doc_id").getBytes("UTF-8"),"UTF-8");
String doc_id=exchange.toHtml(bodyaa);
if(doc_id.indexOf("***")!=-1) j++;
String doc_id1=doc_id;
doc_id=adddHref.adddHref((String)dbSession.getAttribute("unit_db_name"),doc_id);
if(doc_id.equals("falsefalse")) j++;
String bodyab = new String(mySmartUpload.getRequest().getParameter("doc_ver").getBytes("UTF-8"),"UTF-8");
String doc_ver=exchange.toHtml(bodyab);
if(doc_ver.indexOf("***")!=-1) j++;
String doc_ver1=doc_ver;
doc_ver=adddHref.adddHref((String)dbSession.getAttribute("unit_db_name"),doc_ver);
if(doc_ver.equals("falsefalse")) j++;
String bodya = new String(mySmartUpload.getRequest().getParameter("object").getBytes("UTF-8"),"UTF-8");
String object=exchange.toHtml(bodya);
if(object.indexOf("***")!=-1) j++;
String object1=object;
object=adddHref.adddHref((String)dbSession.getAttribute("unit_db_name"),object);
if(object.equals("falsefalse")) j++;
String bodyb = new String(mySmartUpload.getRequest().getParameter("range").getBytes("UTF-8"),"UTF-8");
String range=exchange.toHtml(bodyb);
if(range.indexOf("***")!=-1) j++;
String range1=range;
range=adddHref.adddHref((String)dbSession.getAttribute("unit_db_name"),range);
if(range.equals("falsefalse")) j++;
String bodyc = new String(mySmartUpload.getRequest().getParameter("reader").getBytes("UTF-8"),"UTF-8");
String reader=exchange.toHtml(bodyc);
if(reader.indexOf("***")!=-1) j++;
String reader1=reader;
reader=adddHref.adddHref((String)dbSession.getAttribute("unit_db_name"),reader);
if(reader.equals("falsefalse")) j++;
String bodyd = new String(mySmartUpload.getRequest().getParameter("reference").getBytes("UTF-8"),"UTF-8");
String reference=exchange.toHtml(bodyd);
if(reference.indexOf("***")!=-1) j++;
String reference1=reference;
reference=adddHref.adddHref((String)dbSession.getAttribute("unit_db_name"),reference);
if(reference.equals("falsefalse")) j++;
String comment="详见<a href=javascript:winopen(&#39;../../comment/query_locate.jsp&#39;)>术语与缩写解释管理</a>";
String bodyf = new String(mySmartUpload.getRequest().getParameter("function").getBytes("UTF-8"),"UTF-8");
String function=exchange.toHtml(bodyf);
if(function.indexOf("***")!=-1) j++;
String function1=function;
function=adddHref.adddHref((String)dbSession.getAttribute("unit_db_name"),function);
if(function.equals("falsefalse")) j++;
String bodyg = new String(mySmartUpload.getRequest().getParameter("filesystem").getBytes("UTF-8"),"UTF-8");
String filesystem=exchange.toHtml(bodyg);
if(filesystem.indexOf("***")!=-1) j++;
String filesystem1=filesystem;
filesystem=adddHref.adddHref((String)dbSession.getAttribute("unit_db_name"),filesystem);
if(filesystem.equals("falsefalse")) j++;
String bodyh = new String(mySmartUpload.getRequest().getParameter("dbsystem").getBytes("UTF-8"),"UTF-8");
String dbsystem=exchange.toHtml(bodyh);
if(dbsystem.indexOf("***")!=-1) j++;
String dbsystem1=dbsystem;
dbsystem=adddHref.adddHref((String)dbSession.getAttribute("unit_db_name"),dbsystem);
if(dbsystem.equals("falsefalse")) j++;
String bodyn = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyn);
if(remark.indexOf("***")!=-1) j++;
String remark1=remark;
remark=adddHref.adddHref((String)dbSession.getAttribute("unit_db_name"),remark);
if(remark.equals("falsefalse")) j++;

if(j!=0){
	response.sendRedirect("document/module/main/register_ok_c.jsp");
}else{
String operator=(String)session.getAttribute("realeditorc");
java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
	String sqla = "insert into document_main(main_code,value,reason,kind,value1,register,register_time,topic,doc_id,doc_ver,object,range,reader,reference,comment,function,filesystem,dbsystem,remark,mains,picture";
	String sqlb = ") values ('"+main_code+"','"+value+"','"+reason+"','模块','"+value1+"','"+operator+"','"+time+"','"+topic+"','"+doc_id+"','"+doc_ver+"','"+object+"','"+range+"','"+reader+"','"+reference+"','"+comment+"','"+function+"','"+filesystem+"','"+dbsystem+"','"+remark+"','"+mains+"','"+picture+"'" ;
	String sqla1 = "insert into document_main_temp(main_code,value,reason,kind,value1,register,register_time,topic,doc_id,doc_ver,object,range,reader,reference,comment,function,filesystem,dbsystem,remark,mains,picture";
	String sqlb1 = ") values ('"+main_code+"','"+value+"','"+reason+"','模块','"+value1+"','"+operator+"','"+time+"','"+topic1+"','"+doc_id1+"','"+doc_ver1+"','"+object1+"','"+range1+"','"+reader1+"','"+reference1+"','"+comment+"','"+function1+"','"+filesystem1+"','"+dbsystem1+"','"+remark1+"','"+mains+"','"+picture+"'" ;
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	int p=i+1;
	sqla=sqla+",attachment"+p;
	sqlb=sqlb+",'"+file_name[i]+"'";
	sqla1=sqla1+",attachment"+p;
	sqlb1=sqlb1+",'"+file_name[i]+"'";
}
String sql=sqla+sqlb+")";
String sql2=sqla1+sqlb1+")";
	document_db.executeUpdate(sql) ;
	document_db.executeUpdate(sql2) ;
	String sql3 = "insert into document_first(main_code,first_code,main_kind_ID,main_kind_name) values('"+main_code+"','2','"+value+"','"+reason+"')" ;
    	document_db.executeUpdate(sql3) ;
	String sql33 = "insert into document_first_temp(main_code,first_code,main_kind_ID,main_kind_name) values('"+main_code+"','2','"+value+"','"+reason+"')" ;
    	document_db.executeUpdate(sql33) ;
	sql3 = "insert into document_first(first_kind_ID,first_kind_name,main_kind_ID,main_kind_name,picture) values('"+first_kind_ID_bi+"','"+first_kind_name_bi+"','商业智能','bi','bi.gif')" ;
	    document_db.executeUpdate(sql3) ;
	sql33 = "insert into document_first_temp(first_kind_ID,first_kind_name,main_kind_ID,main_kind_name,picture) values('"+first_kind_ID_bi+"','"+first_kind_name_bi+"','商业智能','bi','bi.gif')" ;
	    document_db.executeUpdate(sql33) ;
	String sql6 = "insert into document_maintest(value,reason,value1,function,attachment1,attachment2) values('"+value+"','"+reason+"','"+value1+"','"+function+"','"+file_name[0]+"','"+file_name[1]+"')" ;
    	document_db.executeUpdate(sql6) ;
	String sql66 = "insert into document_maintest_temp(value,reason,value1,function,attachment1,attachment2) values('"+value+"','"+reason+"','"+value1+"','"+function+"','"+file_name[0]+"','"+file_name[1]+"')" ;
    	document_db.executeUpdate(sql66) ;

	String sql4="CREATE TABLE "+reason+"_allright(id int(11) NOT NULL auto_increment,TREE_ID varchar(10) NOT NULL default '',HUMAN_ID varchar(30) NOT NULL default '',NAME varchar(10) NOT NULL default '',MAIN varchar(100) NOT NULL default '',SECONDARY varchar(100) NOT NULL default '',THIRD varchar(100) NOT NULL default '',FOURTH varchar(100) NOT NULL default '',PRIMARY KEY  (id))TYPE=MyISAM";
		document_db.executeUpdate(sql4) ;
		String sql5="CREATE TABLE "+reason+"_tree(id int(11) NOT NULL auto_increment,TREE_ID varchar(10) NOT NULL default '',MAIN varchar(100) NOT NULL default '',MAINURL varchar(100) NOT NULL default '',SECONDARY varchar(100) NOT NULL default '',SECONDURL varchar(100) NOT NULL default '',THIRD varchar(100) NOT NULL default '',THIRDURL varchar(100) NOT NULL default '',FOURTH varchar(100) NOT NULL default '',FOURTHURL varchar(100) NOT NULL default '',reserved_tag tinyint(3) NOT NULL default '0',PRIMARY KEY  (id))TYPE=MyISAM";
		document_db.executeUpdate(sql5) ;
		sql5="CREATE TABLE "+reason+"_view(id int(3) NOT NULL auto_increment,MODULE_NAME varchar(200) NOT NULL DEFAULT '' ,CATEGORY_ID int(20) NOT NULL DEFAULT '0' ,PARENT_CATEGORY_ID int(20) NOT NULL DEFAULT '0' ,ACTIVE_STATUS varchar(4) NOT NULL DEFAULT 'Y' ,HREFLINK varchar(100) NOT NULL DEFAULT '' ,HUMAN_ID varchar(200) ,NAME varchar(200) ,PRIMARY KEY (id))TYPE=MyISAM";
		document_db.executeUpdate(sql5) ;
		String sqlm = "insert into document_multilanguage(tablename,name) values('"+multilanguage+"','"+reason+"')" ;
    	document_db.executeUpdate(sqlm) ;
		Hashtable tt=new Hashtable();
		tt.put(multilanguage,reason);
		String sqlm1="select type_name from document_config_public_char where kind='语言类型'";

ResultSet rsm1=document_db.executeQuery(sqlm1);
String lang="";
while(rsm1.next()){
	lang=rsm1.getString("type_name");
	String key="multilanguage_"+multilanguage+"_"+lang;
	context.setAttribute(key,tt);
}
			file.mkdirs();
			file_bi.mkdirs();
			file1.mkdirs();
			file_include.mkdirs();
			file_help.mkdirs();
			file_include_images.mkdirs();
	copyFile cp = new copyFile(path+"extend_src/main_picture/"+main_picture,path+"images/"+reason+"."+picture_ext);
	cp.setMakeDirs(false);
	cp.copy();
	cp = new copyFile(path+"extend_src/main_picture/"+picture_name+"1."+picture_ext,path+"images/"+reason+"1."+picture_ext);
	cp.setMakeDirs(false);
	cp.copy();
	cp = new copyFile(path+"extend_src/include/index_middle.jsp",path+reason+"/include/index_middle.jsp");
	cp.setMakeDirs(false);
	cp.copy();
	cp = new copyFile(path+"extend_src/include/index_middle1.jsp",path+reason+"/include/index_middle1.jsp");
	cp.setMakeDirs(false);
	cp.copy();
	cp = new copyFile(path+"extend_src/include/index_right.jsp",path+reason+"/include/index_right.jsp");
	cp.setMakeDirs(false);
	cp.copy();
	cp = new copyFile(path+"extend_src/include/left.jsp",path+reason+"/include/left.jsp");
	cp.setMakeDirs(false);
	cp.copy();
	cp = new copyFile(path+"extend_src/include/head.jsp",path+reason+"/include/head.jsp");
	cp.setMakeDirs(false);
	cp.copy();
	cp = new copyFile(path+"extend_src/include/head1.jsp",path+reason+"/include/head1.jsp");
	cp.setMakeDirs(false);
	cp.copy();
	cp = new copyFile(path+"extend_src/include/error_repeat_submit.htm",path+reason+"/include/error_repeat_submit.htm");
	cp.setMakeDirs(false);
	cp.copy();
    cp = new copyFile(path+"extend_src/first_picture/help.gif",path+reason+"/include/images/helpProgram.gif");
	cp.setMakeDirs(false);
	cp.copy();
	cp = new copyFile(path+"extend_src/first_picture/help1.gif",path+reason+"/include/images/helpProgram1.gif");
	cp.setMakeDirs(false);
	cp.copy();
	cp = new copyFile(path+"extend_src/first_picture/bi.gif",path+"bi/include/images/bi.gif");
	cp.setMakeDirs(false);
	cp.copy();
	cp = new copyFile(path+"extend_src/first_picture/bi1.gif",path+"bi/include/images/bi1.gif");
	cp.setMakeDirs(false);
	cp.copy();
response.sendRedirect("document/module/main/register_ok_b.jsp");
}
}

} else{
response.sendRedirect("document/module/main/register_ok_d.jsp");
}
}catch(Exception ex){
response.sendRedirect("document/module/main/register_ok_e.jsp");
}
document_db.commit();
document_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}