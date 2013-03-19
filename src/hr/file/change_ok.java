/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.file;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.*;
import com.jspsmart.upload.SmartUpload;


public class change_ok extends HttpServlet{
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
SmartUpload mySmartUpload= new SmartUpload();
mySmartUpload.setCharset("UTF-8");
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String file_type="jpg,gif";
long d=getFileLength.getFileLength((String)session.getAttribute("unit_db_name"));
mySmartUpload.setMaxFileSize(d);
mySmartUpload.setAllowedFilesList(file_type);
String human_ID=request.getParameter("human_ID");
	mySmartUpload.initialize(pageContext);
try{
	mySmartUpload.upload();

	com.jspsmart.upload.SmartFile myFile = mySmartUpload.getFiles().getFile(0);
	ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
String file=human_ID+myFile.getFileName().substring(myFile.getFileName().length()-4).toLowerCase();

	myFile.saveAs(path+"hr/human_pictures/" + file);
	String sql="update hr_file set picture='"+file+"' where human_ID='"+human_ID+"'";
	hr_db.executeUpdate(sql);
	
	response.sendRedirect("hr/file/change_choose_attachment.jsp?human_ID="+human_ID+"");
}catch(Exception ex){
response.sendRedirect("hr/file/change_ok_a.jsp?human_ID="+human_ID+"");
}

 hr_db.commit();
 hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}
