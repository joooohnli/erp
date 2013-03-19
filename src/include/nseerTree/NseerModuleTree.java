package include.nseerTree;



import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import include.nseer_db.*;
import include.nseer_cookie.*;
import include.operateXML.*;
import include.tree_index.Nseer;

import java.io.*;
import java.util.*;
import java.text.*;
import com.jspsmart.upload.*;
import validata.ValidataNumber;
import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;


public class NseerModuleTree {

WebContext ctx = WebContextFactory.get();
HttpServletRequest request = ctx.getHttpServletRequest();//用DWR的对象创建request.
HttpSession session = ctx.getSession();//用DWR的对象创建session.
ServletContext application = session.getServletContext();//用session的对象创建application.
ServletContext context=session.getServletContext();//用session的对象创建context.
private String return_msg="";

public NseerModuleTree() {
    }

public String addMainModule(String module_value, String module_reason,String module_main_code,String module_main_picture) {

try{
//实例化
String path=application.getRealPath("/");//得路径.
analyseString ana=new analyseString();//这个类主要是判断是否有非法字符.
Nseer n=new Nseer();
nseer_db_backup1 document_db = new nseer_db_backup1(application);
nseer_db_backup1 document_db1 = new nseer_db_backup1(application);

if(document_db.conn((String)session.getAttribute("unit_db_name"))&&document_db1.conn((String)session.getAttribute("unit_db_name"))){//创建连接.
try{

String value=module_value;//模块中文名称.
String reason=module_reason;//模块英文名称.
String main_code=module_main_code;//模块编号.
String multilanguage=reason+"Tree";//生成TREE的名称.
String mains=reason;
String main_picture=module_main_picture;//模块图片名称.

java.io.File file=new java.io.File(path+reason);//文件目录.
java.io.File file_include=new java.io.File(path+reason+"/include");
java.io.File file_include_images=new java.io.File(path+reason+"/include/images");
java.io.File file1=new java.io.File(path+"WEB-INF/src/"+reason);
java.io.File file2=new java.io.File(path+"xml/"+reason);
ValidataNumber validata=new ValidataNumber();
if(validata.validata(main_code)&&main_code.length()==2){//判断长度是否为2.
//]
String sqll="select * from document_main where value='"+value+"' or reason='"+reason+"' or main_code='"+main_code+"'";//查询数据库,是否有重覆记录.
ResultSet rs=document_db.executeQuery(sqll);
if(rs.next()||file.exists()||file1.exists()||!ana.common(reason)){//判断是否有文件夹存在.
return_msg="英文名称有误、该主模块编号重复或者该主模块已完成初始，请返回确认！";
//response.sendRedirect("document/module/main/register_ok_a.jsp");
}else{
/******为操作erp_update_d表做准备**********/
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
Double c_ver=0.00;
String sql_update="select ver from erp_update_t order by ver desc";
ResultSet rs_update=document_db.executeQuery(sql_update);
if(rs_update.next()){c_ver=rs_update.getDouble("ver");}
/****************/
String sqla = "insert into document_main(value,reason,main_code,picture) values ('"+value+"','"+reason+"','"+main_code+"','"+main_picture+"')";//插入主模块表
document_db.executeUpdate(sqla);
/*****在erp_update_d表中插入一条记录********/
sql_update="select id from document_main where value='"+value+"' and reason='"+reason+"' and main_code='"+main_code+"' and picture='"+main_picture+"' order by id desc";
rs_update=document_db.executeQuery(sql_update);
if(rs_update.next()){
sql_update = "insert into erp_update_d(t_name,cols_name,cols_value,ver,register_time,row_id) values('document_main','㊣value㊣reason㊣main_code㊣picture','㊣"+value+"㊣"+reason+"㊣"+main_code+"㊣"+main_picture+"','"+c_ver+"','"+time+"','"+rs_update.getString("id")+"')";
document_db.executeUpdate(sql_update);
/*****************************************/
}
document_db1.commit();
document_db1.close();//关闭连接
document_db.commit();
document_db.close();

/*
String sql5="CREATE TABLE "+reason+"_tree (`id` int(10) unsigned NOT NULL auto_increment,`MODULE_NAME` varchar(200) NOT NULL default '',`CATEGORY_ID` int(20) NOT NULL default '0',`PARENT_CATEGORY_ID` int(20) NOT NULL default '0',`ACTIVE_STATUS` varchar(4) NOT NULL default 'Y',`HREFLINK` varchar(100) NOT NULL default '',PRIMARY KEY  (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;";
*/
//在对应的xml文件目录体系中创建与模块名同名的主xml文件
file2.mkdirs();
String xmlpath=path+"xml\\"+reason+"\\"+reason+".xml";
OutputStreamWriter out = new OutputStreamWriter(new FileOutputStream(xmlpath),"UTF-8");
out.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
out.write("<config>\n");
out.write("\t<table nick=\""+value+"\" name=\""+reason+"\">\n");
out.write("\t\t<column nick=\""+reason+"_tree\" name=\""+reason+"_tree\" service=\"t\" />\n");
out.write("\t\t<column nick=\""+reason+"_view\" name=\""+reason+"_view\" service=\"t\" />\n");
out.write("\t</table>\n");
out.write("</config>\n");
out.flush();
out.close();
String sql5="CREATE TABLE "+reason+"_tree (`id` int(10) unsigned NOT NULL auto_increment,`MODULE_NAME` varchar(200) NOT NULL default '',`reason` varchar(200) NOT NULL default '',`CATEGORY_ID` int(20) NOT NULL default '0',`PARENT_CATEGORY_ID` int(20) NOT NULL default '0',`ACTIVE_STATUS` varchar(4) NOT NULL default 'Y',`HREFLINK` varchar(100) NOT NULL default '',`FILE_ID` varchar(200) default '',`FILE_NAME` varchar(200) default '',`DETAILS_TAG` int(2) NOT NULL default '0',`FILE_PATH` varchar(200) NOT NULL default '',`CHAIN_NAME` text NOT NULL default '',`PICTURE` varchar(200) NOT NULL default '',`WORKFLOW_TAG` int(1) unsigned NOT NULL default '0',`RESERVED_TAG` int(1) unsigned NOT NULL default '0',PRIMARY KEY  (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;";//生成tree表
document_db.executeUpdate(sql5) ;//开始执行sql
/********插入记录到erp_update_t表*********/
String sql_t="describe "+reason+"_tree";
ResultSet rs_t=document_db.executeQuery(sql_t);
while(rs_t.next()){
String sql_t1="insert into erp_update_t(t_name,col_name,type,default_value,xml_tag,t_nick,col_nick,ver,register_time) values ('"+reason+"_tree','"+rs_t.getString("field").toLowerCase()+"','"+rs_t.getString("type")+"','"+rs_t.getString("default")+"','no','"+reason+"_tree','"+rs_t.getString("field").toLowerCase()+"','"+c_ver+"','"+time+"')";
document_db1.executeUpdate(sql_t1,true);
}
sql_t="select * from erp_update_t where t_name='"+reason+"_tree' and col_name='id'";
rs_t=document_db.executeQuery(sql_t);

/**************************************/
String sql51="insert into "+reason+"_tree (module_name,category_id,parent_category_id,active_status,hreflink,file_path,chain_name,picture,file_id,file_name)VALUES('"+main_code+value+"', 0, -1, 'Y','"+""+"','"+""+"','"+value+"','"+""+"','"+main_code+"','"+value+"')";
document_db.executeUpdate(sql51);//插入初始记录
/*****在erp_update_d表中插入一条记录********/
sql_update="select id from "+reason+"_tree where module_name='"+main_code+value+"' and category_id='0' and parent_category_id='-1' and active_status='Y' and hreflink='"+""+"' and file_path='"+""+"' and chain_name='"+value+"' and picture='"+""+"' and file_id='"+main_code+"' and file_name='"+value+"' order by id desc";
rs_update=document_db.executeQuery(sql_update);
if(rs_update.next()){
sql_update = "insert into erp_update_d(t_name,cols_name,cols_value,ver,register_time,row_id) values('"+reason+"_tree','㊣module_name㊣category_id㊣parent_category_id㊣active_status㊣hreflink㊣file_path㊣chain_name㊣picture㊣file_id㊣file_name','㊣"+main_code+value+"㊣0㊣-1㊣Y㊣㊣㊣"+value+"㊣㊣"+main_code+"㊣"+value+"','"+c_ver+"','"+time+"','"+rs_update.getString("id")+"')";
document_db.executeUpdate(sql_update);
}
/*****************************************/

sql5="CREATE TABLE "+reason+"_view (`id` int(10) unsigned NOT NULL auto_increment,`MODULE_NAME` varchar(200) NOT NULL default '',`reason` varchar(200) NOT NULL default '',`CATEGORY_ID` int(20) NOT NULL default '0',`PARENT_CATEGORY_ID` int(20) NOT NULL default '0',`ACTIVE_STATUS` varchar(4) NOT NULL default 'Y',`HREFLINK` varchar(100) NOT NULL default '',`FILE_ID` varchar(200) default '',`FILE_NAME` varchar(200) default '',`DETAILS_TAG` int(2) NOT NULL default '0',`HUMAN_ID` varchar(200) NOT NULL default '',`NAME` varchar(200) NOT NULL default '',`FILE_PATH` varchar(200) NOT NULL default '',`PICTURE` varchar(200) NOT NULL default '',`WORKFLOW_TAG` int(1) unsigned NOT NULL default '0',`RESERVED_TAG` int(1) unsigned NOT NULL default '0',PRIMARY KEY  (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;";
document_db.executeUpdate(sql5);//生成view表

/********插入记录到erp_update_t表*********/
sql_t="describe "+reason+"_view";
rs_t=document_db.executeQuery(sql_t);
while(rs_t.next()){
String sql_t1="insert into erp_update_t(t_name,col_name,type,default_value,xml_tag,t_nick,col_nick,ver,register_time) values ('"+reason+"_view','"+rs_t.getString("field").toLowerCase()+"','"+rs_t.getString("type")+"','"+rs_t.getString("default")+"','no','"+reason+"_view','"+rs_t.getString("field").toLowerCase()+"','"+c_ver+"','"+time+"')";
document_db1.executeUpdate(sql_t1,true);
}
/**************************************/


String sql52="insert into "+reason+"_view(module_name,category_id,parent_category_id,active_status,hreflink,human_id,name,picture,file_id,file_name)values('"+main_code+value+"', 0, -1, 'Y', '"+""+"', '"+""+"', '"+""+"','"+""+"','"+main_code+"','"+value+"')";//插入初始记录
document_db.executeUpdate(sql52);
/*****在erp_update_d表中插入一条记录********/
sql_update="select id from "+reason+"_view where module_name='"+main_code+value+"' and category_id='0' and parent_category_id='-1' and active_status='Y' and hreflink='"+""+"' and human_id='"+""+"' and name='"+""+"' and picture='"+""+"' and file_id='"+main_code+"' and file_name='"+value+"' order by id desc";
rs_update=document_db.executeQuery(sql_update);
if(rs_update.next()){
sql_update = "insert into erp_update_d(t_name,cols_name,cols_value,ver,register_time,row_id) values('"+reason+"_view','㊣module_name㊣category_id㊣parent_category_id㊣active_status㊣hreflink㊣human_id㊣name㊣picture㊣file_id㊣file_name','㊣"+main_code+value+"㊣0㊣-1㊣Y㊣㊣㊣㊣㊣"+main_code+"㊣"+value+"','"+c_ver+"','"+time+"','"+rs_update.getString("id")+"')";
document_db.executeUpdate(sql_update);
}
/*****************************************/

String sqlm = "insert into document_multilanguage(tablename,name) values('"+multilanguage+"','"+reason+"')" ;//多语种
document_db.executeUpdate(sqlm) ;
/*****在erp_update_d表中插入一条记录********/
sql_update="select id from document_multilanguage where tablename='"+multilanguage+"' and name='"+reason+"' order by id desc";
rs_update=document_db.executeQuery(sql_update);
if(rs_update.next()){
sql_update = "insert into erp_update_d(t_name,cols_name,cols_value,ver,register_time,row_id) values('document_multilanguage','㊣tablename㊣name','㊣"+multilanguage+"㊣"+reason+"','"+c_ver+"','"+time+"','"+rs_update.getString("id")+"')";
document_db.executeUpdate(sql_update);
}
/*****************************************/
Hashtable tt=new Hashtable();
tt.put(multilanguage,reason);//将多语种放入哈希表中
String sqlm1="select type_name from document_config_public_char where kind='语言类型'";//查询多语种表

ResultSet rsm1=document_db.executeQuery(sqlm1);
String lang="";
while(rsm1.next()){
	lang=rsm1.getString("type_name");
	String key="multilanguage_"+multilanguage+"_"+lang;
	context.setAttribute(key,tt);
}
//文件生成
file.mkdirs();
file1.mkdirs();
file_include.mkdirs();
file_include_images.mkdirs();


//开始执行文件拷贝
copyFile cp = new copyFile(path+"extend_src/include/index_middle.jsp",path+reason+"/include/index_middle.jsp");
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
return_msg="录入成功！";

}
} else{
return_msg="主模块编号必须为2位数字，请返回确认！";
}
}catch(Exception ex){
ex.printStackTrace();
}
}else{
	return_msg="对不起，数据库连接故障，请重试！";
}
}catch(Exception ex){ex.printStackTrace();}
  return return_msg;
}

public String selectModuleTree(String module_value){//选择主模块。得相应的表名

String tree_msg="";
try{
nseer_db_backup1 document_db = new nseer_db_backup1(application);
if(document_db.conn((String)session.getAttribute("unit_db_name"))){
String sql2="select * from erpplatform_moudle_design where value='"+module_value+"'";
ResultSet rs12=document_db.executeQuery(sql2);
if(rs12.next()){
tree_msg=rs12.getString("module_tablename");//查询出模块的表名
}
}
}catch(Exception ex){ex.printStackTrace();}
  return tree_msg;
}








/*  
public static void main(String args[]){
try{
UnZip cc = new UnZip();
cc.unZip("C:\\han.zip","C:\\888");
}catch(Exception ex){ex.printStackTrace();}
}
*/  
}
