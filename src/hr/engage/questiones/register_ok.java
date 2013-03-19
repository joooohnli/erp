/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.engage.questiones;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*; 
import java.util.*;
import java.io.*;
import include.nseer_cookie.exchange;
import include.nseer_db.*;
import include.nseer_cookie.counter;


public class register_ok extends HttpServlet{
//创建方法
ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{


HttpSession session=request.getSession();
PrintWriter out=response.getWriter();

counter count=new  counter(dbApplication);

nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String first_kind_ID="";
String first_kind_name="";
String second_kind_ID="";
String second_kind_name="";
String first_kind=request.getParameter("select1");
StringTokenizer tokenTO4 = new StringTokenizer(first_kind,"/");        
	while(tokenTO4.hasMoreTokens()) {
        first_kind_ID = tokenTO4.nextToken();
		first_kind_name = tokenTO4.nextToken();
		}
String second_kind=request.getParameter("select2");
StringTokenizer tokenTO5 = new StringTokenizer(second_kind,"/");        
	while(tokenTO5.hasMoreTokens()) {
        second_kind_ID = tokenTO5.nextToken();
		second_kind_name = tokenTO5.nextToken();
		}
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String derivation=request.getParameter("derivation") ;
String body = new String(request.getParameter("body").getBytes("UTF-8"),"UTF-8");
String content=exchange.toHtml(body);
String bodya = new String(request.getParameter("bodya").getBytes("UTF-8"),"UTF-8");
String keya=exchange.toHtml(bodya);
String bodyb = new String(request.getParameter("bodyb").getBytes("UTF-8"),"UTF-8");
String keyb=exchange.toHtml(bodyb);
String bodyc = new String(request.getParameter("bodyc").getBytes("UTF-8"),"UTF-8");
String keyc=exchange.toHtml(bodyc);
String bodyd = new String(request.getParameter("bodyd").getBytes("UTF-8"),"UTF-8");
String keyd=exchange.toHtml(bodyd);
String bodye = new String(request.getParameter("bodye").getBytes("UTF-8"),"UTF-8");
String keye=exchange.toHtml(bodye);
String correctkey=request.getParameter("correctkey") ;
try{
	String sql = "insert into hr_questiones(first_kind_ID,second_kind_ID,first_kind_name,second_kind_name,register,register_time,derivation,content,keya,keyb,keyc,keyd,keye,correctkey) values ('"+first_kind_ID+"','"+second_kind_ID+"','"+first_kind_name+"','"+second_kind_name+"','"+register+"','"+register_time+"','"+derivation+"','"+content+"','"+keya+"','"+keyb+"','"+keyc+"','"+keyd+"','"+keye+"','"+correctkey+"')" ;
	hr_db.executeUpdate(sql) ;
	
}
catch (Exception ex){
out.println("error"+ex);
}
hr_db.commit();
hr_db.close();

response.sendRedirect("hr/engage/questiones/register_ok_a.jsp");

}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}


