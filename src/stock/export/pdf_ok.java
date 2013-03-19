/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.export;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.* ;
import include.excel_export.excel;
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
MakePdf mm=new MakePdf();
excel query=new excel();
getKeyColumn column=new getKeyColumn();
mm.setConfigFile("xml/stock/pdf_export.xml");
String sql="";
String tablename=request.getParameter("tablename");
String condition="";
String queue="";
if(tablename.equals("stock_balance")){
queue="order by chain_ID";
condition="where address_group!=''";
}
sql="select * from "+tablename+" "+condition+" "+queue;
int a=sql.indexOf("*");
String sqla=sql.substring(0,a)+"count(*) as A"+sql.substring(a+1,sql.length());

mm.make((String)dbSession.getAttribute("unit_db_name"),tablename,sqla,sql,"pdf_files/stock_data",1500,session);
int fileAmount=mm.fileAmount();
response.sendRedirect("stock/export/pdf_ok_a.jsp?file_amount="+fileAmount+"");


}
catch (Exception ex){
ex.printStackTrace();
}
}
} 