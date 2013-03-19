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
import com.jspsmart.upload.SmartUpload;
import include.nseer_cookie.getFileLength;

public class change_ok extends HttpServlet{
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

nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
SmartUpload mySmartUpload= new SmartUpload();
mySmartUpload.setCharset("UTF-8");
getFileLength getFileLength=new getFileLength();

String human_ID=request.getParameter("human_ID");
	mySmartUpload.initialize(pageContext);
	mySmartUpload.upload();
	com.jspsmart.upload.SmartFile myFile = mySmartUpload.getFiles().getFile(0);
	ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
	String file=myFile.getFileName();
	int a=file.indexOf(".jpg");
int b=file.indexOf(".gif");
int c=myFile.getSize();
	double d=getFileLength.getFileLength((String)dbSession.getAttribute("unit_db_name"));
	if(c<d){
	myFile.saveAs(path+"hr/human_pictures/" + myFile.getFileName());
	String sql="update hr_file set picture='"+file+"' where human_ID='"+human_ID+"'";
	hr_db.executeUpdate(sql);
	

response.sendRedirect("hr/engage/resume/change_ok_a.jsp");


}else{


response.sendRedirect("hr/engage/resume/change_ok_a.jsp?human_ID="+human_ID+"");

}
hr_db.commit();
hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}


