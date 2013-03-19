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
XlsWriter xls=new XlsWriter((String)dbSession.getAttribute("unit_db_name"),"xml/stock/excel_export.xml");
excel query=new excel();
getKeyColumn column=new getKeyColumn();
try{
String sql="";
String tablename="";
String realname=(String)session.getAttribute("realeditorc");
String table=(String)session.getAttribute("table");
String product_name=(String)session.getAttribute("product_name");
if(table.equals("\u52a8\u6001\u5e93\u5b58")){
String dbase=(String)dbSession.getAttribute("unit_db_name");
tablename="stock_balance";
String fieldName1="register_time";
String fieldName2="product_name";
String fieldName3="address_group";
String fieldName4="type";
String fieldName5="product_describe";
String queue="order by chain_id";
String condition="address_group!=''";
sql=query.query(dbase,tablename,"","","","","",product_name,fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition,queue,realname);
}
int a=sql.indexOf("where");
sql=sql.substring(a,sql.length());
xls.setCondition(sql);
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
xls.write(path+"excel_files/stock_data.xls");
response.sendRedirect("stock/export/excel_ok_a.jsp");

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 