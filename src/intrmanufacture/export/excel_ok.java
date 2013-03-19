/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package intrmanufacture.export;
 
 
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
XlsWriter xls=new XlsWriter((String)dbSession.getAttribute("unit_db_name"),"xml/intrmanufacture/excel_export.xml");
excel query=new excel();
excel_three query_three=new excel_three();
getKeyColumn column=new getKeyColumn();

try{
String sql="";
String tablename="";
String realname=(String)session.getAttribute("realeditorc");
String table=(String)session.getAttribute("table");
String timea=(String)session.getAttribute("timea");
String timeb=(String)session.getAttribute("timeb");
String first_kind_name=(String)session.getAttribute("first_kind_name");
String second_kind_name=(String)session.getAttribute("second_kind_name");
String third_kind_name=(String)session.getAttribute("third_kind_name");
String intrmanufacturer_ID=(String)session.getAttribute("intrmanufacturer_ID");
String intrmanufacture_ID=(String)session.getAttribute("intrmanufacture_ID");
String keyword=(String)session.getAttribute("keyword");
if(table.equals("委外厂商档案")){
String dbase=(String)dbSession.getAttribute("unit_db_name");
tablename="intrmanufacture_file";
String fieldName1="register_time";
String fieldName2="first_kind_name";
String fieldName3="third_kind_name";
String fieldName4="second_kind_name";
String fieldName5="intrmanufacturer_ID";
String condition="check_tag='1'";
String queue="order by register_time";
sql=query.query(dbase,tablename,timea,timeb,first_kind_name,second_kind_name,third_kind_name,intrmanufacturer_ID,fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition,queue,realname);
}else{
if(table.equals("委外执行单")){
String dbase=(String)dbSession.getAttribute("unit_db_name");
tablename="intrmanufacture_intrmanufacture";
String fieldName1="register_time";
String fieldName2="intrmanufacture_ID";
String[] fieldName3=column.Column(dbase,tablename);
String queue="order by register_time";
String condition="check_tag='2' and excel_tag='2' and intrmanufacture_tag='2'";
sql=query_three.query(dbase,tablename,timea,timeb,intrmanufacture_ID,keyword,fieldName1,fieldName2,fieldName3,condition,queue);
}else{
String dbase=(String)session.getAttribute("unit_db_name");
tablename="intrmanufacture_discussion";
String fieldName1="register_time";
String fieldName2="first_kind_name";
String fieldName3="third_kind_name";
String fieldName4="second_kind_name";
String fieldName5="provider_ID";
String queue="order by register_time desc";
String condition="check_tag!='3' and excel_tag='2'";
sql=query.query(dbase,tablename,timea,timeb,first_kind_name,second_kind_name,third_kind_name,"",fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition,queue,realname);
}
}
int a=sql.indexOf("where");
sql=sql.substring(a,sql.length());
xls.setCondition(sql);
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
xls.write(path+"excel_files/intrmanufacture_data.xls");
response.sendRedirect("intrmanufacture/export/excel_ok_a.jsp");

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 