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
import java.util.* ;
import java.io.* ;
import include.nseer_cookie.*;
import include.excel_export.Masking;
import include.excel_export.Solid;

public class excel_locate_getpara extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
Masking mask = new Masking("xml/stock/data_excel.xml");
Solid writer=new Solid("xml/stock/excel_export.xml");

try{
String second_kind_name="";
String third_kind_name="";
String first_kind_name=request.getParameter("select1");
if(first_kind_name==null) first_kind_name="";
String select2=request.getParameter("select2");
if(select2!=null&&!select2.equals("")){
StringTokenizer tokenTO1 = new StringTokenizer(select2,"/");        
            while(tokenTO1.hasMoreTokens()) {
                first_kind_name = tokenTO1.nextToken();
				second_kind_name = tokenTO1.nextToken();
		}
}
String select3=request.getParameter("select3");
if(select3!=null&&!select3.equals("")){
StringTokenizer tokenTO2 = new StringTokenizer(select3,"/");        
            while(tokenTO2.hasMoreTokens()) {
                first_kind_name = tokenTO2.nextToken();
				second_kind_name = tokenTO2.nextToken();
				third_kind_name = tokenTO2.nextToken();
		}
}
String product_name=request.getParameter("select4");
if(product_name==null) product_name="";
session.setAttribute("first_kind_name",first_kind_name);
session.setAttribute("second_kind_name",second_kind_name);
session.setAttribute("third_kind_name",third_kind_name);
session.setAttribute("product_name",product_name);
   String tablenick=request.getParameter("tablenick");
   session.setAttribute("table",tablenick);
   String tablename=mask.getTableNameFormNick(tablenick);
   String[] cols=request.getParameterValues("col");

   if(cols==null){
	response.sendRedirect("stock/export/excel_locate_getpara_a.jsp?tablenick="+toUtf8String.utf8String(exchange.toURL(tablenick))+"");
	}else{
	String[] colsName=new String[cols.length];
   for(int i=0;i<cols.length;i++) {
     colsName[i]=mask.getColumnName(tablenick,cols[i]);
   }
   writer.update(tablename,tablenick,colsName,cols);
   response.sendRedirect("stock_export_excel_ok");
}

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 