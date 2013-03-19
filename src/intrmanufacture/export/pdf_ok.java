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
import javax.servlet.*;
import java.io.*; 
import include.nseer_db.*;
import include.excel_export.XlsWriter;
import include.excel_export.excel;
import include.nseer_cookie.MakePdf;
import include.excel_export.excel_three;
import include.get_sql.getKeyColumn;

public class pdf_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;


public synchronized void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
try{
HttpSession session=request.getSession();
PrintWriter out=response.getWriter();
HttpSession dbSession=request.getSession();

excel query=new  excel();
XlsWriter xls=new XlsWriter();
MakePdf mm=new MakePdf();
mm.setConfigFile("xml/intrmanufacture/pdf_export.xml");
excel_three query_three=new excel_three();
getKeyColumn column=new getKeyColumn();


String sql="";
String tablename=request.getParameter("tablename");
String condition="";
String queue="";
if(tablename.equals("intrmanufacture_file")){
condition="where check_tag='1'";
queue="order by register_time";
}else if(tablename.equals("intrmanufacture_discussion")){
condition="where check_tag!='3' and excel_tag='2'";
queue="order by register_time";
} else {
tablename="intrmanufacture_intrmanufacture";
queue="order by register_time";
condition="where check_tag='2' and excel_tag='2' and intrmanufacture_tag='2'";
}
sql="select * from "+tablename+" "+condition+" "+queue;
int a=sql.indexOf("*");
String sqla=sql.substring(0,a)+"count(*) as A"+sql.substring(a+1,sql.length());

mm.make("ondemand1",tablename,sqla,sql,"pdf_files/intrmanufacture_data",1500,session);
int fileAmount=mm.fileAmount();
response.sendRedirect("intrmanufacture/export/pdf_ok_a.jsp?file_amount="+fileAmount+"");


}catch(Exception ex){

ex.printStackTrace();
}




}
}
