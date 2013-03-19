/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.export;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.* ;
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
XlsWriter xls=new XlsWriter((String)dbSession.getAttribute("unit_db_name"),"xml/manufacture/excel_export.xml");
excel_three query=new excel_three();
getKeyColumn column=new getKeyColumn();

try{
String sql="";
String tablename="";
String realname=(String)session.getAttribute("realeditorc");
String table=(String)session.getAttribute("table");
String timea=(String)session.getAttribute("timea");
String timeb=(String)session.getAttribute("timeb");
String manufacture_ID=(String)session.getAttribute("manufacture_ID");
String keyword=(String)session.getAttribute("keyword");
if(table.equals("\u751f\u4ea7\u6d3e\u5de5\u5355")){
String dbase=(String)dbSession.getAttribute("unit_db_name");
tablename="manufacture_manufacture";
String fieldName1="register_time";
String fieldName2="manufacture_ID";
String[] fieldName3=column.Column(dbase,tablename);
String queue="order by register_time";
String condition="check_tag='1' and excel_tag='2' and manufacture_tag='1'";
sql=query.query(dbase,tablename,timea,timeb,manufacture_ID,keyword,fieldName1,fieldName2,fieldName3,condition,queue);
}

int a=sql.indexOf("where");
sql=sql.substring(a,sql.length());
xls.setCondition(sql);
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
xls.write(path+"excel_files/manufacture_data.xls");
response.sendRedirect("manufacture/export/excel_ok_a.jsp");

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 