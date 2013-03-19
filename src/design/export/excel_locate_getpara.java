/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package design.export;
 
import include.nseer_cookie.*; 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.util.* ;
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
Masking mask = new Masking("xml/design/data_excel.xml");
Solid writer=new Solid("xml/design/excel_export.xml");

try{
String sql_search=request.getParameter("sql_search");
String timea=request.getParameter("timea");
String timeb=request.getParameter("timeb");
String type=request.getParameter("type");
if(type==null) type="111";
String first_kind_name="";
String second_kind_name="";
String third_kind_name="";
first_kind_name=request.getParameter("select1");
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

String responsible_person_name=request.getParameter("select4");
if(responsible_person_name==null) responsible_person_name="";
session.setAttribute("timea",timea);
session.setAttribute("timeb",timeb);
session.setAttribute("type",type);
session.setAttribute("first_kind_name",first_kind_name);
session.setAttribute("second_kind_name",second_kind_name);
session.setAttribute("third_kind_name",third_kind_name);
session.setAttribute("responsible_person_name",responsible_person_name);
if(!sql_search.equals("null")){
session.setAttribute("sql_search",sql_search);
}
   String tablenick=request.getParameter("tablenick");
   session.setAttribute("table",tablenick);
   String tablename=mask.getTableNameFormNick(tablenick);
   String[] cols=request.getParameterValues("col");

   if(cols==null){
	response.sendRedirect("design/export/excel_locate_getpara_a.jsp?tablenick="+toUtf8String.utf8String(exchange.toURL(tablenick))+"");
	}else{
	String[] colsName=new String[cols.length];
   for(int i=0;i<cols.length;i++) {
     colsName[i]=mask.getColumnName(tablenick,cols[i]);
   }
   writer.update(tablename,tablenick,colsName,cols);
   response.sendRedirect("design_export_excel_ok");
}

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 