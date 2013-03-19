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
Masking mask = new Masking("xml/manufacture/data_excel.xml");
Solid writer=new Solid("xml/manufacture/excel_export.xml");

try{
String timea=request.getParameter("timea");
String timeb=request.getParameter("timeb");
String manufacture_ID=request.getParameter("manufacture_ID");
String keyword=request.getParameter("keyword");
if(timea==null) timea="";
if(timeb==null) timeb="";
if(manufacture_ID==null) manufacture_ID="";
if(keyword==null) keyword="";
session.setAttribute("timea",timea);
session.setAttribute("timeb",timeb);
session.setAttribute("manufacture_ID",manufacture_ID);
session.setAttribute("keyword",keyword);
   String tablenick=request.getParameter("tablenick");
   session.setAttribute("table",tablenick);
   String tablename=mask.getTableNameFormNick(tablenick);
   String[] cols=request.getParameterValues("col");

   if(cols==null){
	response.sendRedirect("manufacture/export/excel_locate_getpara_a.jsp?tablenick="+tablenick+"");
	}else{
	String[] colsName=new String[cols.length];
   for(int i=0;i<cols.length;i++) {
     colsName[i]=mask.getColumnName(tablenick,cols[i]);
   }
   writer.update(tablename,tablenick,colsName,cols);
   response.sendRedirect("manufacture_export_excel_ok");
}

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 