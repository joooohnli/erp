/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.auto_execute;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.*;
import java.util.*;

public class reset_ok extends HttpServlet{

public void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);


try{
//实例化

HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
String realpath=context.getRealPath("/");
String path="";
StringTokenizer tokenTO = new StringTokenizer(realpath.substring(0,realpath.length()-1),"\\");
while(tokenTO.hasMoreTokens()) {
	path+=tokenTO.nextToken()+"/";
}
String classpath=path+"WEB-INF/classes/";
response.sendRedirect("main/refresh.jsp");
}catch(Exception ex){
	ex.printStackTrace();
}
}
}