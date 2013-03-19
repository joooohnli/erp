/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package purchase.export;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.* ;
import include.excel_export.excel;
import include.excel_export.excel_three;
import include.get_sql.getKeyColumn;
import include.nseer_cookie.MakePdf;

public class pdf_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
 HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

 try{
ServletContext application;

  HttpSession session=request.getSession();
PrintWriter out=response.getWriter();
excel query=new excel();
excel_three query_three=new excel_three();
getKeyColumn column=new getKeyColumn();
MakePdf mm=new MakePdf();
mm.setConfigFile("xml/purchase/pdf_export.xml");

String sql="";
String tablename=request.getParameter("tablename");
String condition="";
String queue="";
if(tablename.equals("purchase_file")){
condition="where check_tag='1'";
queue="order by register_time";
}else if(tablename.equals("purchase_discussion")){
condition="where check_tag!='3' and excel_tag='2'";
queue="order by register_time";
}else{
tablename="purchase_purchase";
queue="order by register_time";
condition="where check_tag='2' and excel_tag='2' and purchase_tag='2'";
}
sql="select * from "+tablename+" "+condition+" "+queue;
int a=sql.indexOf("*");
String sqla=sql.substring(0,a)+"count(*) as A"+sql.substring(a+1,sql.length());

mm.make((String)dbSession.getAttribute("unit_db_name"),tablename,sqla,sql,"pdf_files/purchase_data",1500,session);
int fileAmount=mm.fileAmount();
response.sendRedirect("purchase/export/pdf_ok_a.jsp?file_amount="+fileAmount+"");

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 