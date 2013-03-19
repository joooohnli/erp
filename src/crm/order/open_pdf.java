/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.order;


import javax.servlet.http.*;
import javax.servlet.*;
import java.io.* ;
public class open_pdf extends HttpServlet{
ServletContext application;
HttpSession session;


public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();

try{
String filename=(String)dbSession.getAttribute("pdfname");
response.sendRedirect("pdf_files/"+filename);   
}catch(Exception ex){
	ex.printStackTrace();
}
}
}