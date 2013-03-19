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
import include.nseer_cookie.MakePdf;

public class pdf_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
 HttpSession session=request.getSession();
PrintWriter out=response.getWriter();

XlsWriter xls=new XlsWriter();
MakePdf mm=new MakePdf();
excel_three query=new excel_three();
getKeyColumn column=new getKeyColumn();
mm.setConfigFile("xml/manufacture/pdf_export.xml");

String sql="";
String tablename=request.getParameter("tablename");
String condition="";
String queue="";
if(tablename.equals("manufacture_manufacture")){
queue="order by register_time";
condition="where check_tag='1' and excel_tag='2' and manufacture_tag='1'";
}
sql="select * from "+tablename+" "+condition+" "+queue;
int a=sql.indexOf("*");
String sqla=sql.substring(0,a)+"count(*) as A"+sql.substring(a+1,sql.length());

mm.make((String)dbSession.getAttribute("unit_db_name"),tablename,sqla,sql,"pdf_files/manufacture_data",1500,session);
int fileAmount=mm.fileAmount();
response.sendRedirect("manufacture/export/pdf_ok_a.jsp?file_amount="+fileAmount+"");

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 