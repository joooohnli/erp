 /*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.engage.resume;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;  
import java.io.*;
import include.nseer_db.*;
import include.nseer_cookie.*;
import com.jspsmart.upload.SmartUpload;

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
getFileLength getFileLength=new getFileLength();
HttpSession session=request.getSession();
PrintWriter out=response.getWriter();
SmartUpload mySmartUpload=new SmartUpload();
mySmartUpload.setCharset("UTF-8");
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){

	String file_type="jpg,gif";
long d=getFileLength.getFileLength((String)session.getAttribute("unit_db_name"));
mySmartUpload.setMaxFileSize(d);
mySmartUpload.setAllowedFilesList(file_type);


String details_number=request.getParameter("details_number");
	mySmartUpload.initialize(pageContext);
try{
	mySmartUpload.upload();
	com.jspsmart.upload.SmartFile myFile = mySmartUpload.getFiles().getFile(0);
	ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
	String file=details_number+myFile.getFileName().substring(myFile.getFileName().length()-4).toLowerCase();
	
	file=details_number+myFile.getFileName().substring(myFile.getFileName().length()-4,myFile.getFileName().length());
	myFile.saveAs(path+"hr/human_pictures/" + file);
	String sql="update hr_resume set picture='"+file+"' where details_number='"+details_number+"'";
	hr_db.executeUpdate(sql);

	response.sendRedirect("hr/engage/resume/register_choose_attachment.jsp?details_number="+details_number+"");
}catch(Exception ex){

response.sendRedirect("hr/engage/resume/register_ok_a.jsp?details_number="+details_number+"");

}

hr_db.commit();
hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}