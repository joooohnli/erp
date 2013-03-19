/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.export;


import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.* ;
import include.excel_export.XlsWriter;
import include.excel_export.excel;
import include.excel_export.excel_three;
import include.get_sql.getKeyColumn;


public class excel_ok extends HttpServlet{
//创建方法

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


try{

HttpSession session=request.getSession();
PrintWriter out=response.getWriter();

XlsWriter xls=new XlsWriter();
excel  query=new excel();
excel_three query_three=new  excel_three();
getKeyColumn column=new getKeyColumn();


xls.setDatabase((String)dbSession.getAttribute("unit_db_name"));
xls.setConfigFile("xml/hr/excel_export.xml");

String sql="";
String tablename="";
String realname=(String)session.getAttribute("realeditorc");
String table=(String)session.getAttribute("table");
String timea=(String)session.getAttribute("timea");
String timeb=(String)session.getAttribute("timeb");
String first_kind_name=(String)session.getAttribute("first_kind_name");
String second_kind_name=(String)session.getAttribute("second_kind_name");
String third_kind_name=(String)session.getAttribute("third_kind_name");
String second_kind_ID=(String)session.getAttribute("second_kind_ID");
String keyword=(String)session.getAttribute("keyword");
if(table.equals("人力资源档案")){
String dbase=(String)dbSession.getAttribute("unit_db_name");
tablename="hr_file";
String fieldName1="register_time";
String fieldName2="first_kind_name";
String fieldName3="third_kind_name";
String fieldName4="second_kind_name";
String fieldName5="human_name";
String condition="check_tag='1'";
String queue="order by register_time";
sql=query.query(dbase,tablename,timea,timeb,first_kind_name,second_kind_name,third_kind_name,"",fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition,queue,realname);
}else{
String dbase=(String)dbSession.getAttribute("unit_db_name");
tablename="hr_questiones";
String fieldName1="register_time";
String[] fieldName3=column.Column(dbase,tablename);
String queue="order by register_time";
String condition="check_tag='0' and excel_tag='2'";
String fieldName2="";
if(!first_kind_name.equals("")&&second_kind_name.equals("")){
		fieldName2="first_kind_name";
sql=query_three.query(dbase,tablename,timea,timeb,first_kind_name,keyword,fieldName1,fieldName2,fieldName3,condition,queue);
}else{
	fieldName2="second_kind_name";
sql=query_three.query(dbase,tablename,timea,timeb,second_kind_name,keyword,fieldName1,fieldName2,fieldName3,condition,queue);
}
}
int a=sql.indexOf("where");
sql=sql.substring(a,sql.length());
xls.setCondition(sql);
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
xls.write(path+"excel_files/hr_data.xls");




response.sendRedirect("hr/export/excel_ok_a.jsp");

}catch(Exception ex){}
}
}
