/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package design.export;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.* ;
import include.excel_export.excel;
import include.excel_export.excel_three;
import include.excel_export.XlsWriter;
import include.get_sql.getKeyColumn;

public class excel_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

ServletContext application;
HttpSession session=request.getSession();
XlsWriter xls=new XlsWriter((String)dbSession.getAttribute("unit_db_name"),"xml/design/excel_export.xml");
excel query=new excel();
excel_three query_three=new excel_three();
getKeyColumn column=new getKeyColumn();

try{
String sql="";
String tablename="";
String table=(String)session.getAttribute("table");
String realname=(String)session.getAttribute("realeditorc");
String timea=(String)session.getAttribute("timea");
String timeb=(String)session.getAttribute("timeb");
String type=(String)session.getAttribute("type");
String first_kind_name=(String)session.getAttribute("first_kind_name");
String second_kind_name=(String)session.getAttribute("second_kind_name");
String third_kind_name=(String)session.getAttribute("third_kind_name");
String responsible_person_name=(String)session.getAttribute("responsible_person_name");
String sql_search=(String)session.getAttribute("sql_search");
if(table.equals("\u4ea7\u54c1\u6863\u6848")){
String dbase=(String)dbSession.getAttribute("unit_db_name");
tablename="design_file";
String fieldName1="register_time";
String fieldName2="first_kind_name";
String fieldName3="third_kind_name";
String fieldName4="second_kind_name";
String fieldName5="responsible_person_name";
String condition="";
if(type.equals("111")){
	condition="check_tag='1'";
}else{
	condition="check_tag='1' and type='"+type+"'";
}
String queue="order by register_time";
sql=query.query(dbase,tablename,timea,timeb,first_kind_name,second_kind_name,third_kind_name,responsible_person_name,fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition,queue,realname);
}
if(sql_search==null){
int a=sql.indexOf("where");
sql=sql.substring(a,sql.length());

xls.setCondition(sql);
}else{
	session.removeAttribute("sql_search");
	xls.setCondition(sql_search.substring(sql_search.indexOf("where")));
}
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
xls.write(path+"excel_files/design_data.xls");
response.sendRedirect("design/export/excel_ok_a.jsp");

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 