/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.export;


import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.*; 
import include.nseer_db.*;
import include.excel_export.XlsWriter;
import include.excel_export.excel;


public class excel_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
HttpSession session=request.getSession();
PrintWriter out=response.getWriter();

excel query=new  excel();
XlsWriter xls=new XlsWriter();
xls.setDatabase((String)dbSession.getAttribute("unit_db_name"));
xls.setConfigFile("xml/crm/excel_export.xml");


String sql="";
String tablename="";
String realname=(String)session.getAttribute("realeditorc");
String table=(String)session.getAttribute("table");
String timea=(String)session.getAttribute("timea");
String timeb=(String)session.getAttribute("timeb");
String first_kind_name=(String)session.getAttribute("first_kind_name");
String second_kind_name=(String)session.getAttribute("second_kind_name");
String third_kind_name=(String)session.getAttribute("third_kind_name");
String customer_ID=(String)session.getAttribute("customer_ID");
String customer_name=(String)session.getAttribute("customer_name");
String trade=(String)session.getAttribute("trade");
if(table.equals("?")){
String dbase=(String)dbSession.getAttribute("unit_db_name");
tablename="crm_file";
String fieldName1="register_time";
String fieldName2="first_kind_name";
String fieldName3="third_kind_name";
String fieldName4="second_kind_name";
String fieldName5="customer_ID";
String condition="";
if(trade.equals("")){
condition="check_tag='1'";
}else{
condition="type='"+trade+"' and check_tag='1'";
}
String queue="order by register_time";


sql=query.query(dbase,tablename,timea,timeb,first_kind_name,second_kind_name,third_kind_name,customer_ID,fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition,queue,realname);
}else{
String dbase=(String)dbSession.getAttribute("unit_db_name");
tablename="crm_order";
String fieldName1="register_time";
String fieldName2="first_kind_name";
String fieldName3="third_kind_name";
String fieldName4="second_kind_name";
String fieldName5="customer_ID";
String condition="";
if(trade.equals("")){
condition="check_tag='1'";
}else{
condition="type='"+trade+"' and check_tag='1'";
}
String queue="order by register_time";
sql=query.query(dbase,tablename,timea,timeb,first_kind_name,second_kind_name,third_kind_name,customer_ID,fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition,queue,realname);
}
int a=sql.indexOf("where");
sql=sql.substring(a,sql.length());
xls.setCondition(sql);
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
xls.write(path+"excel_files/crm_data.xls");
response.sendRedirect("crm/export/excel_ok_a.jsp");


}catch(Exception ex){}




}
}
