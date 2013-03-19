/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.analyse;
 
 
import include.excel_export.XlsWriter;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

public class getStaticReport_excel extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
XlsWriter xls = new XlsWriter((String)dbSession.getAttribute("unit_db_name"),"xml/stock/static_report.xml");

try{
String static_report_ID=request.getParameter("static_report_ID");
String sql="where static_report_ID='"+static_report_ID+"'";
int a=sql.indexOf("where");
sql=sql.substring(a,sql.length());
xls.setCondition(sql);
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
xls.write(path+"excel_files/stock_report_data.xls");
response.sendRedirect("stock/analyse/getStaticReport_excel_a.jsp");

}
catch (Exception ex){
ex.printStackTrace();
}
}
}